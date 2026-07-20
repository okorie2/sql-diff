/* =====================================================================
   Migration 0203
   - New: usp_PublishPublisher
   - Updated: usp_DuplicateGenre
   ===================================================================== */

-- New: usp_PublishPublisher
CREATE OR ALTER PROCEDURE dbo.usp_PublishPublisher
    @Param1 NVARCHAR(255),
    @Param2 INT = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DECIMAL(10,2)
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

-- Updated: usp_DuplicateGenre
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateGenre
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(255),
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
