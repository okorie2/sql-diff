/* =====================================================================
   Migration 0162
   - New: usp_DeleteShipment
   ===================================================================== */

-- New: usp_DeleteShipment
CREATE OR ALTER PROCEDURE dbo.usp_DeleteShipment
    @Param1 DATE,
    @Param2 INT = NULL,
    @Param3 BIT,
    @Param4 VARCHAR(20),
    @Param5 NVARCHAR(100)
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
        -- or remove the target row(s) in dbo.Shipments.
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
