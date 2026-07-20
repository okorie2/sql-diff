/* =====================================================================
   Migration 0492
   - New: usp_MergeBook
   - Updated: usp_TransferSupplier
   ===================================================================== */

-- New: usp_MergeBook
CREATE OR ALTER PROCEDURE dbo.usp_MergeBook
    @Param1 DATETIME2(0),
    @Param2 VARCHAR(20) = NULL,
    @Param3 BIT = 0
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

-- Updated: usp_TransferSupplier
CREATE OR ALTER PROCEDURE dbo.usp_TransferSupplier
    @Param1 DATETIME2(0) = NULL,
    @Param2 VARCHAR(20),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 NVARCHAR(100),
    @Param5 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Suppliers.
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
