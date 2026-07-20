/* =====================================================================
   Migration 0416
   - Updated: usp_DeleteBook
   ===================================================================== */

-- Updated: usp_DeleteBook
CREATE OR ALTER PROCEDURE dbo.usp_DeleteBook
    @Param1 DATE = NULL,
    @Param2 DATETIME2(0),
    @Param3 DATE = NULL
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
        -- or remove the target row(s) in dbo.Books.
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
