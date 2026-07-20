/* =====================================================================
   Migration 0346
   - New: usp_TransferDiscount
   ===================================================================== */

-- New: usp_TransferDiscount
CREATE OR ALTER PROCEDURE dbo.usp_TransferDiscount
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DATE = NULL,
    @Param4 INT,
    @Param5 DECIMAL(10,2) = NULL
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
