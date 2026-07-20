/* =====================================================================
   Migration 0450
   - New: usp_PublishGenre
   ===================================================================== */

-- New: usp_PublishGenre
CREATE OR ALTER PROCEDURE dbo.usp_PublishGenre
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE,
    @Param3 BIT = 0
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
