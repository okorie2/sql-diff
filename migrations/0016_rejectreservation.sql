/* =====================================================================
   Migration 0016
   - New: usp_RejectReservation
   - Updated: usp_GetReservation
   ===================================================================== */

-- New: usp_RejectReservation
CREATE OR ALTER PROCEDURE dbo.usp_RejectReservation
    @Param1 NVARCHAR(100) = NULL
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
        -- or remove the target row(s) in dbo.Reservations.
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

-- Updated: usp_GetReservation
CREATE OR ALTER PROCEDURE dbo.usp_GetReservation
    @Param1 DECIMAL(10,2),
    @Param2 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
