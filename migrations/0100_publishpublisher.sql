/* =====================================================================
   Migration 0100
   - New: usp_PublishPublisher
   - Updated: usp_GetReturn
   - Updated: usp_UpdateCustomer
   ===================================================================== */

-- New: usp_PublishPublisher
CREATE OR ALTER PROCEDURE dbo.usp_PublishPublisher
    @Param1 NVARCHAR(255),
    @Param2 VARCHAR(20),
    @Param3 DATE,
    @Param4 BIT = 0
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

-- Updated: usp_GetReturn
CREATE OR ALTER PROCEDURE dbo.usp_GetReturn
    @Param1 BIT,
    @Param2 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_UpdateCustomer
CREATE OR ALTER PROCEDURE dbo.usp_UpdateCustomer
    @Param1 DATE
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
        -- update the target row(s) in dbo.Customers.
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
