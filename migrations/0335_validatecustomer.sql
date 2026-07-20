/* =====================================================================
   Migration 0335
   - New: usp_ValidateCustomer
   - Updated: usp_UnpublishInvoice
   - Updated: usp_DeleteInvoice
   ===================================================================== */

-- New: usp_ValidateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ValidateCustomer
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(100),
    @Param4 VARCHAR(20),
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

-- Updated: usp_UnpublishInvoice
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishInvoice
    @Param1 NVARCHAR(100),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 NVARCHAR(100)
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
        -- or remove the target row(s) in dbo.Invoices.
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

-- Updated: usp_DeleteInvoice
CREATE OR ALTER PROCEDURE dbo.usp_DeleteInvoice
    @Param1 BIT = 0,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 VARCHAR(20) = NULL,
    @Param4 NVARCHAR(100) = NULL
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
        -- or remove the target row(s) in dbo.Invoices.
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
