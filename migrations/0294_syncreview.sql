/* =====================================================================
   Migration 0294
   - New: usp_SyncReview
   ===================================================================== */

-- New: usp_SyncReview
CREATE OR ALTER PROCEDURE dbo.usp_SyncReview
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(255),
    @Param3 DECIMAL(10,2),
    @Param4 DATE = NULL,
    @Param5 DECIMAL(10,2) = NULL
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
