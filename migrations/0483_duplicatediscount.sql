/* =====================================================================
   Migration 0483
   - New: usp_DuplicateDiscount
   - Updated: usp_AdjustShipment
   - Updated: usp_DuplicateWarehouse
   ===================================================================== */

-- New: usp_DuplicateDiscount
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateDiscount
    @Param1 NVARCHAR(255),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 INT
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

-- Updated: usp_AdjustShipment
CREATE OR ALTER PROCEDURE dbo.usp_AdjustShipment
    @Param1 INT = NULL,
    @Param2 NVARCHAR(100),
    @Param3 DECIMAL(10,2),
    @Param4 VARCHAR(20)
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

-- Updated: usp_DuplicateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateWarehouse
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE = NULL,
    @Param3 INT = NULL,
    @Param4 INT = NULL,
    @Param5 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Warehouses.
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
