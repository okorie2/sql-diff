/* =====================================================================
   Migration 0055
   - New: usp_RestoreDiscount
   - Updated: usp_GetReview
   - Updated: usp_GetOrder
   ===================================================================== */

-- New: usp_RestoreDiscount
CREATE OR ALTER PROCEDURE dbo.usp_RestoreDiscount
    @Param1 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Discounts.
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

-- Updated: usp_GetReview
CREATE OR ALTER PROCEDURE dbo.usp_GetReview
    @Param1 INT = NULL,
    @Param2 DATETIME2(0) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_GetOrder
CREATE OR ALTER PROCEDURE dbo.usp_GetOrder
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0) = NULL,
    @Param3 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Orders
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
