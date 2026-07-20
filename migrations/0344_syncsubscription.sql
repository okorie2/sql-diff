/* =====================================================================
   Migration 0344
   - New: usp_SyncSubscription
   ===================================================================== */

-- New: usp_SyncSubscription
CREATE OR ALTER PROCEDURE dbo.usp_SyncSubscription
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT = 0,
    @Param3 NVARCHAR(100),
    @Param4 NVARCHAR(100) = NULL,
    @Param5 NVARCHAR(100) = NULL
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
