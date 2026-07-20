/* =====================================================================
   Migration 0278
   - New: usp_ListSupplier
   ===================================================================== */

-- New: usp_ListSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ListSupplier
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(255),
    @Param3 INT,
    @Param4 INT,
    @Param5 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
