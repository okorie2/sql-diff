/* =====================================================================
   Migration 0293
   - New: usp_SyncSupplier
   - Updated: usp_DeleteGenre
   - Updated: usp_MergeSupplier
   ===================================================================== */

-- New: usp_SyncSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SyncSupplier
    @Param1 DECIMAL(10,2),
    @Param2 INT,
    @Param3 NVARCHAR(100),
    @Param4 DATETIME2(0) = NULL
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
        -- update the target row(s) in dbo.Suppliers.
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

-- Updated: usp_DeleteGenre
CREATE OR ALTER PROCEDURE dbo.usp_DeleteGenre
    @Param1 INT,
    @Param2 VARCHAR(20)
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

-- Updated: usp_MergeSupplier
CREATE OR ALTER PROCEDURE dbo.usp_MergeSupplier
    @Param1 VARCHAR(20),
    @Param2 NVARCHAR(100) = NULL,
    @Param3 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Suppliers.
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
