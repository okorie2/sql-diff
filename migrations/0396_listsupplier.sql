/* =====================================================================
   Migration 0396
   - New: usp_ListSupplier
   ===================================================================== */

-- New: usp_ListSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ListSupplier
    @Param1 INT = NULL,
    @Param2 INT = NULL,
    @Param3 DATETIME2(0),
    @Param4 INT = NULL,
    @Param5 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
