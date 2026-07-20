/* =====================================================================
   Migration 0024
   - New: usp_RejectGenre
   - Updated: usp_GetReview
   ===================================================================== */

-- New: usp_RejectGenre
CREATE OR ALTER PROCEDURE dbo.usp_RejectGenre
    @Param1 BIT,
    @Param2 NVARCHAR(100) = NULL
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

-- Updated: usp_GetReview
CREATE OR ALTER PROCEDURE dbo.usp_GetReview
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
