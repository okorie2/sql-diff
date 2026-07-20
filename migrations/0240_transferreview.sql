/* =====================================================================
   Migration 0240
   - New: usp_TransferReview
   - Updated: usp_ListSubscription
   ===================================================================== */

-- New: usp_TransferReview
CREATE OR ALTER PROCEDURE dbo.usp_TransferReview
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 NVARCHAR(255) = NULL,
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

-- Updated: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 VARCHAR(20),
    @Param3 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
