/* =====================================================================
   Migration 0487
   - New: usp_ListCustomer
   - Updated: usp_TransferSupplier
   - Updated: usp_PublishReview
   ===================================================================== */

-- New: usp_ListCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ListCustomer
    @Param1 BIT = 0,
    @Param2 VARCHAR(20),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 NVARCHAR(100),
    @Param5 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Customers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_TransferSupplier
CREATE OR ALTER PROCEDURE dbo.usp_TransferSupplier
    @Param1 INT
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

-- Updated: usp_PublishReview
CREATE OR ALTER PROCEDURE dbo.usp_PublishReview
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 DECIMAL(10,2),
    @Param5 BIT
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
        -- update the target row(s) in dbo.Reviews.
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
