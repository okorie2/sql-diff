/* =====================================================================
   Migration 0044
   - New: usp_UpdateInvoice
   ===================================================================== */

-- New: usp_UpdateInvoice
CREATE OR ALTER PROCEDURE dbo.usp_UpdateInvoice
    @Param1 NVARCHAR(255),
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
