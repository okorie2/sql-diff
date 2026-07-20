/* =====================================================================
   Migration 0370
   - New: usp_DuplicateSubscription
   ===================================================================== */

-- New: usp_DuplicateSubscription
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateSubscription
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(100) = NULL
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
