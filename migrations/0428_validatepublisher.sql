/* =====================================================================
   Migration 0428
   - New: usp_ValidatePublisher
   - Updated: usp_ListSubscription
   - Updated: usp_ListAuthor
   ===================================================================== */

-- New: usp_ValidatePublisher
CREATE OR ALTER PROCEDURE dbo.usp_ValidatePublisher
    @Param1 BIT = 0,
    @Param2 NVARCHAR(255),
    @Param3 DATETIME2(0)
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
        -- update the target row(s) in dbo.Publishers.
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

-- Updated: usp_ListSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ListSubscription
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100),
    @Param3 BIT = 0,
    @Param4 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Subscriptions
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ListAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ListAuthor
    @Param1 DATE = NULL,
    @Param2 INT = NULL,
    @Param3 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
