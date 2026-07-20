/* =====================================================================
   Migration 0261
   - Updated: usp_UpdateSupplier
   ===================================================================== */

-- Updated: usp_UpdateSupplier
CREATE OR ALTER PROCEDURE dbo.usp_UpdateSupplier
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(255),
    @Param3 INT,
    @Param4 NVARCHAR(255)
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
