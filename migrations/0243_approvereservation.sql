/* =====================================================================
   Migration 0243
   - New: usp_ApproveReservation
   - Updated: usp_ListInvoice
   - Updated: usp_ApproveAuthor
   ===================================================================== */

-- New: usp_ApproveReservation
CREATE OR ALTER PROCEDURE dbo.usp_ApproveReservation
    @Param1 DATETIME2(0) = NULL
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
        -- update the target row(s) in dbo.Reservations.
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

-- Updated: usp_ListInvoice
CREATE OR ALTER PROCEDURE dbo.usp_ListInvoice
    @Param1 NVARCHAR(255) = NULL,
    @Param2 VARCHAR(20),
    @Param3 BIT,
    @Param4 BIT = 0,
    @Param5 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Invoices
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ApproveAuthor
CREATE OR ALTER PROCEDURE dbo.usp_ApproveAuthor
    @Param1 BIT,
    @Param2 DATETIME2(0) = NULL,
    @Param3 NVARCHAR(100)
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
