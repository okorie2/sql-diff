/* =====================================================================
   Migration 0158
   - New: usp_SyncDiscount
   ===================================================================== */

-- New: usp_SyncDiscount
CREATE OR ALTER PROCEDURE dbo.usp_SyncDiscount
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(255),
    @Param4 DATE = NULL,
    @Param5 BIT = 0
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
