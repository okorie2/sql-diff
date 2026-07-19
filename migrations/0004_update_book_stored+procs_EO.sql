/* =====================================================================
   Migration 0004
   - Adds CoverImageUrl to dbo.Books (nullable, backward compatible)
   - Updates dbo.usp_AddBook to accept @CoverImageUrl
   - Updates dbo.usp_DeleteBook to accept an optional @Reason
   - Introduces dbo.usp_GetBookById (read-only lookup)
   ===================================================================== */

/* -----------------------------------------------------------------------
   1. Schema change: add CoverImageUrl column to dbo.Books if missing.
   ----------------------------------------------------------------------- */
IF NOT EXISTS (
    SELECT 1
    FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Books')
      AND name = 'CoverImageUrl'
)
BEGIN
    ALTER TABLE dbo.Books
        ADD CoverImageUrl NVARCHAR(500) NULL;
END
GO

/* -----------------------------------------------------------------------
   2. dbo.usp_AddBook — updated to accept an optional @CoverImageUrl.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_AddBook
    @Title          NVARCHAR(255),
    @AuthorName     NVARCHAR(255),
    @ISBN           VARCHAR(20)     = NULL,
    @Genre          NVARCHAR(100)   = NULL,
    @PublishedDate  DATE            = NULL,
    @Price          DECIMAL(10,2)   = NULL,
    @Quantity       INT             = 0,
    @PublisherName  NVARCHAR(255)   = NULL,
    @CoverImageUrl  NVARCHAR(500)   = NULL,
    @NewBookId      INT             OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Title IS NULL OR LTRIM(RTRIM(@Title)) = '')
    BEGIN
        RAISERROR('usp_AddBook: @Title cannot be null or empty.', 16, 1);
        RETURN;
    END

    IF (@AuthorName IS NULL OR LTRIM(RTRIM(@AuthorName)) = '')
    BEGIN
        RAISERROR('usp_AddBook: @AuthorName cannot be null or empty.', 16, 1);
        RETURN;
    END

    IF (@Price IS NOT NULL AND @Price < 0)
    BEGIN
        RAISERROR('usp_AddBook: @Price cannot be negative.', 16, 1);
        RETURN;
    END

    IF (@Quantity IS NULL OR @Quantity < 0)
    BEGIN
        RAISERROR('usp_AddBook: @Quantity cannot be null or negative.', 16, 1);
        RETURN;
    END

    IF (@PublishedDate IS NOT NULL AND @PublishedDate > CAST(SYSUTCDATETIME() AS DATE))
    BEGIN
        RAISERROR('usp_AddBook: @PublishedDate cannot be in the future.', 16, 1);
        RETURN;
    END

    IF (@ISBN IS NOT NULL)
    BEGIN
        DECLARE @CleanIsbn VARCHAR(20) = REPLACE(@ISBN, '-', '');

        IF (LEN(@CleanIsbn) NOT IN (10, 13) OR @CleanIsbn LIKE '%[^0-9Xx]%')
        BEGIN
            RAISERROR('usp_AddBook: @ISBN must be a valid 10 or 13 digit ISBN.', 16, 1);
            RETURN;
        END
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        IF (@ISBN IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.Books WHERE ISBN = @ISBN))
        BEGIN
            RAISERROR('usp_AddBook: A book with ISBN %s already exists.', 16, 1, @ISBN);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        DECLARE @AuthorID INT;

        SELECT @AuthorID = AuthorID
        FROM dbo.Authors
        WHERE AuthorName = @AuthorName;

        IF (@AuthorID IS NULL)
        BEGIN
            INSERT INTO dbo.Authors (AuthorName)
            VALUES (@AuthorName);

            SET @AuthorID = SCOPE_IDENTITY();
        END

        INSERT INTO dbo.Books
        (
            Title,
            AuthorID,
            ISBN,
            Genre,
            PublishedDate,
            Price,
            Quantity,
            PublisherName,
            CoverImageUrl,
            CreatedAt
        )
        VALUES
        (
            @Title,
            @AuthorID,
            @ISBN,
            @Genre,
            @PublishedDate,
            @Price,
            @Quantity,
            @PublisherName,
            @CoverImageUrl,
            SYSUTCDATETIME()
        );

        SET @NewBookId = SCOPE_IDENTITY();

        INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
        VALUES
        (
            @NewBookId,
            'INSERT',
            CONCAT('Title=', @Title, '; AuthorID=', @AuthorID, '; ISBN=', ISNULL(@ISBN, 'N/A'), '; Publisher=', ISNULL(@PublisherName, 'N/A'))
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------
   3. dbo.usp_DeleteBook — updated to accept an optional @Reason,
      recorded in the audit trail.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_DeleteBook
    @BookID INT,
    @Reason NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@BookID IS NULL)
    BEGIN
        RAISERROR('usp_DeleteBook: @BookID cannot be null.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @Title NVARCHAR(255), @ISBN VARCHAR(20), @AuthorID INT;

        SELECT
            @Title    = Title,
            @ISBN     = ISBN,
            @AuthorID = AuthorID
        FROM dbo.Books
        WHERE BookID = @BookID;

        IF (@@ROWCOUNT = 0)
        BEGIN
            RAISERROR('usp_DeleteBook: No book found with BookID %d.', 16, 1, @BookID);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
        VALUES
        (
            @BookID,
            'DELETE',
            CONCAT('Title=', @Title, '; AuthorID=', @AuthorID, '; ISBN=', ISNULL(@ISBN, 'N/A'), '; Reason=', ISNULL(@Reason, 'N/A'))
        );

        DELETE FROM dbo.Books
        WHERE BookID = @BookID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------
   4. dbo.usp_GetBookById — new proc. Read-only lookup, joined to Authors.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_GetBookById
    @BookID INT
AS
BEGIN
    SET NOCOUNT ON;

    IF (@BookID IS NULL)
    BEGIN
        RAISERROR('usp_GetBookById: @BookID cannot be null.', 16, 1);
        RETURN;
    END

    SELECT
        b.BookID,
        b.Title,
        a.AuthorName,
        b.ISBN,
        b.Genre,
        b.PublishedDate,
        b.Price,
        b.Quantity,
        b.PublisherName,
        b.CoverImageUrl,
        b.CreatedAt
    FROM dbo.Books b
    JOIN dbo.Authors a ON a.AuthorID = b.AuthorID
    WHERE b.BookID = @BookID;
END
GO