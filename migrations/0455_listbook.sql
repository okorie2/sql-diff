/* =====================================================================
   Migration 0455
   - New: usp_ListBook
   - Updated: usp_RenameSubscription
   ===================================================================== */

-- New: usp_ListBook
CREATE OR ALTER PROCEDURE dbo.usp_ListBook
    @Param1 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Books
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_RenameSubscription
CREATE OR ALTER PROCEDURE dbo.usp_RenameSubscription
    @Param1 INT = NULL,
    @Param2 INT,
    @Param3 DATETIME2(0) = NULL
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
        -- update the target row(s) in dbo.Subscriptions.
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
