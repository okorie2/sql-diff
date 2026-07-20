/* =====================================================================
   Migration 0395
   - New: usp_UpdateSubscription
   - Updated: usp_TransferWarehouse
   - Updated: usp_UnpublishGenre
   ===================================================================== */

-- New: usp_UpdateSubscription
CREATE OR ALTER PROCEDURE dbo.usp_UpdateSubscription
    @Param1 INT = NULL,
    @Param2 NVARCHAR(255),
    @Param3 DATETIME2(0) = NULL,
    @Param4 DATE = NULL,
    @Param5 DECIMAL(10,2)
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

-- Updated: usp_TransferWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_TransferWarehouse
    @Param1 VARCHAR(20) = NULL,
    @Param2 DATETIME2(0),
    @Param3 VARCHAR(20),
    @Param4 DATETIME2(0) = NULL,
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

-- Updated: usp_UnpublishGenre
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishGenre
    @Param1 DATE = NULL,
    @Param2 VARCHAR(20)
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
        -- or remove the target row(s) in dbo.Genres.
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
