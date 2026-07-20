/* =====================================================================
   Migration 0081
   - New: usp_RestoreShipment
   ===================================================================== */

-- New: usp_RestoreShipment
CREATE OR ALTER PROCEDURE dbo.usp_RestoreShipment
    @Param1 DATE = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(255),
    @Param5 VARCHAR(20) = NULL
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
