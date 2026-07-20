/* =====================================================================
   Migration 0504
   - New: usp_RenameReturn
   - Updated: usp_ApproveGenre
   ===================================================================== */

-- New: usp_RenameReturn
CREATE OR ALTER PROCEDURE dbo.usp_RenameReturn
    @Param1 VARCHAR(20) = NULL,
    @Param2 INT = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Returns.
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

-- Updated: usp_ApproveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ApproveGenre
    @Param1 DATE = NULL,
    @Param2 INT = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 DECIMAL(10,2),
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
