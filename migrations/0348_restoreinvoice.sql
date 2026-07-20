/* =====================================================================
   Migration 0348
   - New: usp_RestoreInvoice
   - Updated: usp_UnpublishWarehouse
   ===================================================================== */

-- New: usp_RestoreInvoice
CREATE OR ALTER PROCEDURE dbo.usp_RestoreInvoice
    @Param1 BIT,
    @Param2 VARCHAR(20),
    @Param3 NVARCHAR(255),
    @Param4 NVARCHAR(255) = NULL,
    @Param5 DECIMAL(10,2) = NULL
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

-- Updated: usp_UnpublishWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishWarehouse
    @Param1 DATE,
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0) = NULL,
    @Param4 NVARCHAR(100),
    @Param5 VARCHAR(20)
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
        -- or remove the target row(s) in dbo.Warehouses.
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
