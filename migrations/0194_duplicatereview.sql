/* =====================================================================
   Migration 0194
   - New: usp_DuplicateReview
   ===================================================================== */

-- New: usp_DuplicateReview
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateReview
    @Param1 NVARCHAR(100),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Reviews.
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
