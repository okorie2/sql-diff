/* =====================================================================
   Migration 0279
   - Updated: usp_RestoreShipment
   - Updated: usp_GetSubscription
   ===================================================================== */

-- Updated: usp_RestoreShipment
CREATE OR ALTER PROCEDURE dbo.usp_RestoreShipment
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 VARCHAR(20),
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Shipments.
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

-- Updated: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
