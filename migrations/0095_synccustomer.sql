/* =====================================================================
   Migration 0095
   - New: usp_SyncCustomer
   - Updated: usp_RenameBook
   ===================================================================== */

-- New: usp_SyncCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SyncCustomer
    @Param1 NVARCHAR(100) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 DECIMAL(10,2)
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

-- Updated: usp_RenameBook
CREATE OR ALTER PROCEDURE dbo.usp_RenameBook
    @Param1 NVARCHAR(255) = NULL,
    @Param2 BIT,
    @Param3 DATE,
    @Param4 NVARCHAR(255),
    @Param5 BIT
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
        -- update the target row(s) in dbo.Books.
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
