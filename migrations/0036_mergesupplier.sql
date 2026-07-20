/* =====================================================================
   Migration 0036
   - Updated: usp_MergeSupplier
   - Updated: usp_MergeSupplier
   ===================================================================== */

-- Updated: usp_MergeSupplier
CREATE OR ALTER PROCEDURE dbo.usp_MergeSupplier
    @Param1 BIT,
    @Param2 INT = NULL,
    @Param3 VARCHAR(20) = NULL
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

-- Updated: usp_MergeSupplier
CREATE OR ALTER PROCEDURE dbo.usp_MergeSupplier
    @Param1 DATE = NULL,
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0),
    @Param4 NVARCHAR(100),
    @Param5 DECIMAL(10,2)
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
