/* =====================================================================
   Migration 0477
   - New: usp_UnpublishShipment
   - Updated: usp_UnpublishWarehouse
   ===================================================================== */

-- New: usp_UnpublishShipment
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishShipment
    @Param1 VARCHAR(20),
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(255)
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

-- Updated: usp_UnpublishWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishWarehouse
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 INT = NULL,
    @Param4 VARCHAR(20),
    @Param5 VARCHAR(20) = NULL
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
        -- or remove the target row(s) in dbo.Warehouses.
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
