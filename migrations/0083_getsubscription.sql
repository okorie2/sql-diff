/* =====================================================================
   Migration 0083
   - New: usp_GetSubscription
   - Updated: usp_RetirePublisher
   ===================================================================== */

-- New: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 NVARCHAR(100),
    @Param2 DATE,
    @Param3 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_RetirePublisher
CREATE OR ALTER PROCEDURE dbo.usp_RetirePublisher
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 DATETIME2(0) = NULL
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
        -- or remove the target row(s) in dbo.Publishers.
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
