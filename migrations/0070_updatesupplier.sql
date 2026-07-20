/* =====================================================================
   Migration 0070
   - New: usp_UpdateSupplier
   ===================================================================== */

-- New: usp_UpdateSupplier
CREATE OR ALTER PROCEDURE dbo.usp_UpdateSupplier
    @Param1 DATETIME2(0),
    @Param2 DECIMAL(10,2),
    @Param3 VARCHAR(20),
    @Param4 DATE = NULL,
    @Param5 VARCHAR(20)
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
        -- update the target row(s) in dbo.Suppliers.
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
