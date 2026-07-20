/* =====================================================================
   Migration 0469
   - New: usp_RestoreInvoice
   - Updated: usp_DuplicatePublisher
   ===================================================================== */

-- New: usp_RestoreInvoice
CREATE OR ALTER PROCEDURE dbo.usp_RestoreInvoice
    @Param1 INT,
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(255)
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

-- Updated: usp_DuplicatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_DuplicatePublisher
    @Param1 NVARCHAR(255),
    @Param2 NVARCHAR(255),
    @Param3 INT,
    @Param4 NVARCHAR(100)
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
