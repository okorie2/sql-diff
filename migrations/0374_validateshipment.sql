/* =====================================================================
   Migration 0374
   - New: usp_ValidateShipment
   ===================================================================== */

-- New: usp_ValidateShipment
CREATE OR ALTER PROCEDURE dbo.usp_ValidateShipment
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 BIT = 0
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
