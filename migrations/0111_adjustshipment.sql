/* =====================================================================
   Migration 0111
   - New: usp_AdjustShipment
   - Updated: usp_SyncDiscount
   ===================================================================== */

-- New: usp_AdjustShipment
CREATE OR ALTER PROCEDURE dbo.usp_AdjustShipment
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 DATETIME2(0) = NULL
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

-- Updated: usp_SyncDiscount
CREATE OR ALTER PROCEDURE dbo.usp_SyncDiscount
    @Param1 DATE,
    @Param2 DECIMAL(10,2),
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
        -- update the target row(s) in dbo.Discounts.
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
