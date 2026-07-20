/* =====================================================================
   Migration 0300
   - New: usp_GetInvoice
   - Updated: usp_AddReview
   ===================================================================== */

-- New: usp_GetInvoice
CREATE OR ALTER PROCEDURE dbo.usp_GetInvoice
    @Param1 DECIMAL(10,2) = NULL,
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 DATETIME2(0)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_AddReview
CREATE OR ALTER PROCEDURE dbo.usp_AddReview
    @Param1 DATETIME2(0) = NULL,
    @Param2 BIT
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
