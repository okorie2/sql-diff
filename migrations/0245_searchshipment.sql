/* =====================================================================
   Migration 0245
   - New: usp_SearchShipment
   - Updated: usp_ApproveBook
   ===================================================================== */

-- New: usp_SearchShipment
CREATE OR ALTER PROCEDURE dbo.usp_SearchShipment
    @Param1 DATETIME2(0),
    @Param2 NVARCHAR(255) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Shipments
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_ApproveBook
CREATE OR ALTER PROCEDURE dbo.usp_ApproveBook
    @Param1 BIT = 0,
    @Param2 DATETIME2(0) = NULL,
    @Param3 INT,
    @Param4 DATE
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
        -- update the target row(s) in dbo.Books.
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
