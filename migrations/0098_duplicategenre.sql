/* =====================================================================
   Migration 0098
   - New: usp_DuplicateGenre
   ===================================================================== */

-- New: usp_DuplicateGenre
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateGenre
    @Param1 DECIMAL(10,2),
    @Param2 BIT,
    @Param3 VARCHAR(20),
    @Param4 NVARCHAR(100)
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
