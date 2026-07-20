/* =====================================================================
   Migration 0324
   - New: usp_GetReturn
   - Updated: usp_DuplicateGenre
   - Updated: usp_RestoreReturn
   ===================================================================== */

-- New: usp_GetReturn
CREATE OR ALTER PROCEDURE dbo.usp_GetReturn
    @Param1 DATE,
    @Param2 BIT,
    @Param3 NVARCHAR(100),
    @Param4 BIT,
    @Param5 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_DuplicateGenre
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateGenre
    @Param1 DATE,
    @Param2 DATE,
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

-- Updated: usp_RestoreReturn
CREATE OR ALTER PROCEDURE dbo.usp_RestoreReturn
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20) = NULL,
    @Param3 DECIMAL(10,2) = NULL
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
