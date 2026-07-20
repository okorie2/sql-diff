/* =====================================================================
   Migration 0116
   - New: usp_RetireInvoice
   ===================================================================== */

-- New: usp_RetireInvoice
CREATE OR ALTER PROCEDURE dbo.usp_RetireInvoice
    @Param1 DECIMAL(10,2),
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 DECIMAL(10,2),
    @Param5 NVARCHAR(255)
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
