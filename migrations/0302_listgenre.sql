/* =====================================================================
   Migration 0302
   - New: usp_ListGenre
   ===================================================================== */

-- New: usp_ListGenre
CREATE OR ALTER PROCEDURE dbo.usp_ListGenre
    @Param1 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Genres
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
