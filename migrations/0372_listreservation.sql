/* =====================================================================
   Migration 0372
   - New: usp_ListReservation
   - Updated: usp_TransferSupplier
   ===================================================================== */

-- New: usp_ListReservation
CREATE OR ALTER PROCEDURE dbo.usp_ListReservation
    @Param1 BIT,
    @Param2 VARCHAR(20),
    @Param3 NVARCHAR(100) = NULL,
    @Param4 DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_TransferSupplier
CREATE OR ALTER PROCEDURE dbo.usp_TransferSupplier
    @Param1 NVARCHAR(100) = NULL
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
        -- update the target row(s) in dbo.Suppliers.
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
