/* =====================================================================
   Migration 0041
   - New: usp_ListSubscription
   - Updated: usp_DeleteOrder
   ===================================================================== */

-- New: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_DeleteOrder
CREATE OR ALTER PROCEDURE dbo.usp_DeleteOrder
    @Param1 BIT = 0,
    @Param2 INT
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
