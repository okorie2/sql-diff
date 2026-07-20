/* =====================================================================
   Migration 0144
   - New: usp_UpdateGenre
   - Updated: usp_UpdateCustomer
   - Updated: usp_SyncShipment
   ===================================================================== */

-- New: usp_UpdateGenre
CREATE OR ALTER PROCEDURE dbo.usp_UpdateGenre
    @Param1 INT = NULL,
    @Param2 INT = NULL,
    @Param3 VARCHAR(20),
    @Param4 INT = NULL,
    @Param5 DECIMAL(10,2) = NULL
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
        -- update the target row(s) in dbo.Genres.
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

-- Updated: usp_UpdateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_UpdateCustomer
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100),
    @Param3 VARCHAR(20) = NULL,
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 NVARCHAR(100)
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
        -- update the target row(s) in dbo.Customers.
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
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE,
    @Param3 BIT,
    @Param4 DATE,
    @Param5 BIT = 0
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
