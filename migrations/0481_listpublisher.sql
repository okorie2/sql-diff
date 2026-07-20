/* =====================================================================
   Migration 0481
   - New: usp_ListPublisher
   ===================================================================== */

-- New: usp_ListPublisher
CREATE OR ALTER PROCEDURE dbo.usp_ListPublisher
    @Param1 BIT = 0,
    @Param2 DECIMAL(10,2),
    @Param3 VARCHAR(20) = NULL,
    @Param4 DATETIME2(0) = NULL,
    @Param5 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Publishers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
