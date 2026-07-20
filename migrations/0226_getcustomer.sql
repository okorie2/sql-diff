/* =====================================================================
   Migration 0226
   - New: usp_GetCustomer
   - Updated: usp_SyncDiscount
   ===================================================================== */

-- New: usp_GetCustomer
CREATE OR ALTER PROCEDURE dbo.usp_GetCustomer
    @Param1 DATETIME2(0) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 BIT = 0,
    @Param4 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Customers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SyncDiscount
CREATE OR ALTER PROCEDURE dbo.usp_SyncDiscount
    @Param1 DATETIME2(0) = NULL,
    @Param2 VARCHAR(20),
    @Param3 INT = NULL
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
