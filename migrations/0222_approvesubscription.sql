/* =====================================================================
   Migration 0222
   - New: usp_ApproveSubscription
   - Updated: usp_ListReview
   - Updated: usp_ArchivePublisher
   ===================================================================== */

-- New: usp_ApproveSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ApproveSubscription
    @Param1 NVARCHAR(100),
    @Param2 DATETIME2(0),
    @Param3 DATE,
    @Param4 NVARCHAR(255)
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
        -- update the target row(s) in dbo.Subscriptions.
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

-- Updated: usp_ListReview
CREATE OR ALTER PROCEDURE dbo.usp_ListReview
    @Param1 NVARCHAR(100) = NULL,
    @Param2 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ArchivePublisher
CREATE OR ALTER PROCEDURE dbo.usp_ArchivePublisher
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(100),
    @Param3 NVARCHAR(100)
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
        -- or remove the target row(s) in dbo.Publishers.
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
