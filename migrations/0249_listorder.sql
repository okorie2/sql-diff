/* =====================================================================
   Migration 0249
   - New: usp_ListOrder
   ===================================================================== */

-- New: usp_ListOrder
CREATE OR ALTER PROCEDURE dbo.usp_ListOrder
    @Param1 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
