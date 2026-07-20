/* =====================================================================
   Migration 0228
   - New: usp_SearchPublisher
   - Updated: usp_ApproveAuthor
   ===================================================================== */

-- New: usp_SearchPublisher
CREATE OR ALTER PROCEDURE dbo.usp_SearchPublisher
    @Param1 VARCHAR(20) = NULL,
    @Param2 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Publishers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ApproveAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ApproveAuthor
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 NVARCHAR(255) = NULL
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
        -- update the target row(s) in dbo.Authors.
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
