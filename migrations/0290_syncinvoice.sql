/* =====================================================================
   Migration 0290
   - New: usp_SyncInvoice
   ===================================================================== */

-- New: usp_SyncInvoice
CREATE OR ALTER PROCEDURE dbo.usp_SyncInvoice
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 VARCHAR(20),
    @Param4 NVARCHAR(255) = NULL,
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
