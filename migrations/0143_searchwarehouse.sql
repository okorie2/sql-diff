/* =====================================================================
   Migration 0143
   - New: usp_SearchWarehouse
   - Updated: usp_SyncShipment
   - Updated: usp_GetGenre
   ===================================================================== */

-- New: usp_SearchWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_SearchWarehouse
    @Param1 NVARCHAR(100),
    @Param2 VARCHAR(20),
    @Param3 INT,
    @Param4 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SyncShipment
CREATE OR ALTER PROCEDURE dbo.usp_SyncShipment
    @Param1 BIT,
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 NVARCHAR(255) = NULL,
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

-- Updated: usp_GetGenre
CREATE OR ALTER PROCEDURE dbo.usp_GetGenre
    @Param1 VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Genres
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
