/* =====================================================================
   Migration 0405
   - New: usp_SearchWarehouse
   - Updated: usp_ApproveGenre
   ===================================================================== */

-- New: usp_SearchWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_SearchWarehouse
    @Param1 NVARCHAR(255),
    @Param2 BIT,
    @Param3 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ApproveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ApproveGenre
    @Param1 DATE
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
