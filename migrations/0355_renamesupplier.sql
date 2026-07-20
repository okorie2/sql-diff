/* =====================================================================
   Migration 0355
   - New: usp_RenameSupplier
   ===================================================================== */

-- New: usp_RenameSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(255),
    @Param4 NVARCHAR(100) = NULL
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
