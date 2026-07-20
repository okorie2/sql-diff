/* =====================================================================
   Migration 0010
   - New: usp_GetReview
   - Updated: usp_AddSubscription
   ===================================================================== */

-- New: usp_GetReview
CREATE OR ALTER PROCEDURE dbo.usp_GetReview
    @Param1 DATETIME2(0),
    @Param2 DATE = NULL,
    @Param3 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_AddSubscription
CREATE OR ALTER PROCEDURE dbo.usp_AddSubscription
    @Param1 NVARCHAR(100),
    @Param2 VARCHAR(20) = NULL,
    @Param3 BIT = 0,
    @Param4 VARCHAR(20),
    @Param5 INT = NULL
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
        -- update the target row(s) in dbo.Subscriptions.
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
