/* =====================================================================
   Migration 0475
   - Updated: usp_RetireCustomer
   - Updated: usp_DuplicateReview
   ===================================================================== */

-- Updated: usp_RetireCustomer
CREATE OR ALTER PROCEDURE dbo.usp_RetireCustomer
    @Param1 BIT,
    @Param2 DECIMAL(10,2),
    @Param3 DATE,
    @Param4 INT
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
        -- or remove the target row(s) in dbo.Customers.
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

-- Updated: usp_DuplicateReview
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateReview
    @Param1 NVARCHAR(100),
    @Param2 DATETIME2(0),
    @Param3 DATETIME2(0),
    @Param4 BIT,
    @Param5 DECIMAL(10,2) = NULL
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
