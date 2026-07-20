/* =====================================================================
   Migration 0432
   - New: usp_DuplicateAuthor
   - Updated: usp_SyncPublisher
   ===================================================================== */

-- New: usp_DuplicateAuthor
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateAuthor
    @Param1 NVARCHAR(255),
    @Param2 VARCHAR(20) = NULL,
    @Param3 DATE = NULL,
    @Param4 DECIMAL(10,2) = NULL
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

-- Updated: usp_SyncPublisher
CREATE OR ALTER PROCEDURE dbo.usp_SyncPublisher
    @Param1 NVARCHAR(255),
    @Param2 VARCHAR(20) = NULL,
    @Param3 INT = NULL,
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
        -- update the target row(s) in dbo.Publishers.
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
