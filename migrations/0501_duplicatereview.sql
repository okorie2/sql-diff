/* =====================================================================
   Migration 0501
   - New: usp_DuplicateReview
   ===================================================================== */

-- New: usp_DuplicateReview
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateReview
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DECIMAL(10,2),
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 INT
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
