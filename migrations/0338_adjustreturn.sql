/* =====================================================================
   Migration 0338
   - New: usp_AdjustReturn
   - Updated: usp_ListReview
   ===================================================================== */

-- New: usp_AdjustReturn
CREATE OR ALTER PROCEDURE dbo.usp_AdjustReturn
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATETIME2(0)
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
        -- update the target row(s) in dbo.Returns.
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

-- Updated: usp_ListReview
CREATE OR ALTER PROCEDURE dbo.usp_ListReview
    @Param1 VARCHAR(20) = NULL,
    @Param2 INT,
    @Param3 BIT,
    @Param4 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
