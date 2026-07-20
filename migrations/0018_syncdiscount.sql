/* =====================================================================
   Migration 0018
   - New: usp_SyncDiscount
   ===================================================================== */

-- New: usp_SyncDiscount
CREATE OR ALTER PROCEDURE dbo.usp_SyncDiscount
    @Param1 DATETIME2(0),
    @Param2 DATETIME2(0) = NULL,
    @Param3 VARCHAR(20) = NULL
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
        -- update the target row(s) in dbo.Discounts.
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
