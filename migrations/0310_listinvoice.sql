/* =====================================================================
   Migration 0310
   - New: usp_ListInvoice
   - Updated: usp_SearchSupplier
   ===================================================================== */

-- New: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 DATETIME2(0),
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SearchSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SearchSupplier
    @Param1 VARCHAR(20),
    @Param2 DATE = NULL,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(100),
    @Param5 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
