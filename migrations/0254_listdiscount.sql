/* =====================================================================
   Migration 0254
   - New: usp_ListDiscount
   - Updated: usp_AddReview
   ===================================================================== */

-- New: usp_ListDiscount
CREATE OR ALTER PROCEDURE dbo.usp_ListDiscount
    @Param1 DATE = NULL,
    @Param2 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_AddReview
CREATE OR ALTER PROCEDURE dbo.usp_AddReview
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
        -- update the target row(s) in dbo.Reviews.
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
