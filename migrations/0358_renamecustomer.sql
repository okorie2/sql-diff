/* =====================================================================
   Migration 0358
   - New: usp_RenameCustomer
   - Updated: usp_MergeWarehouse
   - Updated: usp_ValidatePublisher
   ===================================================================== */

-- New: usp_RenameCustomer
CREATE OR ALTER PROCEDURE dbo.usp_RenameCustomer
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100) = NULL
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

-- Updated: usp_MergeWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
    @Param1 DATETIME2(0) = NULL,
    @Param2 INT = NULL,
    @Param3 INT = NULL,
    @Param4 INT = NULL,
    @Param5 BIT = 0
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
        -- update the target row(s) in dbo.Warehouses.
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

-- Updated: usp_ValidatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_ValidatePublisher
    @Param1 DATETIME2(0),
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 VARCHAR(20),
    @Param4 NVARCHAR(255),
    @Param5 DATETIME2(0)
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
        -- update the target row(s) in dbo.Publishers.
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
