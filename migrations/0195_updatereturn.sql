/* =====================================================================
   Migration 0195
   - New: usp_UpdateReturn
   - Updated: usp_GetSubscription
   ===================================================================== */

-- New: usp_UpdateReturn
CREATE OR ALTER PROCEDURE dbo.usp_UpdateReturn
    @Param1 DECIMAL(10,2),
    @Param2 BIT = 0,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Returns.
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
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(100),
    @Param3 BIT,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
