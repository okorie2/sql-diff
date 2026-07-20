/* =====================================================================
   Migration 0406
   - New: usp_ArchiveReturn
   - Updated: usp_ApproveAuthor
   ===================================================================== */

-- New: usp_ArchiveReturn
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveReturn
    @Param1 NVARCHAR(100),
    @Param2 DATETIME2(0) = NULL,
    @Param3 NVARCHAR(255),
    @Param4 INT = NULL,
    @Param5 NVARCHAR(255) = NULL
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
        -- or remove the target row(s) in dbo.Returns.
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

-- Updated: usp_ApproveAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ApproveAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 DATE = NULL
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
        -- update the target row(s) in dbo.Authors.
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
