/* =====================================================================
   Migration 0118
   - New: usp_DuplicateCustomer
   - Updated: usp_TransferDiscount
   - Updated: usp_GetSubscription
   ===================================================================== */

-- New: usp_DuplicateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateCustomer
    @Param1 BIT,
    @Param2 INT = NULL
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
        -- update the target row(s) in dbo.Customers.
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

-- Updated: usp_TransferDiscount
CREATE OR ALTER PROCEDURE dbo.usp_TransferDiscount
    @Param1 DATETIME2(0) = NULL,
    @Param2 BIT = 0,
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

-- Updated: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 BIT = 0,
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
