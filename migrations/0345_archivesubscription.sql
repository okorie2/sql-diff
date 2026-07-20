/* =====================================================================
   Migration 0345
   - New: usp_ArchiveSubscription
   - Updated: usp_RenameReturn
   ===================================================================== */

-- New: usp_ArchiveSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveSubscription
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(255),
    @Param3 VARCHAR(20) = NULL,
    @Param4 DECIMAL(10,2) = NULL
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
        -- or remove the target row(s) in dbo.Subscriptions.
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

-- Updated: usp_RenameReturn
CREATE OR ALTER PROCEDURE dbo.usp_RenameReturn
    @Param1 INT,
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATETIME2(0) = NULL,
    @Param4 DATETIME2(0) = NULL,
    @Param5 INT = NULL
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
