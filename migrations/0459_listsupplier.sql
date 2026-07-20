/* =====================================================================
   Migration 0459
   - New: usp_ListSupplier
   - Updated: usp_ValidateWarehouse
   ===================================================================== */

-- New: usp_ListSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ListSupplier
    @Param1 NVARCHAR(255) = NULL,
    @Param2 BIT = 0,
    @Param3 DATETIME2(0) = NULL,
    @Param4 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ValidateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_ValidateWarehouse
    @Param1 BIT = 0,
    @Param2 INT,
    @Param3 INT,
    @Param4 BIT = 0,
    @Param5 DATETIME2(0)
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
