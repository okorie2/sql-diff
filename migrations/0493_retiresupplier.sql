/* =====================================================================
   Migration 0493
   - New: usp_RetireSupplier
   ===================================================================== */

-- New: usp_RetireSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RetireSupplier
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 INT,
    @Param3 DECIMAL(10,2),
    @Param4 DATETIME2(0) = NULL,
    @Param5 BIT
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
        -- or remove the target row(s) in dbo.Suppliers.
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
