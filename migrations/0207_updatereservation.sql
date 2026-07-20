/* =====================================================================
   Migration 0207
   - New: usp_UpdateReservation
   ===================================================================== */

-- New: usp_UpdateReservation
CREATE OR ALTER PROCEDURE dbo.usp_UpdateReservation
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT = 0
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
