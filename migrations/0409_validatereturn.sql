/* =====================================================================
   Migration 0409
   - New: usp_ValidateReturn
   - Updated: usp_RetireReturn
   ===================================================================== */

-- New: usp_ValidateReturn
CREATE OR ALTER PROCEDURE dbo.usp_ValidateReturn
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 BIT,
    @Param3 BIT = 0,
    @Param4 NVARCHAR(255) = NULL
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

-- Updated: usp_RetireReturn
CREATE OR ALTER PROCEDURE dbo.usp_RetireReturn
    @Param1 DATE = NULL,
    @Param2 BIT = 0,
    @Param3 BIT,
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 DATETIME2(0)
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
