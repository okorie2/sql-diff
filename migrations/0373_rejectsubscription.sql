/* =====================================================================
   Migration 0373
   - New: usp_RejectSubscription
   - Updated: usp_ListInvoice
   ===================================================================== */

-- New: usp_RejectSubscription
CREATE OR ALTER PROCEDURE dbo.usp_RejectSubscription
    @Param1 VARCHAR(20) = NULL,
    @Param2 BIT = 0,
    @Param3 NVARCHAR(100),
    @Param4 BIT = 0,
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

-- Updated: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
