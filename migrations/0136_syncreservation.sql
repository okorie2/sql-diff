/* =====================================================================
   Migration 0136
   - New: usp_SyncReservation
   - Updated: usp_DeleteSubscription
   ===================================================================== */

-- New: usp_SyncReservation
CREATE OR ALTER PROCEDURE dbo.usp_SyncReservation
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 VARCHAR(20) = NULL
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

-- Updated: usp_DeleteSubscription
CREATE OR ALTER PROCEDURE dbo.usp_DeleteSubscription
    @Param1 DECIMAL(10,2),
    @Param2 DECIMAL(10,2),
    @Param3 INT = NULL,
    @Param4 DATE
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
        -- or remove the target row(s) in dbo.Subscriptions.
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
