/* =====================================================================
   Migration 0384
   - New: usp_SearchDiscount
   ===================================================================== */

-- New: usp_SearchDiscount
CREATE OR ALTER PROCEDURE dbo.usp_SearchDiscount
    @Param1 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
