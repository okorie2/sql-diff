/* =====================================================================
   Migration 0072
   - New: usp_MergeWarehouse
   - Updated: usp_GetReview
   ===================================================================== */

-- New: usp_MergeWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
    @Param1 DECIMAL(10,2),
    @Param2 DECIMAL(10,2),
    @Param3 DATETIME2(0),
    @Param4 DECIMAL(10,2),
    @Param5 DATE
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

-- Updated: usp_GetReview
CREATE OR ALTER PROCEDURE dbo.usp_GetReview
    @Param1 VARCHAR(20),
    @Param2 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
