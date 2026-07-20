/* =====================================================================
   Migration 0063
   - New: usp_GetDiscount
   - Updated: usp_RenameShipment
   ===================================================================== */

-- New: usp_GetDiscount
CREATE OR ALTER PROCEDURE dbo.usp_GetDiscount
    @Param1 DATETIME2(0),
    @Param2 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Discounts
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_RenameShipment
CREATE OR ALTER PROCEDURE dbo.usp_RenameShipment
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(100),
    @Param4 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Shipments.
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
