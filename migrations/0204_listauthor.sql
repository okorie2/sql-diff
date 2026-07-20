/* =====================================================================
   Migration 0204
   - New: usp_ListAuthor
   - Updated: usp_MergeReview
   ===================================================================== */

-- New: usp_ListAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ListAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_MergeReview
CREATE OR ALTER PROCEDURE dbo.usp_MergeReview
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DECIMAL(10,2),
    @Param4 INT = NULL
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
