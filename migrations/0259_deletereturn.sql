/* =====================================================================
   Migration 0259
   - New: usp_DeleteReturn
   - Updated: usp_ArchiveCustomer
   ===================================================================== */

-- New: usp_DeleteReturn
CREATE OR ALTER PROCEDURE dbo.usp_DeleteReturn
    @Param1 DECIMAL(10,2),
    @Param2 VARCHAR(20),
    @Param3 DATETIME2(0),
    @Param4 DATE,
    @Param5 VARCHAR(20)
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
        -- or remove the target row(s) in dbo.Returns.
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

-- Updated: usp_ArchiveCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveCustomer
    @Param1 DATETIME2(0),
    @Param2 DATE,
    @Param3 NVARCHAR(255) = NULL,
    @Param4 VARCHAR(20) = NULL,
    @Param5 DATE
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
