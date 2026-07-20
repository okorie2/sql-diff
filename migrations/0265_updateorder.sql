/* =====================================================================
   Migration 0265
   - New: usp_UpdateOrder
   - Updated: usp_ValidateAuthor
   ===================================================================== */

-- New: usp_UpdateOrder
CREATE OR ALTER PROCEDURE dbo.usp_UpdateOrder
    @Param1 NVARCHAR(100),
    @Param2 DECIMAL(10,2) = NULL,
    @Param3 INT
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
        -- update the target row(s) in dbo.Orders.
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

-- Updated: usp_ValidateAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ValidateAuthor
    @Param1 INT = NULL,
    @Param2 DATETIME2(0) = NULL,
    @Param3 VARCHAR(20),
    @Param4 BIT = 0,
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
