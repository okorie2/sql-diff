/* =====================================================================
   Migration 0138
   - New: usp_ListGenre
   - Updated: usp_SearchSupplier
   - Updated: usp_ListSubscription
   ===================================================================== */

-- New: usp_ListGenre
CREATE OR ALTER PROCEDURE dbo.usp_ListGenre
    @Param1 DATETIME2(0),
    @Param2 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Genres
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SearchSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SearchSupplier
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(255),
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 VARCHAR(20),
    @Param5 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
