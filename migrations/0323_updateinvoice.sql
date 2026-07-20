/* =====================================================================
   Migration 0323
   - New: usp_UpdateInvoice
   - Updated: usp_GetDiscount
   - Updated: usp_PublishOrder
   ===================================================================== */

-- New: usp_UpdateInvoice
CREATE OR ALTER PROCEDURE dbo.usp_UpdateInvoice
    @Param1 BIT,
    @Param2 INT,
    @Param3 DECIMAL(10,2),
    @Param4 NVARCHAR(255),
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

-- Updated: usp_GetDiscount
CREATE OR ALTER PROCEDURE dbo.usp_GetDiscount
    @Param1 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_PublishOrder
CREATE OR ALTER PROCEDURE dbo.usp_PublishOrder
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(100)
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
        -- update the target row(s) in dbo.Orders.
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
