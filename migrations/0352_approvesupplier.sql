/* =====================================================================
   Migration 0352
   - New: usp_ApproveSupplier
   ===================================================================== */

-- New: usp_ApproveSupplier
CREATE OR ALTER PROCEDURE dbo.usp_ApproveSupplier
    @Param1 DATE = NULL,
    @Param2 BIT,
    @Param3 INT,
    @Param4 DECIMAL(10,2),
    @Param5 DATE
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
