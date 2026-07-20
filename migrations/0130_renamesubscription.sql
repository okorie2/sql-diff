/* =====================================================================
   Migration 0130
   - New: usp_RenameSubscription
   ===================================================================== */

-- New: usp_RenameSubscription
CREATE OR ALTER PROCEDURE dbo.usp_RenameSubscription
    @Param1 NVARCHAR(255),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(100) = NULL,
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
