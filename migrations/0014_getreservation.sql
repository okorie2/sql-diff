/* =====================================================================
   Migration 0014
   - New: usp_GetReservation
   - Updated: usp_AddSubscription
   ===================================================================== */

-- New: usp_GetReservation
CREATE OR ALTER PROCEDURE dbo.usp_GetReservation
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_AddSubscription
CREATE OR ALTER PROCEDURE dbo.usp_AddSubscription
    @Param1 DATE
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
        -- update the target row(s) in dbo.Subscriptions.
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
