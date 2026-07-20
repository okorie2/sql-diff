/* =====================================================================
   Migration 0167
   - New: usp_DeleteGenre
   - Updated: usp_RestoreDiscount
   ===================================================================== */

-- New: usp_DeleteGenre
CREATE OR ALTER PROCEDURE dbo.usp_DeleteGenre
    @Param1 DATETIME2(0),
    @Param2 BIT,
    @Param3 DATE,
    @Param4 NVARCHAR(255) = NULL,
    @Param5 VARCHAR(20)
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

-- Updated: usp_RestoreDiscount
CREATE OR ALTER PROCEDURE dbo.usp_RestoreDiscount
    @Param1 INT,
    @Param2 BIT,
    @Param3 DATE,
    @Param4 BIT = 0,
    @Param5 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Discounts.
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
