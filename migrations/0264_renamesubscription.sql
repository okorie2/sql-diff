/* =====================================================================
   Migration 0264
   - New: usp_RenameSubscription
   - Updated: usp_ArchiveCustomer
   ===================================================================== */

-- New: usp_RenameSubscription
CREATE OR ALTER PROCEDURE dbo.usp_RenameSubscription
    @Param1 VARCHAR(20) = NULL,
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(100),
    @Param4 NVARCHAR(100),
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
        -- update the target row(s) in dbo.Subscriptions.
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

-- Updated: usp_ArchiveCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveCustomer
    @Param1 BIT,
    @Param2 DECIMAL(10,2),
    @Param3 BIT,
    @Param4 NVARCHAR(255) = NULL
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
        -- or remove the target row(s) in dbo.Customers.
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
