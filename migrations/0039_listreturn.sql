/* =====================================================================
   Migration 0039
   - New: usp_ListReturn
   - Updated: usp_GetOrder
   ===================================================================== */

-- New: usp_ListReturn
CREATE OR ALTER PROCEDURE dbo.usp_ListReturn
    @Param1 DATE,
    @Param2 DATETIME2(0),
    @Param3 BIT,
    @Param4 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 VARCHAR(20),
    @Param2 DECIMAL(10,2),
    @Param3 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
