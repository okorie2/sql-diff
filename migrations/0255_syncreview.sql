/* =====================================================================
   Migration 0255
   - New: usp_SyncReview
   ===================================================================== */

-- New: usp_SyncReview
CREATE OR ALTER PROCEDURE dbo.usp_SyncReview
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 INT
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
