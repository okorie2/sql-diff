/* =====================================================================
   Migration 0223
   - New: usp_DeleteInvoice
   ===================================================================== */

-- New: usp_DeleteInvoice
CREATE OR ALTER PROCEDURE dbo.usp_DeleteInvoice
    @Param1 DATETIME2(0),
    @Param2 BIT,
    @Param3 NVARCHAR(100),
    @Param4 BIT = 0,
    @Param5 NVARCHAR(255) = NULL
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
