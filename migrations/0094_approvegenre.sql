/* =====================================================================
   Migration 0094
   - New: usp_ApproveGenre
   ===================================================================== */

-- New: usp_ApproveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ApproveGenre
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DATE,
    @Param4 INT,
    @Param5 DATE = NULL
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
