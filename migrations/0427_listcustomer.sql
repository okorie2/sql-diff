/* =====================================================================
   Migration 0427
   - New: usp_ListCustomer
   - Updated: usp_MergeInvoice
   - Updated: usp_RejectAuthor
   ===================================================================== */

-- New: usp_ListCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ListCustomer
    @Param1 NVARCHAR(255),
    @Param2 DATETIME2(0),
    @Param3 VARCHAR(20) = NULL,
    @Param4 DATETIME2(0) = NULL,
    @Param5 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Customers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_MergeInvoice
CREATE OR ALTER PROCEDURE dbo.usp_MergeInvoice
    @Param1 INT
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

-- Updated: usp_RejectAuthor
CREATE OR ALTER PROCEDURE dbo.usp_RejectAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 BIT = 0,
    @Param3 INT = NULL,
    @Param4 DECIMAL(10,2)
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
        -- or remove the target row(s) in dbo.Authors.
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
