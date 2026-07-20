/* =====================================================================
   Migration 0272
   - New: usp_UnpublishAuthor
   - Updated: usp_RenameBook
   - Updated: usp_MergeReturn
   ===================================================================== */

-- New: usp_UnpublishAuthor
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishAuthor
    @Param1 VARCHAR(20),
    @Param2 BIT = 0,
    @Param3 BIT = 0,
    @Param4 INT = NULL,
    @Param5 NVARCHAR(255)
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

-- Updated: usp_RenameBook
CREATE OR ALTER PROCEDURE dbo.usp_RenameBook
    @Param1 INT,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 DECIMAL(10,2),
    @Param5 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Books.
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

-- Updated: usp_MergeReturn
CREATE OR ALTER PROCEDURE dbo.usp_MergeReturn
    @Param1 BIT,
    @Param2 INT = NULL,
    @Param3 VARCHAR(20) = NULL,
    @Param4 BIT
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
