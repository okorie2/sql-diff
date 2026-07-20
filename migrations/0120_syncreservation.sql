/* =====================================================================
   Migration 0120
   - New: usp_SyncReservation
   - Updated: usp_UnpublishOrder
   ===================================================================== */

-- New: usp_SyncReservation
CREATE OR ALTER PROCEDURE dbo.usp_SyncReservation
    @Param1 BIT = 0,
    @Param2 NVARCHAR(100),
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(100) = NULL,
    @Param5 DATETIME2(0) = NULL
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

-- Updated: usp_UnpublishOrder
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishOrder
    @Param1 NVARCHAR(255)
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
        -- or remove the target row(s) in dbo.Orders.
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
