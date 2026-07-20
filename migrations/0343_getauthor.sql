/* =====================================================================
   Migration 0343
   - New: usp_GetAuthor
   ===================================================================== */

-- New: usp_GetAuthor
CREATE OR ALTER PROCEDURE dbo.usp_GetAuthor
    @Param1 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
