/* =====================================================================
   Migration 0417
   - New: usp_GetOrder
   ===================================================================== */

-- New: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 NVARCHAR(100),
    @Param2 DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
