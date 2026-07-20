/* =====================================================================
   Migration 0046
   - New: usp_RestoreReturn
   ===================================================================== */

-- New: usp_RestoreReturn
CREATE OR ALTER PROCEDURE dbo.usp_RestoreReturn
    @Param1 NVARCHAR(100),
    @Param2 NVARCHAR(255),
    @Param3 NVARCHAR(100)
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
