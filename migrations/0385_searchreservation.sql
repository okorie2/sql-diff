/* =====================================================================
   Migration 0385
   - New: usp_SearchReservation
   - Updated: usp_MergeInvoice
   - Updated: usp_ArchiveSubscription
   ===================================================================== */

-- New: usp_SearchReservation
CREATE OR ALTER PROCEDURE dbo.usp_SearchReservation
    @Param1 NVARCHAR(255),
    @Param2 NVARCHAR(255) = NULL,
    @Param3 VARCHAR(20) = NULL,
    @Param4 VARCHAR(20) = NULL,
    @Param5 BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_MergeInvoice
CREATE OR ALTER PROCEDURE dbo.usp_MergeInvoice
    @Param1 DATE,
    @Param2 VARCHAR(20)
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
        -- update the target row(s) in dbo.Invoices.
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

-- Updated: usp_ArchiveSubscription
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveSubscription
    @Param1 DATE = NULL,
    @Param2 DECIMAL(10,2) = NULL
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
        -- or remove the target row(s) in dbo.Subscriptions.
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
