/* =====================================================================
   Migration 0148
   - New: usp_ListBook
   ===================================================================== */

-- New: usp_ListBook
CREATE OR ALTER PROCEDURE dbo.usp_ListBook
    @Param1 BIT = 0,
    @Param2 VARCHAR(20) = NULL,
    @Param3 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Books
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
