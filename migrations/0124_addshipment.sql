/* =====================================================================
   Migration 0124
   - New: usp_AddShipment
   ===================================================================== */

-- New: usp_AddShipment
CREATE OR ALTER PROCEDURE dbo.usp_AddShipment
    @Param1 DECIMAL(10,2),
    @Param2 VARCHAR(20),
    @Param3 DATETIME2(0) = NULL,
    @Param4 BIT = 0
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
        -- update the target row(s) in dbo.Shipments.
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
