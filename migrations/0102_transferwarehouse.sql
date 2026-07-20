/* =====================================================================
   Migration 0102
   - New: usp_TransferWarehouse
   - Updated: usp_MergeInvoice
   ===================================================================== */

-- New: usp_TransferWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_TransferWarehouse
    @Param1 NVARCHAR(255),
    @Param2 VARCHAR(20) = NULL,
    @Param3 INT = NULL,
    @Param4 DATETIME2(0) = NULL
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

-- Updated: usp_MergeInvoice
CREATE OR ALTER PROCEDURE dbo.usp_MergeInvoice
    @Param1 INT,
    @Param2 VARCHAR(20),
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 DATE = NULL,
    @Param5 BIT = 0
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
