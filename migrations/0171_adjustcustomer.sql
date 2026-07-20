/* =====================================================================
   Migration 0171
   - New: usp_AdjustCustomer
   - Updated: usp_GetReturn
   - Updated: usp_SyncCustomer
   ===================================================================== */

-- New: usp_AdjustCustomer
CREATE OR ALTER PROCEDURE dbo.usp_AdjustCustomer
    @Param1 NVARCHAR(255)
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
        -- update the target row(s) in dbo.Customers.
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
    @Param1 DATE = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SyncCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SyncCustomer
    @Param1 BIT,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 DATETIME2(0),
    @Param4 DECIMAL(10,2),
    @Param5 NVARCHAR(255)
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
        -- update the target row(s) in dbo.Customers.
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
