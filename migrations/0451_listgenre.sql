/* =====================================================================
   Migration 0451
   - New: usp_ListGenre
   - Updated: usp_SyncCustomer
   ===================================================================== */

-- New: usp_ListGenre
CREATE OR ALTER PROCEDURE dbo.usp_ListGenre
    @Param1 DATE,
    @Param2 DECIMAL(10,2),
    @Param3 DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Genres
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SyncCustomer
CREATE OR ALTER PROCEDURE dbo.usp_SyncCustomer
    @Param1 BIT,
    @Param2 DATE,
    @Param3 DATETIME2(0)
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
