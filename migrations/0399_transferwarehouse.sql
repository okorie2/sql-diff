/* =====================================================================
   Migration 0399
   - New: usp_TransferWarehouse
   ===================================================================== */

-- New: usp_TransferWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_TransferWarehouse
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(255),
    @Param3 DATE,
    @Param4 INT,
    @Param5 DATE
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
