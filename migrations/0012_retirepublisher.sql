/* =====================================================================
   Migration 0012
   - New: usp_RetirePublisher
   - Updated: usp_GetReview
   ===================================================================== */

-- New: usp_RetirePublisher
CREATE OR ALTER PROCEDURE dbo.usp_RetirePublisher
    @Param1 DATETIME2(0) = NULL,
    @Param2 INT,
    @Param3 NVARCHAR(100),
    @Param4 BIT,
    @Param5 BIT = 0
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

-- Updated: usp_GetReview
CREATE OR ALTER PROCEDURE dbo.usp_GetReview
    @Param1 INT,
    @Param2 NVARCHAR(255),
    @Param3 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reviews
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
