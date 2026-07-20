/* =====================================================================
   Migration 0292
   - New: usp_RenameReturn
   ===================================================================== */

-- New: usp_RenameReturn
CREATE OR ALTER PROCEDURE dbo.usp_RenameReturn
    @Param1 INT = NULL,
    @Param2 INT,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 BIT = 0,
    @Param5 DECIMAL(10,2) = NULL
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
