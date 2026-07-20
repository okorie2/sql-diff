/* =====================================================================
   Migration 0476
   - New: usp_SyncSubscription
   ===================================================================== */

-- New: usp_SyncSubscription
CREATE OR ALTER PROCEDURE dbo.usp_SyncSubscription
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Subscriptions.
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
