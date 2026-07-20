/* =====================================================================
   Migration 0244
   - New: usp_SearchInvoice
   ===================================================================== */

-- New: usp_SearchInvoice
CREATE OR ALTER PROCEDURE dbo.usp_SearchInvoice
    @Param1 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
