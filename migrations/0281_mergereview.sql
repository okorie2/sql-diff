/* =====================================================================
   Migration 0281
   - New: usp_MergeReview
   - Updated: usp_ListInvoice
   ===================================================================== */

-- New: usp_MergeReview
CREATE OR ALTER PROCEDURE dbo.usp_MergeReview
    @Param1 DATETIME2(0),
    @Param2 INT,
    @Param3 DATE = NULL,
    @Param4 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Reviews.
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

-- Updated: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT = 0,
    @Param3 NVARCHAR(255),
    @Param4 BIT,
    @Param5 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
