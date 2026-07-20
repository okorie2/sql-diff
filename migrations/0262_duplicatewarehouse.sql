/* =====================================================================
   Migration 0262
   - New: usp_DuplicateWarehouse
   - Updated: usp_SearchInvoice
   ===================================================================== */

-- New: usp_DuplicateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateWarehouse
    @Param1 DATETIME2(0) = NULL,
    @Param2 INT
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
        -- update the target row(s) in dbo.Warehouses.
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

-- Updated: usp_SearchInvoice
CREATE OR ALTER PROCEDURE dbo.usp_SearchInvoice
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(100),
    @Param4 NVARCHAR(100) = NULL,
    @Param5 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
