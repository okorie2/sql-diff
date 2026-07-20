/* =====================================================================
   Migration 0077
   - New: usp_GetReservation
   ===================================================================== */

-- New: usp_GetReservation
CREATE OR ALTER PROCEDURE dbo.usp_GetReservation
    @Param1 NVARCHAR(255),
    @Param2 INT = NULL,
    @Param3 DATE = NULL,
    @Param4 NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
