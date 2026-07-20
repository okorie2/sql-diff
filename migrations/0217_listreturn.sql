/* =====================================================================
   Migration 0217
   - New: usp_ListReturn
   - Updated: usp_ListAuthor
   ===================================================================== */

-- New: usp_ListReturn
CREATE OR ALTER PROCEDURE dbo.usp_ListReturn
    @Param1 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ListAuthor
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE = NULL,
    @Param3 NVARCHAR(100),
    @Param4 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
