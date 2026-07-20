/* =====================================================================
   Migration 0241
   - New: usp_AddDiscount
   ===================================================================== */

-- New: usp_AddDiscount
CREATE OR ALTER PROCEDURE dbo.usp_AddDiscount
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 BIT = 0,
    @Param3 INT,
    @Param4 VARCHAR(20) = NULL
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
