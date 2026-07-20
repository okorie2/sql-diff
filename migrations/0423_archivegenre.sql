/* =====================================================================
   Migration 0423
   - New: usp_ArchiveGenre
   - Updated: usp_MergeCustomer
   ===================================================================== */

-- New: usp_ArchiveGenre
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveGenre
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0) = NULL,
    @Param3 BIT = 0,
    @Param4 BIT = 0,
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
        -- or remove the target row(s) in dbo.Genres.
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

-- Updated: usp_MergeCustomer
CREATE OR ALTER PROCEDURE dbo.usp_MergeCustomer
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DATETIME2(0),
    @Param3 BIT = 0
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
        -- update the target row(s) in dbo.Customers.
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
