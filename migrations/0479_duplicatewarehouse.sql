/* =====================================================================
   Migration 0479
   - New: usp_DuplicateWarehouse
   ===================================================================== */

-- New: usp_DuplicateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateWarehouse
    @Param1 BIT,
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0),
    @Param4 DATETIME2(0),
    @Param5 BIT
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
        -- update the target row(s) in dbo.Warehouses.
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
