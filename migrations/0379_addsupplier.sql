/* =====================================================================
   Migration 0379
   - New: usp_AddSupplier
   - Updated: usp_SearchPublisher
   ===================================================================== */

-- New: usp_AddSupplier
CREATE OR ALTER PROCEDURE dbo.usp_AddSupplier
    @Param1 BIT = 0
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

-- Updated: usp_SearchPublisher
CREATE OR ALTER PROCEDURE dbo.usp_SearchPublisher
    @Param1 INT,
    @Param2 DATETIME2(0) = NULL,
    @Param3 BIT,
    @Param4 NVARCHAR(255),
    @Param5 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Publishers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
