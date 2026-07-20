/* =====================================================================
   Migration 0232
   - New: usp_RejectSupplier
   ===================================================================== */

-- New: usp_RejectSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RejectSupplier
    @Param1 DATE = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DATETIME2(0)
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
