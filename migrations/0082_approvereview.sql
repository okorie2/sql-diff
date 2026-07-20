/* =====================================================================
   Migration 0082
   - New: usp_ApproveReview
   ===================================================================== */

-- New: usp_ApproveReview
CREATE OR ALTER PROCEDURE dbo.usp_ApproveReview
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE,
    @Param3 DATE,
    @Param4 DATETIME2(0) = NULL
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
