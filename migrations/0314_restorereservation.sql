/* =====================================================================
   Migration 0314
   - New: usp_RestoreReservation
   ===================================================================== */

-- New: usp_RestoreReservation
CREATE OR ALTER PROCEDURE dbo.usp_RestoreReservation
    @Param1 INT = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 INT = NULL
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
