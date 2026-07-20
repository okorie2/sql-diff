/* =====================================================================
   Migration 0198
   - New: usp_GetOrder
   - Updated: usp_MergeWarehouse
   ===================================================================== */

-- New: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 INT = NULL,
    @Param2 INT = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 NVARCHAR(100) = NULL,
    @Param5 INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_MergeWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
    @Param1 VARCHAR(20) = NULL,
    @Param2 DATE = NULL,
    @Param3 NVARCHAR(255)
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
        -- update the target row(s) in dbo.Warehouses.
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
