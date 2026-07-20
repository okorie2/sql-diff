/* =====================================================================
   Migration 0421
   - New: usp_AddWarehouse
   - Updated: usp_ListOrder
   - Updated: usp_DuplicateWarehouse
   ===================================================================== */

-- New: usp_AddWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_AddWarehouse
    @Param1 VARCHAR(20),
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
        -- update the target row(s) in dbo.Warehouses.
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

-- Updated: usp_ListOrder
CREATE OR ALTER PROCEDURE dbo.usp_ListOrder
    @Param1 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_DuplicateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateWarehouse
    @Param1 DATE,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 DATE
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
        -- update the target row(s) in dbo.Warehouses.
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
