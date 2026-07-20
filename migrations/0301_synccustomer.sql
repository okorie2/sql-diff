/* =====================================================================
   Migration 0301
   - New: usp_SyncCustomer
   ===================================================================== */

-- New: usp_SyncCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SyncCustomer
    @Param1 NVARCHAR(100),
    @Param2 VARCHAR(20),
    @Param3 DECIMAL(10,2),
    @Param4 BIT
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
        -- update the target row(s) in dbo.Customers.
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
