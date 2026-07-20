/* =====================================================================
   Migration 0170
   - New: usp_SearchSupplier
   - Updated: usp_TransferSupplier
   ===================================================================== */

-- New: usp_SearchSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SearchSupplier
    @Param1 NVARCHAR(100),
    @Param2 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Suppliers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_TransferSupplier
CREATE OR ALTER PROCEDURE dbo.usp_TransferSupplier
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT = 0,
    @Param3 VARCHAR(20) = NULL,
    @Param4 BIT = 0
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
