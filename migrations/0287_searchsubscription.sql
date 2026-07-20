/* =====================================================================
   Migration 0287
   - New: usp_SearchSubscription
   ===================================================================== */

-- New: usp_SearchSubscription
CREATE OR ALTER PROCEDURE dbo.usp_SearchSubscription
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
