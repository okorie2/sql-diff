/* =====================================================================
   Migration 0146
   - New: usp_ValidateWarehouse
   - Updated: usp_ArchiveSupplier
   ===================================================================== */

-- New: usp_ValidateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_ValidateWarehouse
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 NVARCHAR(255),
    @Param4 DATE = NULL,
    @Param5 VARCHAR(20) = NULL
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

-- Updated: usp_ArchiveSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveSupplier
    @Param1 INT,
    @Param2 VARCHAR(20),
    @Param3 VARCHAR(20) = NULL,
    @Param4 DATE = NULL,
    @Param5 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF (@Param1 IS NULL)
        BEGIN
            RAISERROR('@Param1 cannot be null.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- placeholder: real implementation would update
        -- or remove the target row(s) in dbo.Suppliers.
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
