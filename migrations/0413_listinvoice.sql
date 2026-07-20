/* =====================================================================
   Migration 0413
   - New: usp_ListInvoice
   - Updated: usp_ListInvoice
   ===================================================================== */

-- New: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 NVARCHAR(100) = NULL,
    @Param2 INT = NULL,
    @Param3 BIT,
    @Param4 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
