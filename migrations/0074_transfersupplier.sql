/* =====================================================================
   Migration 0074
   - New: usp_TransferSupplier
   ===================================================================== */

-- New: usp_TransferSupplier
CREATE OR ALTER PROCEDURE dbo.usp_TransferSupplier
    @Param1 DATE,
    @Param2 VARCHAR(20),
    @Param3 DATETIME2(0),
    @Param4 DECIMAL(10,2),
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
