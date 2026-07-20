/* =====================================================================
   Migration 0449
   - New: usp_AdjustSubscription
   - Updated: usp_RenameReturn
   ===================================================================== */

-- New: usp_AdjustSubscription
CREATE OR ALTER PROCEDURE dbo.usp_AdjustSubscription
    @Param1 BIT,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 INT = NULL,
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

-- Updated: usp_RenameReturn
CREATE OR ALTER PROCEDURE dbo.usp_RenameReturn
    @Param1 INT = NULL,
    @Param2 BIT = 0,
    @Param3 BIT,
    @Param4 NVARCHAR(100),
    @Param5 INT
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
