/* =====================================================================
   Migration 0106
   - New: usp_RenameSupplier
   ===================================================================== */

-- New: usp_RenameSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 BIT,
    @Param2 DATETIME2(0) = NULL,
    @Param3 VARCHAR(20) = NULL
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
        -- update the target row(s) in dbo.Suppliers.
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
