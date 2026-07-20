/* =====================================================================
   Migration 0060
   - New: usp_GetReturn
   ===================================================================== */

-- New: usp_GetReturn
CREATE OR ALTER PROCEDURE dbo.usp_GetReturn
    @Param1 INT,
    @Param2 DATETIME2(0) = NULL,
    @Param3 VARCHAR(20),
    @Param4 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
