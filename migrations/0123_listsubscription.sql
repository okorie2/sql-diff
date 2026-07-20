/* =====================================================================
   Migration 0123
   - New: usp_ListSubscription
   - Updated: usp_UpdateCustomer
   - Updated: usp_PublishAuthor
   ===================================================================== */

-- New: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_UpdateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_UpdateCustomer
    @Param1 BIT,
    @Param2 DECIMAL(10,2)
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

-- Updated: usp_PublishAuthor
CREATE OR ALTER PROCEDURE dbo.usp_PublishAuthor
    @Param1 DATETIME2(0),
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 INT = NULL,
    @Param4 NVARCHAR(255),
    @Param5 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Authors.
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
