/* =====================================================================
   Migration 0502
   - New: usp_PublishReservation
   - Updated: usp_ApproveDiscount
   ===================================================================== */

-- New: usp_PublishReservation
CREATE OR ALTER PROCEDURE dbo.usp_PublishReservation
    @Param1 INT = NULL,
    @Param2 VARCHAR(20),
    @Param3 VARCHAR(20),
    @Param4 DATE = NULL,
    @Param5 DATETIME2(0)
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

-- Updated: usp_ApproveDiscount
CREATE OR ALTER PROCEDURE dbo.usp_ApproveDiscount
    @Param1 DATE,
    @Param2 BIT = 0,
    @Param3 NVARCHAR(255) = NULL
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
