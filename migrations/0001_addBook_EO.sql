CREATE OR ALTER PROCEDURE dbo.usp_AddBook
    @Title          NVARCHAR(255),
    @Author         NVARCHAR(255),
    @ISBN           VARCHAR(20)     = NULL,
    @Genre          NVARCHAR(100)   = NULL,
    @PublishedDate  DATE            = NULL,
    @Price          DECIMAL(10,2)   = NULL,
    @Quantity       INT             = 0,
    @NewBookId      INT             OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Books
        (
            Title,
            Author,
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
            @Author,
            @ISBN,
            @Genre,
            @PublishedDate,
            @Price,
            @Quantity,
            SYSUTCDATETIME()
        );

        SET @NewBookId = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO