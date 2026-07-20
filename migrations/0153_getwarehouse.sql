/* =====================================================================
   Migration 0153
   - New: usp_GetWarehouse
   - Updated: usp_DuplicatePublisher
   ===================================================================== */

-- New: usp_GetWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_GetWarehouse
    @Param1 VARCHAR(20) = NULL,
    @Param2 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Warehouses
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_DuplicatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_DuplicatePublisher
    @Param1 DATE
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
        -- update the target row(s) in dbo.Publishers.
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
