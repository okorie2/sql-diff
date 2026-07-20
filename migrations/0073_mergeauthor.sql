/* =====================================================================
   Migration 0073
   - New: usp_MergeAuthor
   ===================================================================== */

-- New: usp_MergeAuthor
CREATE OR ALTER PROCEDURE dbo.usp_MergeAuthor
    @Param1 INT = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DECIMAL(10,2),
    @Param4 DATE = NULL
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
        -- update the target row(s) in dbo.Authors.
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
