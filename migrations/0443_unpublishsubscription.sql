/* =====================================================================
   Migration 0443
   - New: usp_UnpublishSubscription
   ===================================================================== */

-- New: usp_UnpublishSubscription
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishSubscription
    @Param1 DATETIME2(0),
    @Param2 INT,
    @Param3 NVARCHAR(100)
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
        -- or remove the target row(s) in dbo.Subscriptions.
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
