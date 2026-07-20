/* =====================================================================
   Migration 0005
   - Adds Language, Format, LowStockThreshold to dbo.Books
   - Updates dbo.usp_AddBook: Language/Format/LowStockThreshold params,
     format validation, low-stock audit warning
   - Updates dbo.usp_DeleteBook: @Force param to block deletion of
     in-stock books unless explicitly overridden
   - Updates dbo.usp_GetBookById: computed InStock flag, optional
     audit history result set
   - Introduces dbo.usp_SearchBooks: filtered, paginated book search
   ===================================================================== */

/* -----------------------------------------------------------------------
   1. Schema changes on dbo.Books (nullable / defaulted, backward
      compatible with existing rows).
   ----------------------------------------------------------------------- */
IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Books') AND name = 'Language'
)
BEGIN
    ALTER TABLE dbo.Books
        ADD Language NVARCHAR(50) NULL;
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Books') AND name = 'Format'
)
BEGIN
    ALTER TABLE dbo.Books
        ADD Format VARCHAR(20) NULL;
END
GO

IF NOT EXISTS (
    SELECT 1 FROM sys.columns
    WHERE object_id = OBJECT_ID('dbo.Books') AND name = 'LowStockThreshold'
)
BEGIN
    ALTER TABLE dbo.Books
        ADD LowStockThreshold INT NOT NULL DEFAULT 5;
END
GO

/* -----------------------------------------------------------------------
   2. dbo.usp_AddBook — adds Language, Format, LowStockThreshold.
      Validates @Format against an allowed set, and logs a
      LOW_STOCK_WARNING audit row when the inserted quantity is at or
      below the threshold.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_AddBook
    @Title              NVARCHAR(255),
    @AuthorName         NVARCHAR(255),
    @ISBN               VARCHAR(20)     = NULL,
    @Genre              NVARCHAR(100)   = NULL,
    @PublishedDate      DATE            = NULL,
    @Price              DECIMAL(10,2)   = NULL,
    @Quantity           INT             = 0,
    @PublisherName      NVARCHAR(255)   = NULL,
    @CoverImageUrl      NVARCHAR(500)   = NULL,
    @Language           NVARCHAR(50)    = 'English',
    @Format             VARCHAR(20)     = 'Paperback',
    @LowStockThreshold  INT             = 5,
    @NewBookId          INT             OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    /* -----------------------------------------------------------------
       1. INPUT VALIDATION
       ----------------------------------------------------------------- */
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

    IF (@LowStockThreshold IS NULL OR @LowStockThreshold < 0)
    BEGIN
        RAISERROR('usp_AddBook: @LowStockThreshold cannot be null or negative.', 16, 1);
        RETURN;
    END

    IF (@PublishedDate IS NOT NULL AND @PublishedDate > CAST(SYSUTCDATETIME() AS DATE))
    BEGIN
        RAISERROR('usp_AddBook: @PublishedDate cannot be in the future.', 16, 1);
        RETURN;
    END

    IF (@Format IS NOT NULL AND @Format NOT IN ('Hardcover', 'Paperback', 'Ebook', 'Audiobook'))
    BEGIN
        RAISERROR('usp_AddBook: @Format must be one of Hardcover, Paperback, Ebook, Audiobook.', 16, 1);
        RETURN;
    END

    IF (@Language IS NOT NULL AND LTRIM(RTRIM(@Language)) = '')
    BEGIN
        RAISERROR('usp_AddBook: @Language cannot be an empty string.', 16, 1);
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

        /* ---------------------------------------------------------------
           2. DUPLICATE CHECK
           --------------------------------------------------------------- */
        IF (@ISBN IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.Books WHERE ISBN = @ISBN))
        BEGIN
            RAISERROR('usp_AddBook: A book with ISBN %s already exists.', 16, 1, @ISBN);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        /* ---------------------------------------------------------------
           3. AUTHOR LOOKUP / CREATION
           --------------------------------------------------------------- */
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

        /* ---------------------------------------------------------------
           4. INSERT THE BOOK
           --------------------------------------------------------------- */
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
            Language,
            Format,
            LowStockThreshold,
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
            @Language,
            @Format,
            @LowStockThreshold,
            SYSUTCDATETIME()
        );

        SET @NewBookId = SCOPE_IDENTITY();

        /* ---------------------------------------------------------------
           5. AUDIT TRAIL
           --------------------------------------------------------------- */
        INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
        VALUES
        (
            @NewBookId,
            'INSERT',
            CONCAT(
                'Title=', @Title,
                '; AuthorID=', @AuthorID,
                '; ISBN=', ISNULL(@ISBN, 'N/A'),
                '; Publisher=', ISNULL(@PublisherName, 'N/A'),
                '; Format=', ISNULL(@Format, 'N/A'),
                '; Language=', ISNULL(@Language, 'N/A')
            )
        );

        /* ---------------------------------------------------------------
           6. LOW STOCK WARNING
           --------------------------------------------------------------- */
        IF (@Quantity <= @LowStockThreshold)
        BEGIN
            INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
            VALUES
            (
                @NewBookId,
                'LOW_STOCK_WARNING',
                CONCAT('Quantity=', @Quantity, '; Threshold=', @LowStockThreshold)
            );
        END

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
   3. dbo.usp_DeleteBook — adds @Force. By default, refuses to delete a
      book that still has stock on hand; @Force = 1 overrides this.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_DeleteBook
    @BookID INT,
    @Reason NVARCHAR(255) = NULL,
    @Force  BIT           = 0
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

        DECLARE @Title NVARCHAR(255), @ISBN VARCHAR(20), @AuthorID INT, @Quantity INT;

        SELECT
            @Title    = Title,
            @ISBN     = ISBN,
            @AuthorID = AuthorID,
            @Quantity = Quantity
        FROM dbo.Books
        WHERE BookID = @BookID;

        IF (@@ROWCOUNT = 0)
        BEGIN
            RAISERROR('usp_DeleteBook: No book found with BookID %d.', 16, 1, @BookID);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@Quantity > 0 AND @Force = 0)
        BEGIN
            RAISERROR('usp_DeleteBook: BookID %d still has %d unit(s) in stock. Pass @Force = 1 to override.', 16, 1, @BookID, @Quantity);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
        VALUES
        (
            @BookID,
            'DELETE',
            CONCAT(
                'Title=', @Title,
                '; AuthorID=', @AuthorID,
                '; ISBN=', ISNULL(@ISBN, 'N/A'),
                '; QuantityAtDeletion=', @Quantity,
                '; Forced=', @Force,
                '; Reason=', ISNULL(@Reason, 'N/A')
            )
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
   4. dbo.usp_GetBookById — adds a computed InStock flag and an
      optional second result set with audit history.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_GetBookById
    @BookID               INT,
    @IncludeAuditHistory  BIT = 0
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
        b.Language,
        b.Format,
        b.LowStockThreshold,
        CASE WHEN b.Quantity > 0 THEN 1 ELSE 0 END AS InStock,
        CASE WHEN b.Quantity <= b.LowStockThreshold THEN 1 ELSE 0 END AS IsLowStock,
        b.CreatedAt
    FROM dbo.Books b
    JOIN dbo.Authors a ON a.AuthorID = b.AuthorID
    WHERE b.BookID = @BookID;

    IF (@IncludeAuditHistory = 1)
    BEGIN
        SELECT
            AuditID,
            BookID,
            Action,
            ChangedBy,
            ChangedAt,
            Detail
        FROM dbo.BooksAudit
        WHERE BookID = @BookID
        ORDER BY ChangedAt DESC;
    END
END
GO

/* -----------------------------------------------------------------------
   5. dbo.usp_SearchBooks — new proc. Filtered, paginated search over
      dbo.Books, with a total-count output for building pagination UI.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_SearchBooks
    @Title         NVARCHAR(255)  = NULL,
    @AuthorName    NVARCHAR(255)  = NULL,
    @Genre         NVARCHAR(100)  = NULL,
    @MinPrice      DECIMAL(10,2)  = NULL,
    @MaxPrice      DECIMAL(10,2)  = NULL,
    @InStockOnly   BIT            = 0,
    @PageNumber    INT            = 1,
    @PageSize      INT            = 20,
    @TotalCount    INT            OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    IF (@PageNumber IS NULL OR @PageNumber < 1)
    BEGIN
        RAISERROR('usp_SearchBooks: @PageNumber must be 1 or greater.', 16, 1);
        RETURN;
    END

    IF (@PageSize IS NULL OR @PageSize < 1 OR @PageSize > 100)
    BEGIN
        RAISERROR('usp_SearchBooks: @PageSize must be between 1 and 100.', 16, 1);
        RETURN;
    END

    IF (@MinPrice IS NOT NULL AND @MaxPrice IS NOT NULL AND @MinPrice > @MaxPrice)
    BEGIN
        RAISERROR('usp_SearchBooks: @MinPrice cannot be greater than @MaxPrice.', 16, 1);
        RETURN;
    END

    ;WITH FilteredBooks AS
    (
        SELECT
            b.BookID,
            b.Title,
            a.AuthorName,
            b.Genre,
            b.Price,
            b.Quantity,
            b.Format,
            b.Language,
            b.CreatedAt
        FROM dbo.Books b
        JOIN dbo.Authors a ON a.AuthorID = b.AuthorID
        WHERE
            (@Title IS NULL OR b.Title LIKE '%' + @Title + '%')
            AND (@AuthorName IS NULL OR a.AuthorName LIKE '%' + @AuthorName + '%')
            AND (@Genre IS NULL OR b.Genre = @Genre)
            AND (@MinPrice IS NULL OR b.Price >= @MinPrice)
            AND (@MaxPrice IS NULL OR b.Price <= @MaxPrice)
            AND (@InStockOnly = 0 OR b.Quantity > 0)
    )
    SELECT @TotalCount = COUNT(*) FROM FilteredBooks;

    ;WITH FilteredBooks AS
    (
        SELECT
            b.BookID,
            b.Title,
            a.AuthorName,
            b.Genre,
            b.Price,
            b.Quantity,
            b.Format,
            b.Language,
            b.CreatedAt
        FROM dbo.Books b
        JOIN dbo.Authors a ON a.AuthorID = b.AuthorID
        WHERE
            (@Title IS NULL OR b.Title LIKE '%' + @Title + '%')
            AND (@AuthorName IS NULL OR a.AuthorName LIKE '%' + @AuthorName + '%')
            AND (@Genre IS NULL OR b.Genre = @Genre)
            AND (@MinPrice IS NULL OR b.Price >= @MinPrice)
            AND (@MaxPrice IS NULL OR b.Price <= @MaxPrice)
            AND (@InStockOnly = 0 OR b.Quantity > 0)
    )
    SELECT *
    FROM FilteredBooks
    ORDER BY Title
    OFFSET (@PageNumber - 1) * @PageSize ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO