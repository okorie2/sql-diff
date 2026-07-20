/* =====================================================================
   Migration 0090
   - New: usp_TransferGenre
   - Updated: usp_UnpublishReturn
   ===================================================================== */

-- New: usp_TransferGenre
CREATE OR ALTER PROCEDURE dbo.usp_TransferGenre
    @Param1 NVARCHAR(255) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 BIT
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
        -- update the target row(s) in dbo.Genres.
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

-- Updated: usp_UnpublishReturn
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishReturn
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(255)
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
        -- or remove the target row(s) in dbo.Returns.
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
