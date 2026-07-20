/* =====================================================================
   Migration 0342
   - New: usp_UnpublishPublisher
   ===================================================================== */

-- New: usp_UnpublishPublisher
CREATE OR ALTER PROCEDURE dbo.usp_UnpublishPublisher
    @Param1 BIT = 0,
    @Param2 INT = NULL,
    @Param3 VARCHAR(20),
    @Param4 NVARCHAR(255) = NULL
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
        -- or remove the target row(s) in dbo.Publishers.
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
