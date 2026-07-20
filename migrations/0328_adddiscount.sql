/* =====================================================================
   Migration 0328
   - New: usp_AddDiscount
   - Updated: usp_SyncReview
   ===================================================================== */

-- New: usp_AddDiscount
CREATE OR ALTER PROCEDURE dbo.usp_AddDiscount
    @Param1 INT = NULL,
    @Param2 INT = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 VARCHAR(20) = NULL
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

-- Updated: usp_SyncReview
CREATE OR ALTER PROCEDURE dbo.usp_SyncReview
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DECIMAL(10,2),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 INT
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
