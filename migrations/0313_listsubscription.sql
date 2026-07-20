/* =====================================================================
   Migration 0313
   - New: usp_ListSubscription
   - Updated: usp_TransferOrder
   ===================================================================== */

-- New: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 INT = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 VARCHAR(20) = NULL,
    @Param4 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_TransferOrder
CREATE OR ALTER PROCEDURE dbo.usp_TransferOrder
    @Param1 INT = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 BIT = 0,
    @Param4 DATETIME2(0) = NULL
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
        -- update the target row(s) in dbo.Orders.
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
