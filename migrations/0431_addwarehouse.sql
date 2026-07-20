/* =====================================================================
   Migration 0431
   - New: usp_AddWarehouse
   - Updated: usp_GetAuthor
   ===================================================================== */

-- New: usp_AddWarehouse
CREATE OR ALTER PROCEDURE dbo.usp_AddWarehouse
    @Param1 INT = NULL,
    @Param2 BIT,
    @Param3 BIT = 0
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

-- Updated: usp_GetAuthor
CREATE OR ALTER PROCEDURE dbo.usp_GetAuthor
    @Param1 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
