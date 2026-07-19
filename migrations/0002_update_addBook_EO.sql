/* =====================================================================
   Supporting tables (created only if they don't already exist).
   Adjust/remove this block if Authors / BooksAudit already exist
   in your schema with different columns.
   ===================================================================== */

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Authors' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.Authors
    (
        AuthorID    INT IDENTITY(1,1) PRIMARY KEY,
        AuthorName  NVARCHAR(255) NOT NULL UNIQUE,
        CreatedAt   DATETIME2(0)  NOT NULL DEFAULT SYSUTCDATETIME()
    );
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'BooksAudit' AND schema_id = SCHEMA_ID('dbo'))
BEGIN
    CREATE TABLE dbo.BooksAudit
    (
        AuditID     INT IDENTITY(1,1) PRIMARY KEY,
        BookID      INT           NOT NULL,
        Action      VARCHAR(20)   NOT NULL,   -- e.g. 'INSERT'
        ChangedBy   SYSNAME       NOT NULL DEFAULT SUSER_SNAME(),
        ChangedAt   DATETIME2(0)  NOT NULL DEFAULT SYSUTCDATETIME(),
        Detail      NVARCHAR(MAX) NULL
    );
END
GO

/* =====================================================================
   dbo.Books is assumed to have an AuthorID FK instead of a text Author
   column. If your table still has a text Author column, migrate it to
   AuthorID before using this version of the proc.
   ===================================================================== */

CREATE OR ALTER PROCEDURE dbo.usp_AddBook
    @Title          NVARCHAR(255),
    @AuthorName     NVARCHAR(255),
    @ISBN           VARCHAR(20)     = NULL,
    @Genre          NVARCHAR(100)   = NULL,
    @PublishedDate  DATE            = NULL,
    @Price          DECIMAL(10,2)   = NULL,
    @Quantity       INT             = 0,
    @NewBookId      INT             OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;  -- ensure any error automatically rolls back the tx

    /* -----------------------------------------------------------------
       1. INPUT VALIDATION
       Fail fast with clear, specific error messages before opening
       a transaction or touching any table.
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

    IF (@PublishedDate IS NOT NULL AND @PublishedDate > CAST(SYSUTCDATETIME() AS DATE))
    BEGIN
        RAISERROR('usp_AddBook: @PublishedDate cannot be in the future.', 16, 1);
        RETURN;
    END

    -- Basic ISBN sanity check: allow NULL, or 10/13 digits with optional hyphens.
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

        /* -------------------------------------------------------------
           2. DUPLICATE CHECK
           Prevent the same ISBN being inserted twice (e.g. from a
           double-submitted form or a retried API call).
           ------------------------------------------------------------- */
        IF (@ISBN IS NOT NULL AND EXISTS (SELECT 1 FROM dbo.Books WHERE ISBN = @ISBN))
        BEGIN
            RAISERROR('usp_AddBook: A book with ISBN %s already exists.', 16, 1, @ISBN);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        /* -------------------------------------------------------------
           3. AUTHOR LOOKUP / CREATION
           Normalize authors into their own table instead of storing
           free text on every book row, so the same author is never
           spelled two different ways across records.
           ------------------------------------------------------------- */
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

        /* -------------------------------------------------------------
           4. INSERT THE BOOK
           ------------------------------------------------------------- */
        INSERT INTO dbo.Books
        (
            Title,
            AuthorID,
            ISBN,
            Genre,
            PublishedDate,
            Price,
            Quantity,
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
            SYSUTCDATETIME()
        );

        SET @NewBookId = SCOPE_IDENTITY();

        /* -------------------------------------------------------------
           5. AUDIT TRAIL
           Record who added the book and when, independent of any
           application-level logging, so DB-level changes are always
           traceable.
           ------------------------------------------------------------- */
        INSERT INTO dbo.BooksAudit (BookID, Action, Detail)
        VALUES
        (
            @NewBookId,
            'INSERT',
            CONCAT('Title=', @Title, '; AuthorID=', @AuthorID, '; ISBN=', ISNULL(@ISBN, 'N/A'))
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