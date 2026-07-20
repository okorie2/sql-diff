/* =====================================================================
   Migration 0291
   - New: usp_AddShipment
   - Updated: usp_AddShipment
   - Updated: usp_UpdateGenre
   ===================================================================== */

-- New: usp_AddShipment
CREATE OR ALTER PROCEDURE dbo.usp_AddShipment
    @Param1 NVARCHAR(255),
    @Param2 BIT,
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(255) = NULL,
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

-- Updated: usp_AddShipment
CREATE OR ALTER PROCEDURE dbo.usp_AddShipment
    @Param1 DATE,
    @Param2 BIT,
    @Param3 BIT,
    @Param4 DATETIME2(0) = NULL,
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

-- Updated: usp_UpdateGenre
CREATE OR ALTER PROCEDURE dbo.usp_UpdateGenre
    @Param1 DATE,
    @Param2 BIT,
    @Param3 NVARCHAR(255),
    @Param4 DATETIME2(0),
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
