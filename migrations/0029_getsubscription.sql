/* =====================================================================
   Migration 0029
   - New: usp_GetSubscription
   ===================================================================== */

-- New: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 NVARCHAR(100) = NULL,
    @Param2 VARCHAR(20),
    @Param3 VARCHAR(20),
    @Param4 DECIMAL(10,2),
    @Param5 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
