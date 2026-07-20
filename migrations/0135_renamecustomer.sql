/* =====================================================================
   Migration 0135
   - New: usp_RenameCustomer
   - Updated: usp_ArchiveReservation
   ===================================================================== */

-- New: usp_RenameCustomer
CREATE OR ALTER PROCEDURE dbo.usp_RenameCustomer
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(100),
    @Param3 DATETIME2(0) = NULL,
    @Param4 NVARCHAR(255) = NULL
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

-- Updated: usp_ArchiveReservation
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveReservation
    @Param1 NVARCHAR(100) = NULL,
    @Param2 DATE,
    @Param3 VARCHAR(20) = NULL
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
        -- or remove the target row(s) in dbo.Reservations.
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
