/* =====================================================================
   Migration 0101
   - New: usp_ArchiveSupplier
   ===================================================================== */

-- New: usp_ArchiveSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveSupplier
    @Param1 NVARCHAR(100),
    @Param2 DATETIME2(0) = NULL,
    @Param3 INT,
    @Param4 INT = NULL
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
        -- or remove the target row(s) in dbo.Suppliers.
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
