/* =====================================================================
   Migration 0482
   - New: usp_DuplicateCustomer
   - Updated: usp_TransferCustomer
   ===================================================================== */

-- New: usp_DuplicateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateCustomer
    @Param1 DATETIME2(0),
    @Param2 BIT = 0,
    @Param3 NVARCHAR(100),
    @Param4 DATETIME2(0),
    @Param5 DATETIME2(0) = NULL
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

-- Updated: usp_TransferCustomer
CREATE OR ALTER PROCEDURE dbo.usp_TransferCustomer
    @Param1 BIT = 0,
    @Param2 BIT = 0,
    @Param3 INT,
    @Param4 DATETIME2(0),
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
