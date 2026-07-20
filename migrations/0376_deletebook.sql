/* =====================================================================
   Migration 0376
   - New: usp_DeleteBook
   ===================================================================== */

-- New: usp_DeleteBook
CREATE OR ALTER PROCEDURE dbo.usp_DeleteBook
    @Param1 NVARCHAR(255),
    @Param2 DATETIME2(0) = NULL,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 INT = NULL
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
