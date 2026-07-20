/* =====================================================================
   Migration 0189
   - New: usp_ListReview
   ===================================================================== */

-- New: usp_ListReview
CREATE OR ALTER PROCEDURE dbo.usp_ListReview
    @Param1 NVARCHAR(100) = NULL,
    @Param2 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
