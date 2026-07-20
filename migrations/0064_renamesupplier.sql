/* =====================================================================
   Migration 0064
   - New: usp_RenameSupplier
   - Updated: usp_RejectOrder
   - Updated: usp_GetReturn
   ===================================================================== */

-- New: usp_RenameSupplier
CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 DECIMAL(10,2),
    @Param2 DECIMAL(10,2),
    @Param3 DATETIME2(0),
    @Param4 DATETIME2(0),
    @Param5 DATE = NULL
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

-- Updated: usp_RejectOrder
CREATE OR ALTER PROCEDURE dbo.usp_RejectOrder
    @Param1 DATE,
    @Param2 VARCHAR(20),
    @Param3 VARCHAR(20),
    @Param4 BIT = 0
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
        -- or remove the target row(s) in dbo.Orders.
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

-- Updated: usp_GetReturn
CREATE OR ALTER PROCEDURE dbo.usp_GetReturn
    @Param1 BIT = 0,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 INT = NULL,
    @Param4 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
