/* =====================================================================
   Migration 0234
   - New: usp_ApproveReturn
   - Updated: usp_UpdateReturn
   ===================================================================== */

-- New: usp_ApproveReturn
CREATE OR ALTER PROCEDURE dbo.usp_ApproveReturn
    @Param1 DECIMAL(10,2),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 VARCHAR(20)
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

-- Updated: usp_UpdateReturn
CREATE OR ALTER PROCEDURE dbo.usp_UpdateReturn
    @Param1 DATE,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 BIT = 0,
    @Param4 INT = NULL
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
