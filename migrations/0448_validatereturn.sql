/* =====================================================================
   Migration 0448
   - New: usp_ValidateReturn
   - Updated: usp_ValidateWarehouse
   ===================================================================== */

-- New: usp_ValidateReturn
CREATE OR ALTER PROCEDURE dbo.usp_ValidateReturn
    @Param1 INT = NULL,
    @Param2 DECIMAL(10,2) = NULL
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
        -- update the target row(s) in dbo.Returns.
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

-- Updated: usp_ValidateWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_ValidateWarehouse
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATE
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
