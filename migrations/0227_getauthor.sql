/* =====================================================================
   Migration 0227
   - New: usp_GetAuthor
   - Updated: usp_SyncSupplier
   ===================================================================== */

-- New: usp_GetAuthor
CREATE OR ALTER PROCEDURE dbo.usp_GetAuthor
    @Param1 BIT,
    @Param2 VARCHAR(20),
    @Param3 BIT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Authors
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO

-- Updated: usp_SyncSupplier
CREATE OR ALTER PROCEDURE dbo.usp_SyncSupplier
    @Param1 VARCHAR(20) = NULL,
    @Param2 NVARCHAR(255) = NULL,
    @Param3 INT,
    @Param4 NVARCHAR(100) = NULL
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
