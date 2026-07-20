/* =====================================================================
   Migration 0320
   - New: usp_SyncOrder
   ===================================================================== */

-- New: usp_SyncOrder
CREATE OR ALTER PROCEDURE dbo.usp_SyncOrder
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100),
    @Param3 DATE = NULL,
    @Param4 DATE = NULL,
    @Param5 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Orders.
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
