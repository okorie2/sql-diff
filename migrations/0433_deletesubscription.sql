/* =====================================================================
   Migration 0433
   - New: usp_DeleteSubscription
   - Updated: usp_PublishCustomer
   ===================================================================== */

-- New: usp_DeleteSubscription
CREATE OR ALTER PROCEDURE dbo.usp_DeleteSubscription
    @Param1 NVARCHAR(255),
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 DATE,
    @Param5 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF (@Param1 IS NULL)
        BEGIN
            RAISERROR('@Param1 cannot be null.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- placeholder: real implementation would update
        -- or remove the target row(s) in dbo.Subscriptions.
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

-- Updated: usp_PublishCustomer
CREATE OR ALTER PROCEDURE dbo.usp_PublishCustomer
    @Param1 DATE = NULL,
    @Param2 BIT = 0,
    @Param3 DATETIME2(0),
    @Param4 NVARCHAR(100),
    @Param5 NVARCHAR(100)
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
