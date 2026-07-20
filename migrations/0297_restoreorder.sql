/* =====================================================================
   Migration 0297
   - New: usp_RestoreOrder
   - Updated: usp_ArchiveOrder
   ===================================================================== */

-- New: usp_RestoreOrder
CREATE OR ALTER PROCEDURE dbo.usp_RestoreOrder
    @Param1 NVARCHAR(255) = NULL,
    @Param2 DATE = NULL,
    @Param3 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Orders.
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

-- Updated: usp_ArchiveOrder
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveOrder
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 VARCHAR(20) = NULL,
    @Param3 VARCHAR(20) = NULL,
    @Param4 VARCHAR(20),
    @Param5 VARCHAR(20) = NULL
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
