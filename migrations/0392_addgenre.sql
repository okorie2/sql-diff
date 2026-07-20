/* =====================================================================
   Migration 0392
   - New: usp_AddGenre
   ===================================================================== */

-- New: usp_AddGenre
CREATE OR ALTER PROCEDURE dbo.usp_AddGenre
    @Param1 NVARCHAR(255) = NULL,
    @Param2 VARCHAR(20),
    @Param3 DATE = NULL,
    @Param4 DATE = NULL,
    @Param5 NVARCHAR(255) = NULL
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
