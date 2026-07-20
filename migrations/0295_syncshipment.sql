/* =====================================================================
   Migration 0295
   - New: usp_SyncShipment
   - Updated: usp_SyncShipment
   - Updated: usp_SearchWarehouse
   ===================================================================== */

-- New: usp_SyncShipment
CREATE OR ALTER PROCEDURE dbo.usp_SyncShipment
    @Param1 DECIMAL(10,2) = NULL
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

-- Updated: usp_SyncShipment
CREATE OR ALTER PROCEDURE dbo.usp_SyncShipment
    @Param1 NVARCHAR(255),
    @Param2 DATE,
    @Param3 DECIMAL(10,2),
    @Param4 DECIMAL(10,2),
    @Param5 BIT
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

-- Updated: usp_SearchWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_SearchWarehouse
    @Param1 DATETIME2(0),
    @Param2 INT = NULL,
    @Param3 DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
