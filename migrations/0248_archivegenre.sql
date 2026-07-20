/* =====================================================================
   Migration 0248
   - New: usp_ArchiveGenre
   ===================================================================== */

-- New: usp_ArchiveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveGenre
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 VARCHAR(20) = NULL,
    @Param5 BIT = 0
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
