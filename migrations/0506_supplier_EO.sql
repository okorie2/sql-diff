/* =====================================================================
   Migration 0506
   - Updates 4 procs originally introduced by the generated test set
     (migrations 0006–0505): usp_RenameSupplier, usp_DeleteOrder,
     usp_UpdateOrder, usp_MergeWarehouse
   - Replaces their placeholder bodies with real logic and adds a
     parameter to each, so the diff report has genuine signature +
     body changes to detect (not just param-list churn)
   ===================================================================== */

/* -----------------------------------------------------------------------
   1. dbo.usp_RenameSupplier — last defined in migration 0489.
      Adds real UPDATE logic against dbo.Suppliers and validates @Param3.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATE          = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Param1 IS NULL)
    BEGIN
        RAISERROR('usp_RenameSupplier: @Param1 cannot be null.', 16, 1);
        RETURN;
    END

    IF (@Param3 IS NOT NULL AND @Param3 > CAST(SYSUTCDATETIME() AS DATE))
    BEGIN
        RAISERROR('usp_RenameSupplier: @Param3 cannot be in the future.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE dbo.Suppliers
        SET
            SupplierName = CONCAT('Supplier-', @Param1),
            UpdatedAt    = ISNULL(@Param2, SYSUTCDATETIME())
        WHERE EffectiveDate = ISNULL(@Param3, EffectiveDate);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------
   2. dbo.usp_DeleteOrder — last defined in migration 0438.
      Adds @HardDelete to choose between soft and hard delete.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_DeleteOrder
    @Param1      DATETIME2(0),
    @Param2      VARCHAR(20),
    @Param3      DATE = NULL,
    @HardDelete  BIT  = 0
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF (@Param1 IS NULL)
        BEGIN
            RAISERROR('usp_DeleteOrder: @Param1 cannot be null.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END

        IF (@HardDelete = 1)
        BEGIN
            DELETE FROM dbo.Orders
            WHERE OrderDate = @Param1 AND Status = @Param2;
        END
        ELSE
        BEGIN
            UPDATE dbo.Orders
            SET Status = 'Cancelled', CancelledAt = SYSUTCDATETIME()
            WHERE OrderDate = @Param1 AND Status = @Param2;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------
   3. dbo.usp_UpdateOrder — last defined in migration 0403.
      Adds @UpdatedBy, defaulting to the calling principal, for audit.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_UpdateOrder
    @Param1     NVARCHAR(100),
    @Param2     DECIMAL(10,2) = NULL,
    @UpdatedBy  SYSNAME       = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Param1 IS NULL)
    BEGIN
        RAISERROR('usp_UpdateOrder: @Param1 cannot be null.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE dbo.Orders
        SET
            Status      = @Param1,
            TotalAmount = ISNULL(@Param2, TotalAmount),
            UpdatedBy   = ISNULL(@UpdatedBy, SUSER_SNAME()),
            UpdatedAt   = SYSUTCDATETIME()
        WHERE Status <> @Param1;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO

/* -----------------------------------------------------------------------
   4. dbo.usp_MergeWarehouse — last defined in migration 0386.
      Adds validation on @Param2 and real MERGE logic.
   ----------------------------------------------------------------------- */
CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
    @Param1 DATETIME2(0) = NULL,
    @Param2 INT           = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    IF (@Param1 IS NULL)
    BEGIN
        RAISERROR('usp_MergeWarehouse: @Param1 cannot be null.', 16, 1);
        RETURN;
    END

    IF (@Param2 IS NOT NULL AND @Param2 < 0)
    BEGIN
        RAISERROR('usp_MergeWarehouse: @Param2 cannot be negative.', 16, 1);
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        MERGE dbo.Warehouses AS target
        USING (SELECT @Param2 AS WarehouseID, @Param1 AS LastSyncedAt) AS source
            ON target.WarehouseID = source.WarehouseID
        WHEN MATCHED THEN
            UPDATE SET target.LastSyncedAt = source.LastSyncedAt
        WHEN NOT MATCHED THEN
            INSERT (WarehouseID, LastSyncedAt)
            VALUES (source.WarehouseID, source.LastSyncedAt);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF (XACT_STATE() <> 0)
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO