/* =====================================================================
   Migration 0319
   - New: usp_MergeInvoice
   - Updated: usp_AddSubscription
   ===================================================================== */

-- New: usp_MergeInvoice
CREATE OR ALTER PROCEDURE dbo.usp_MergeInvoice
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Invoices.
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

-- Updated: usp_AddSubscription
CREATE OR ALTER PROCEDURE dbo.usp_AddSubscription
    @Param1 BIT,
    @Param2 INT,
    @Param3 DATE,
    @Param4 VARCHAR(20) = NULL,
    @Param5 NVARCHAR(255)
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
