/* =====================================================================
   Migration 0163
   - New: usp_ArchiveCustomer
   ===================================================================== */

-- New: usp_ArchiveCustomer
CREATE OR ALTER PROCEDURE dbo.usp_ArchiveCustomer
    @Param1 NVARCHAR(100) = NULL,
    @Param2 BIT = 0,
    @Param3 DECIMAL(10,2) = NULL,
    @Param4 NVARCHAR(255) = NULL
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
        -- or remove the target row(s) in dbo.Customers.
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
