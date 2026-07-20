/* =====================================================================
   Migration 0318
   - New: usp_ListSubscription
   - Updated: usp_GetSubscription
   ===================================================================== */

-- New: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 NVARCHAR(255) = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 DATE,
    @Param4 DATETIME2(0),
    @Param5 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 INT = NULL,
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
