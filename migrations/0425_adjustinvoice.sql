/* =====================================================================
   Migration 0425
   - New: usp_AdjustInvoice
   - Updated: usp_ListOrder
   ===================================================================== */

-- New: usp_AdjustInvoice
CREATE OR ALTER PROCEDURE dbo.usp_AdjustInvoice
    @Param1 BIT = 0,
    @Param2 BIT
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

-- Updated: usp_ListOrder
CREATE OR ALTER PROCEDURE dbo.usp_ListOrder
    @Param1 DECIMAL(10,2),
    @Param2 BIT = 0,
    @Param3 BIT,
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
