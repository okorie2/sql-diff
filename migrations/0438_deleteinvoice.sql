/* =====================================================================
   Migration 0438
   - New: usp_DeleteInvoice
   - Updated: usp_DeleteOrder
   - Updated: usp_PublishReturn
   ===================================================================== */

-- New: usp_DeleteInvoice
CREATE OR ALTER PROCEDURE dbo.usp_DeleteInvoice
    @Param1 DECIMAL(10,2),
    @Param2 BIT,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 NVARCHAR(100) = NULL,
    @Param5 NVARCHAR(255)
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

-- Updated: usp_DeleteOrder
CREATE OR ALTER PROCEDURE dbo.usp_DeleteOrder
    @Param1 DATETIME2(0),
    @Param2 VARCHAR(20),
    @Param3 DATE = NULL
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
        -- or remove the target row(s) in dbo.Orders.
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

-- Updated: usp_PublishReturn
CREATE OR ALTER PROCEDURE dbo.usp_PublishReturn
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DECIMAL(10,2) = NULL
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
        -- update the target row(s) in dbo.Returns.
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
