/* =====================================================================
   Migration 0414
   - New: usp_GetShipment
   - Updated: usp_GetDiscount
   ===================================================================== */

-- New: usp_GetShipment
CREATE OR ALTER PROCEDURE dbo.usp_GetShipment
    @Param1 DATE,
    @Param2 DECIMAL(10,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Shipments
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetDiscount
CREATE OR ALTER PROCEDURE dbo.usp_GetDiscount
    @Param1 DATE,
    @Param2 INT = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 DATETIME2(0) = NULL,
    @Param5 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
