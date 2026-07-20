/* =====================================================================
   Migration 0315
   - New: usp_AdjustGenre
   - Updated: usp_DuplicatePublisher
   ===================================================================== */

-- New: usp_AdjustGenre
CREATE OR ALTER PROCEDURE dbo.usp_AdjustGenre
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100),
    @Param3 INT,
    @Param4 NVARCHAR(255) = NULL
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

-- Updated: usp_DuplicatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_DuplicatePublisher
    @Param1 INT,
    @Param2 VARCHAR(20),
    @Param3 VARCHAR(20)
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
