/* =====================================================================
   Migration 0133
   - New: usp_SearchSupplier
   ===================================================================== */

-- New: usp_SearchSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SearchSupplier
    @Param1 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
