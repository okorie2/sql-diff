/* =====================================================================
   Migration 0485
   - New: usp_SearchBook
   ===================================================================== */

-- New: usp_SearchBook
CREATE OR ALTER PROCEDURE dbo.usp_SearchBook
    @Param1 DATE = NULL,
    @Param2 INT = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 BIT,
    @Param5 DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Books
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
