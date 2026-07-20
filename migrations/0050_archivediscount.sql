/* =====================================================================
   Migration 0050
   - New: usp_ArchiveDiscount
   ===================================================================== */

-- New: usp_ArchiveDiscount
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveDiscount
    @Param1 DATE = NULL,
    @Param2 DATE = NULL,
    @Param3 DATE = NULL,
    @Param4 DATETIME2(0) = NULL,
    @Param5 DECIMAL(10,2) = NULL
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
        -- or remove the target row(s) in dbo.Discounts.
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
