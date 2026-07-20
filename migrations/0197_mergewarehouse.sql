/* =====================================================================
   Migration 0197
   - New: usp_MergeWarehouse
   - Updated: usp_UnpublishInvoice
   ===================================================================== */

-- New: usp_MergeWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 DECIMAL(10,2),
    @Param4 NVARCHAR(255),
    @Param5 INT = NULL
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

-- Updated: usp_UnpublishInvoice
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishInvoice
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(100) = NULL,
    @Param5 DECIMAL(10,2)
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
        -- or remove the target row(s) in dbo.Invoices.
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
