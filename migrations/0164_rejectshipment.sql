/* =====================================================================
   Migration 0164
   - New: usp_RejectShipment
   - Updated: usp_AddShipment
   ===================================================================== */

-- New: usp_RejectShipment
CREATE OR ALTER PROCEDURE dbo.usp_RejectShipment
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 BIT = 0,
    @Param4 BIT,
    @Param5 DATE = NULL
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
        -- or remove the target row(s) in dbo.Shipments.
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

-- Updated: usp_AddShipment
CREATE OR ALTER PROCEDURE dbo.usp_AddShipment
    @Param1 DATE,
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(100)
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
