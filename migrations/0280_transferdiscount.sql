/* =====================================================================
   Migration 0280
   - New: usp_TransferDiscount
   - Updated: usp_ListReturn
   - Updated: usp_SearchWarehouse
   ===================================================================== */

-- New: usp_TransferDiscount
CREATE OR ALTER PROCEDURE dbo.usp_TransferDiscount
    @Param1 NVARCHAR(100) = NULL,
    @Param2 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Param1 IS NULL)
    BEGIN
        RAISERROR('@Param1 cannot be null.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- placeholder: real implementation would insert or
        -- update the target row(s) in dbo.Discounts.
        SELECT 1;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

-- Updated: usp_ListReturn
CREATE OR ALTER PROCEDURE dbo.usp_ListReturn
    @Param1 DATETIME2(0),
    @Param2 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SearchWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_SearchWarehouse
    @Param1 NVARCHAR(255) = NULL,
    @Param2 VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
