/* =====================================================================
   Migration 0277
   - New: usp_RetireReturn
   - Updated: usp_ListDiscount
   ===================================================================== */

-- New: usp_RetireReturn
CREATE OR ALTER PROCEDURE dbo.usp_RetireReturn
    @Param1 BIT = 0,
    @Param2 DATE = NULL
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
        -- or remove the target row(s) in dbo.Returns.
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

-- Updated: usp_ListDiscount
CREATE OR ALTER PROCEDURE dbo.usp_ListDiscount
    @Param1 DATETIME2(0) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
