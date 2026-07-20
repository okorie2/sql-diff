/* =====================================================================
   Migration 0462
   - New: usp_DeleteSubscription
   - Updated: usp_AddSupplier
   ===================================================================== */

-- New: usp_DeleteSubscription
CREATE OR ALTER PROCEDURE dbo.usp_DeleteSubscription
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 INT = NULL,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 DATETIME2(0) = NULL
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

-- Updated: usp_AddSupplier
CREATE OR ALTER PROCEDURE dbo.usp_AddSupplier
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE,
    @Param3 BIT,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 INT = NULL
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
        -- update the target row(s) in dbo.Suppliers.
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
