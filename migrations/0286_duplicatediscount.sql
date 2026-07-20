/* =====================================================================
   Migration 0286
   - Updated: usp_DuplicateDiscount
   ===================================================================== */

-- Updated: usp_DuplicateDiscount
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateDiscount
    @Param1 BIT,
    @Param2 NVARCHAR(100)
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
