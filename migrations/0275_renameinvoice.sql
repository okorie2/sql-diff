/* =====================================================================
   Migration 0275
   - New: usp_RenameInvoice
   - Updated: usp_SearchWarehouse
   ===================================================================== */

-- New: usp_RenameInvoice
CREATE OR ALTER PROCEDURE dbo.usp_RenameInvoice
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(255)
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

-- Updated: usp_SearchWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_SearchWarehouse
    @Param1 DATE,
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(100),
    @Param4 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
