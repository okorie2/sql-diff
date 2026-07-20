/* =====================================================================
   Migration 0121
   - New: usp_RetireOrder
   - Updated: usp_DeleteReview
   ===================================================================== */

-- New: usp_RetireOrder
CREATE OR ALTER PROCEDURE dbo.usp_RetireOrder
    @Param1 DATE = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 INT,
    @Param5 BIT = 0
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
        -- or remove the target row(s) in dbo.Orders.
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

-- Updated: usp_DeleteReview
CREATE OR ALTER PROCEDURE dbo.usp_DeleteReview
    @Param1 BIT = 0,
    @Param2 BIT = 0,
    @Param3 VARCHAR(20) = NULL
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
        -- or remove the target row(s) in dbo.Reviews.
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
