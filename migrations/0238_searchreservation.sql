/* =====================================================================
   Migration 0238
   - New: usp_SearchReservation
   ===================================================================== */

-- New: usp_SearchReservation
CREATE OR ALTER PROCEDURE dbo.usp_SearchReservation
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20),
    @Param3 DECIMAL(10,2),
    @Param4 INT,
    @Param5 INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Reservations
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
