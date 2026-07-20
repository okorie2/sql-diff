/* =====================================================================
   Migration 0464
   - New: usp_ValidateReservation
   - Updated: usp_RejectReservation
   ===================================================================== */

-- New: usp_ValidateReservation
CREATE OR ALTER PROCEDURE dbo.usp_ValidateReservation
    @Param1 VARCHAR(20) = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(100),
    @Param5 DATETIME2(0)
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

-- Updated: usp_RejectReservation
CREATE OR ALTER PROCEDURE dbo.usp_RejectReservation
    @Param1 VARCHAR(20) = NULL,
    @Param2 BIT = 0,
    @Param3 INT = NULL,
    @Param4 BIT
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
