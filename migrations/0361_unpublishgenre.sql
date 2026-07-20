/* =====================================================================
   Migration 0361
   - New: usp_UnpublishGenre
   - Updated: usp_RestoreReturn
   - Updated: usp_ValidatePublisher
   ===================================================================== */

-- New: usp_UnpublishGenre
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishGenre
    @Param1 BIT = 0,
    @Param2 VARCHAR(20),
    @Param3 DATETIME2(0) = NULL,
    @Param4 DATE = NULL
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

-- Updated: usp_RestoreReturn
CREATE OR ALTER PROCEDURE dbo.usp_RestoreReturn
    @Param1 DATE,
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(255),
    @Param4 DATETIME2(0) = NULL
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
        -- update the target row(s) in dbo.Returns.
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

-- Updated: usp_ValidatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_ValidatePublisher
    @Param1 DATE,
    @Param2 DATETIME2(0) = NULL,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(255)
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
        -- update the target row(s) in dbo.Publishers.
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
