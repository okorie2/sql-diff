/* =====================================================================
   Migration 0201
   - New: usp_SyncReservation
   ===================================================================== */

-- New: usp_SyncReservation
CREATE OR ALTER PROCEDURE dbo.usp_SyncReservation
    @Param1 NVARCHAR(255) = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 INT
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
        -- update the target row(s) in dbo.Reservations.
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
