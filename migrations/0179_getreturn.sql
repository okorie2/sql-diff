/* =====================================================================
   Migration 0179
   - New: usp_GetReturn
   - Updated: usp_GetOrder
   - Updated: usp_ApproveSubscription
   ===================================================================== */

-- New: usp_GetReturn
CREATE OR ALTER PROCEDURE dbo.usp_GetReturn
    @Param1 VARCHAR(20),
    @Param2 DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 NVARCHAR(100),
    @Param2 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ApproveSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ApproveSubscription
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DECIMAL(10,2) = NULL
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
