/* =====================================================================
   Migration 0404
   - New: usp_ListPublisher
   - Updated: usp_GetWarehouse
   ===================================================================== */

-- New: usp_ListPublisher
CREATE OR ALTER PROCEDURE dbo.usp_ListPublisher
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Publishers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_GetWarehouse
    @Param1 NVARCHAR(100) = NULL,
    @Param2 INT,
    @Param3 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
