/* =====================================================================
   Migration 0445
   - New: usp_SyncSupplier
   ===================================================================== */

-- New: usp_SyncSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SyncSupplier
    @Param1 VARCHAR(20) = NULL,
    @Param2 INT,
    @Param3 VARCHAR(20),
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
