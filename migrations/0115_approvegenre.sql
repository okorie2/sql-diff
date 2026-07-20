/* =====================================================================
   Migration 0115
   - New: usp_ApproveGenre
   ===================================================================== */

-- New: usp_ApproveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ApproveGenre
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 INT,
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
