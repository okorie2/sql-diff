/* =====================================================================
   Migration 0365
   - New: usp_ListPublisher
   ===================================================================== */

-- New: usp_ListPublisher
CREATE OR ALTER PROCEDURE dbo.usp_ListPublisher
    @Param1 NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Publishers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
