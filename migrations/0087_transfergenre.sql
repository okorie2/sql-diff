/* =====================================================================
   Migration 0087
   - New: usp_TransferGenre
   - Updated: usp_RenameReview
   ===================================================================== */

-- New: usp_TransferGenre
CREATE OR ALTER PROCEDURE dbo.usp_TransferGenre
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 DATETIME2(0)
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
        -- update the target row(s) in dbo.Genres.
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

-- Updated: usp_RenameReview
CREATE OR ALTER PROCEDURE dbo.usp_RenameReview
    @Param1 BIT,
    @Param2 INT = NULL
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
