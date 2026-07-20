/* =====================================================================
   Migration 0219
   - New: usp_DuplicateBook
   ===================================================================== */

-- New: usp_DuplicateBook
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateBook
    @Param1 DATE,
    @Param2 VARCHAR(20)
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
        -- update the target row(s) in dbo.Books.
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
