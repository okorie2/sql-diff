/* =====================================================================
   Migration 0354
   - New: usp_GetInvoice
   - Updated: usp_RetireDiscount
   ===================================================================== */

-- New: usp_GetInvoice
CREATE OR ALTER PROCEDURE dbo.usp_GetInvoice
    @Param1 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_RetireDiscount
CREATE OR ALTER PROCEDURE dbo.usp_RetireDiscount
    @Param1 DATETIME2(0)
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
        -- or remove the target row(s) in dbo.Discounts.
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
