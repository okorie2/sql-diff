/* =====================================================================
   Migration 0336
   - Updated: usp_UpdateOrder
   - Updated: usp_ListReturn
   ===================================================================== */

-- Updated: usp_UpdateOrder
CREATE OR ALTER PROCEDURE dbo.usp_UpdateOrder
    @Param1 VARCHAR(20),
    @Param2 VARCHAR(20),
    @Param3 DATE = NULL,
    @Param4 DATETIME2(0) = NULL,
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

-- Updated: usp_ListReturn
CREATE OR ALTER PROCEDURE dbo.usp_ListReturn
    @Param1 BIT = 0,
    @Param2 NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT TOP (100) *
    FROM dbo.Returns
    WHERE @Param1 IS NULL OR 1 = 1;
END
GO
