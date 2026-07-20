/* =====================================================================
   Migration 0467
   - New: usp_DeleteDiscount
   ===================================================================== */

-- New: usp_DeleteDiscount
CREATE OR ALTER PROCEDURE dbo.usp_DeleteDiscount
    @Param1 NVARCHAR(100) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(255),
    @Param4 DATETIME2(0) = NULL
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
