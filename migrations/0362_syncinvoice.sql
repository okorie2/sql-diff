/* =====================================================================
   Migration 0362
   - New: usp_SyncInvoice
   - Updated: usp_GetAuthor
   ===================================================================== */

-- New: usp_SyncInvoice
CREATE OR ALTER PROCEDURE dbo.usp_SyncInvoice
    @Param1 INT = NULL,
    @Param2 NVARCHAR(100),
    @Param3 INT,
    @Param4 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Param1 IS NULL)
    BEGIN
        RAISERROR('@Param1 cannot be null.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- placeholder: real implementation would insert or
        -- update the target row(s) in dbo.Invoices.
        SELECT 1;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

-- Updated: usp_GetAuthor
CREATE OR ALTER PROCEDURE dbo.usp_GetAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE = NULL,
    @Param3 DECIMAL(10,2),
    @Param4 BIT,
    @Param5 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
