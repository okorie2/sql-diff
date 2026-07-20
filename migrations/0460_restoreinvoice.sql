/* =====================================================================
   Migration 0460
   - New: usp_RestoreInvoice
   ===================================================================== */

-- New: usp_RestoreInvoice
CREATE OR ALTER PROCEDURE dbo.usp_RestoreInvoice
    @Param1 NVARCHAR(255),
    @Param2 INT = NULL,
    @Param3 DATETIME2(0) = NULL
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
