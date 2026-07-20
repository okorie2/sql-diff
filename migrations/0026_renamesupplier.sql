/* =====================================================================
   Migration 0026
   - New: usp_RenameSupplier
   - Updated: usp_GetOrder
   ===================================================================== */

-- New: usp_RenameSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 VARCHAR(20),
    @Param2 DATE = NULL,
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
        -- update the target row(s) in dbo.Suppliers.
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

-- Updated: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
