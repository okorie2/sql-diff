/* =====================================================================
   Migration 0152
   - New: usp_UnpublishWarehouse
   ===================================================================== */

-- New: usp_UnpublishWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishWarehouse
    @Param1 INT = NULL,
    @Param2 DECIMAL(10,2),
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 BIT
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
        -- or remove the target row(s) in dbo.Warehouses.
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
