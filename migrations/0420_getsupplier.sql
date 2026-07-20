/* =====================================================================
   Migration 0420
   - New: usp_GetSupplier
   - Updated: usp_ListAuthor
   ===================================================================== */

-- New: usp_GetSupplier
CREATE OR ALTER PROCEDURE dbo.usp_GetSupplier
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20) = NULL,
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(100),
    @Param5 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ListAuthor
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
