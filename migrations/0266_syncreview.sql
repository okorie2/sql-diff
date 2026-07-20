/* =====================================================================
   Migration 0266
   - New: usp_SyncReview
   - Updated: usp_DeleteOrder
   ===================================================================== */

-- New: usp_SyncReview
CREATE OR ALTER PROCEDURE dbo.usp_SyncReview
    @Param1 DATE,
    @Param2 INT = NULL,
    @Param3 DECIMAL(10,2) = NULL,
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

-- Updated: usp_DeleteOrder
CREATE OR ALTER PROCEDURE dbo.usp_DeleteOrder
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20) = NULL,
    @Param3 NVARCHAR(100),
    @Param4 NVARCHAR(255) = NULL,
    @Param5 NVARCHAR(100)
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
        -- or remove the target row(s) in dbo.Orders.
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
