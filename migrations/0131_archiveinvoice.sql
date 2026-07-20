/* =====================================================================
   Migration 0131
   - New: usp_ArchiveInvoice
   ===================================================================== */

-- New: usp_ArchiveInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveInvoice
    @Param1 INT,
    @Param2 NVARCHAR(255),
    @Param3 VARCHAR(20)
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
