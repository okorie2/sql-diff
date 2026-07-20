/* =====================================================================
   Migration 0048
   - Updated: usp_ListReturn
   ===================================================================== */

-- Updated: usp_ListReturn
CREATE OR ALTER PROCEDURE dbo.usp_ListReturn
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 VARCHAR(20),
    @Param3 NVARCHAR(255) = NULL,
    @Param4 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
