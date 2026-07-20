/* =====================================================================
   Migration 0137
   - New: usp_GetGenre
   ===================================================================== */

-- New: usp_GetGenre
CREATE OR ALTER PROCEDURE dbo.usp_GetGenre
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DECIMAL(10,2),
    @Param3 DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Genres
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
