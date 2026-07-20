/* =====================================================================
   Migration 0473
   - New: usp_SearchReview
   ===================================================================== */

-- New: usp_SearchReview
CREATE OR ALTER PROCEDURE dbo.usp_SearchReview
    @Param1 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
