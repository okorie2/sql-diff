/* =====================================================================
   Migration 0397
   - New: usp_RetireAuthor
   - Updated: usp_ArchiveReservation
   ===================================================================== */

-- New: usp_RetireAuthor
CREATE OR ALTER PROCEDURE dbo.usp_RetireAuthor
    @Param1 INT,
    @Param2 BIT,
    @Param3 NVARCHAR(100) = NULL,
    @Param4 VARCHAR(20),
    @Param5 NVARCHAR(255) = NULL
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
        -- or remove the target row(s) in dbo.Authors.
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
    @Param1 INT,
    @Param2 DATETIME2(0),
    @Param3 BIT = 0,
    @Param4 DATE
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
