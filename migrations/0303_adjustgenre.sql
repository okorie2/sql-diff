/* =====================================================================
   Migration 0303
   - Updated: usp_AdjustGenre
   - Updated: usp_GetDiscount
   ===================================================================== */

-- Updated: usp_AdjustGenre
CREATE OR ALTER PROCEDURE dbo.usp_AdjustGenre
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 INT = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DECIMAL(10,2) = NULL
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

-- Updated: usp_GetDiscount
CREATE OR ALTER PROCEDURE dbo.usp_GetDiscount
    @Param1 DATE = NULL,
    @Param2 DATE,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
