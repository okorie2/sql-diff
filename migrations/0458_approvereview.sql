/* =====================================================================
   Migration 0458
   - Updated: usp_ApproveReview
   - Updated: usp_AddDiscount
   ===================================================================== */

-- Updated: usp_ApproveReview
CREATE OR ALTER PROCEDURE dbo.usp_ApproveReview
    @Param1 NVARCHAR(255),
    @Param2 VARCHAR(20) = NULL,
    @Param3 BIT = 0
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

-- Updated: usp_AddDiscount
CREATE OR ALTER PROCEDURE dbo.usp_AddDiscount
    @Param1 BIT = 0,
    @Param2 BIT,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 BIT = 0,
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
