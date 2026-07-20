/* =====================================================================
   Migration 0071
   - New: usp_UpdateCustomer
   ===================================================================== */

-- New: usp_UpdateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_UpdateCustomer
    @Param1 INT,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 BIT = 0
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
