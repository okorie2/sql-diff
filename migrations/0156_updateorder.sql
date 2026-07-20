/* =====================================================================
   Migration 0156
   - New: usp_UpdateOrder
   - Updated: usp_GetReservation
   ===================================================================== */

-- New: usp_UpdateOrder
CREATE OR ALTER PROCEDURE dbo.usp_UpdateOrder
    @Param1 DATETIME2(0) = NULL,
    @Param2 NVARCHAR(255)
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

-- Updated: usp_GetReservation
CREATE OR ALTER PROCEDURE dbo.usp_GetReservation
    @Param1 DATE = NULL,
    @Param2 VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
