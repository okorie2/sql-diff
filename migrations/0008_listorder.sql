/* =====================================================================
   Migration 0008
   - New: usp_ListOrder
   ===================================================================== */

-- New: usp_ListOrder
CREATE OR ALTER PROCEDURE dbo.usp_ListOrder
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
