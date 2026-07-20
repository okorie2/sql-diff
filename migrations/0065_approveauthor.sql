/* =====================================================================
   Migration 0065
   - New: usp_ApproveAuthor
   - Updated: usp_DuplicateDiscount
   ===================================================================== */

-- New: usp_ApproveAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ApproveAuthor
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(100) = NULL,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DECIMAL(10,2) = NULL,
    @Param5 BIT
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

-- Updated: usp_DuplicateDiscount
CREATE OR ALTER PROCEDURE dbo.usp_DuplicateDiscount
    @Param1 BIT,
    @Param2 DATETIME2(0),
    @Param3 INT,
    @Param4 VARCHAR(20),
    @Param5 DECIMAL(10,2)
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
        -- update the target row(s) in dbo.Discounts.
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
