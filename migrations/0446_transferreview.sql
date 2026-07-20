/* =====================================================================
   Migration 0446
   - New: usp_TransferReview
   - Updated: usp_RejectAuthor
   ===================================================================== */

-- New: usp_TransferReview
CREATE OR ALTER PROCEDURE dbo.usp_TransferReview
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DATE = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 BIT,
    @Param5 DATETIME2(0)
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

-- Updated: usp_RejectAuthor
CREATE OR ALTER PROCEDURE dbo.usp_RejectAuthor
    @Param1 VARCHAR(20) = NULL,
    @Param2 DECIMAL(10,2) = NULL
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
        -- or remove the target row(s) in dbo.Authors.
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
