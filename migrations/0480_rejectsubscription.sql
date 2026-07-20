/* =====================================================================
   Migration 0480
   - New: usp_RejectSubscription
   - Updated: usp_RejectAuthor
   ===================================================================== */

-- New: usp_RejectSubscription
CREATE OR ALTER PROCEDURE dbo.usp_RejectSubscription
    @Param1 NVARCHAR(100),
    @Param2 NVARCHAR(255),
    @Param3 DATETIME2(0) = NULL,
    @Param4 NVARCHAR(100)
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

-- Updated: usp_RejectAuthor
CREATE OR ALTER PROCEDURE dbo.usp_RejectAuthor
    @Param1 BIT = 0,
    @Param2 DATE,
    @Param3 INT,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 DATE = NULL
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
