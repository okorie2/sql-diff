/* =====================================================================
   Migration 0260
   - Updated: usp_DeleteCustomer
   ===================================================================== */

-- Updated: usp_DeleteCustomer
CREATE OR ALTER PROCEDURE dbo.usp_DeleteCustomer
    @Param1 DATE,
    @Param2 INT,
    @Param3 DATETIME2(0) = NULL,
    @Param4 BIT = 0,
    @Param5 VARCHAR(20) = NULL
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
        -- or remove the target row(s) in dbo.Customers.
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
