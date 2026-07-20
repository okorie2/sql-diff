/* =====================================================================
   Migration 0076
   - New: usp_MergeDiscount
   - Updated: usp_DeleteWarehouse
   ===================================================================== */

-- New: usp_MergeDiscount
CREATE OR ALTER PROCEDURE dbo.usp_MergeDiscount
    @Param1 BIT,
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(255),
    @Param4 BIT,
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

-- Updated: usp_DeleteWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_DeleteWarehouse
    @Param1 DATETIME2(0),
    @Param2 DATE = NULL,
    @Param3 DATE,
    @Param4 DATE = NULL
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
        -- or remove the target row(s) in dbo.Warehouses.
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
