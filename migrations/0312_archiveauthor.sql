/* =====================================================================
   Migration 0312
   - New: usp_ArchiveAuthor
   ===================================================================== */

-- New: usp_ArchiveAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 INT = NULL,
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
