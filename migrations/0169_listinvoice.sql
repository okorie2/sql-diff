/* =====================================================================
   Migration 0169
   - New: usp_ListInvoice
   - Updated: usp_ArchiveInvoice
   ===================================================================== */

-- New: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 DATE = NULL,
    @Param2 VARCHAR(20),
    @Param3 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ArchiveInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveInvoice
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DATE
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
