/* =====================================================================
   Migration 0494
   - New: usp_RenameReview
   - Updated: usp_DeleteReview
   ===================================================================== */

-- New: usp_RenameReview
CREATE OR ALTER PROCEDURE dbo.usp_RenameReview
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 INT,
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

-- Updated: usp_DeleteReview
CREATE OR ALTER PROCEDURE dbo.usp_DeleteReview
    @Param1 DATE = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 INT,
    @Param4 VARCHAR(20)
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
