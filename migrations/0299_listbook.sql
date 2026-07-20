/* =====================================================================
   Migration 0299
   - New: usp_ListBook
   - Updated: usp_AdjustGenre
   ===================================================================== */

-- New: usp_ListBook
CREATE OR ALTER PROCEDURE dbo.usp_ListBook
    @Param1 BIT = 0,
    @Param2 INT,
    @Param3 BIT,
    @Param4 NVARCHAR(100) = NULL,
    @Param5 NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Books
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_AdjustGenre
CREATE OR ALTER PROCEDURE dbo.usp_AdjustGenre
    @Param1 INT
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
