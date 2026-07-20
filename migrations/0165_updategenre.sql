/* =====================================================================
   Migration 0165
   - Updated: usp_UpdateGenre
   ===================================================================== */

-- Updated: usp_UpdateGenre
CREATE OR ALTER PROCEDURE dbo.usp_UpdateGenre
    @Param1 VARCHAR(20) = NULL,
    @Param2 DECIMAL(10,2),
    @Param3 BIT = 0,
    @Param4 VARCHAR(20),
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
