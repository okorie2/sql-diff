/* =====================================================================
   Migration 0213
   - New: usp_AddReview
   ===================================================================== */

-- New: usp_AddReview
CREATE OR ALTER PROCEDURE dbo.usp_AddReview
    @Param1 DATETIME2(0),
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATE = NULL
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
