/* =====================================================================
   Migration 0308
   - New: usp_ListAuthor
   - Updated: usp_ListReview
   ===================================================================== */

-- New: usp_ListAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ListAuthor
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListReview
CREATE OR ALTER PROCEDURE dbo.usp_ListReview
    @Param1 DATETIME2(0),
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(100),
    @Param4 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
