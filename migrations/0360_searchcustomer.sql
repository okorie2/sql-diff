/* =====================================================================
   Migration 0360
   - New: usp_SearchCustomer
   ===================================================================== */

-- New: usp_SearchCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SearchCustomer
    @Param1 NVARCHAR(100),
    @Param2 BIT,
    @Param3 NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Customers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
