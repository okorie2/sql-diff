/* =====================================================================
   Migration 0498
   - Updated: usp_SearchCustomer
   - Updated: usp_RenameReview
   ===================================================================== */

-- Updated: usp_SearchCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SearchCustomer
    @Param1 NVARCHAR(255),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 INT,
    @Param4 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Customers
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_RenameReview
CREATE OR ALTER PROCEDURE dbo.usp_RenameReview
    @Param1 NVARCHAR(100) = NULL
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
