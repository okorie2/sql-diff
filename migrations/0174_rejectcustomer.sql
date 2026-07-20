/* =====================================================================
   Migration 0174
   - New: usp_RejectCustomer
   - Updated: usp_ListOrder
   ===================================================================== */

-- New: usp_RejectCustomer
CREATE OR ALTER PROCEDURE dbo.usp_RejectCustomer
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DATETIME2(0)
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
        -- or remove the target row(s) in dbo.Customers.
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

-- Updated: usp_ListOrder
CREATE OR ALTER PROCEDURE dbo.usp_ListOrder
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT,
    @Param3 DATETIME2(0) = NULL,
    @Param4 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
