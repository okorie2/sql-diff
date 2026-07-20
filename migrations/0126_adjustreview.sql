/* =====================================================================
   Migration 0126
   - New: usp_AdjustReview
   - Updated: usp_GetSubscription
   ===================================================================== */

-- New: usp_AdjustReview
CREATE OR ALTER PROCEDURE dbo.usp_AdjustReview
    @Param1 DATETIME2(0),
    @Param2 INT,
    @Param3 VARCHAR(20),
    @Param4 DATETIME2(0),
    @Param5 DATE
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

-- Updated: usp_GetSubscription
CREATE OR ALTER PROCEDURE dbo.usp_GetSubscription
    @Param1 DATE,
    @Param2 DECIMAL(10,2),
    @Param3 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
