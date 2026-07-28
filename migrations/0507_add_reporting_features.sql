/* =====================================================================
   Migration 0507
   - Updates stored procedures introduced/modified in migration 0506
   - Adds supporting functions for validation and calculations
   - Creates new reporting tables
   - Designed to generate meaningful SQL object diffs
   ===================================================================== */


/* -----------------------------------------------------------------------
   1. Create supporting tables
   ----------------------------------------------------------------------- */

CREATE TABLE dbo.SupplierAuditLog
(
    AuditID        BIGINT IDENTITY(1,1) PRIMARY KEY,
    SupplierName   NVARCHAR(200) NOT NULL,
    ChangedBy      SYSNAME NOT NULL,
    ChangedAt      DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME(),
    ChangeType     VARCHAR(50) NOT NULL
);
GO


CREATE TABLE dbo.OrderStatusHistory
(
    HistoryID      BIGINT IDENTITY(1,1) PRIMARY KEY,
    OrderID        INT NOT NULL,
    PreviousStatus VARCHAR(50),
    NewStatus      VARCHAR(50) NOT NULL,
    ChangedBy      SYSNAME NOT NULL,
    ChangedAt      DATETIME2(0) NOT NULL DEFAULT SYSUTCDATETIME()
);
GO


CREATE TABLE dbo.WarehouseSyncLog
(
    SyncID         BIGINT IDENTITY(1,1) PRIMARY KEY,
    WarehouseID    INT NOT NULL,
    SyncTime       DATETIME2(0) NOT NULL,
    SyncStatus     VARCHAR(30) NOT NULL
);
GO


/* -----------------------------------------------------------------------
   2. Add scalar functions
   ----------------------------------------------------------------------- */


/*
   Calculates order priority based on amount.
*/
CREATE OR ALTER FUNCTION dbo.fn_GetOrderPriority
(
    @TotalAmount DECIMAL(10,2)
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Priority VARCHAR(20);

    IF (@TotalAmount >= 10000)
        SET @Priority = 'HIGH';
    ELSE IF (@TotalAmount >= 1000)
        SET @Priority = 'MEDIUM';
    ELSE
        SET @Priority = 'LOW';

    RETURN @Priority;
END;
GO


/*
   Validates supplier names before updates.
*/
CREATE OR ALTER FUNCTION dbo.fn_IsValidSupplierName
(
    @SupplierName NVARCHAR(200)
)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 0;

    IF (
        @SupplierName IS NOT NULL
        AND LEN(TRIM(@SupplierName)) >= 3
    )
        SET @Result = 1;

    RETURN @Result;
END;
GO


/* -----------------------------------------------------------------------
   3. Update dbo.usp_RenameSupplier
      Adds audit tracking and validation function usage
   ----------------------------------------------------------------------- */

CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATE = NULL,
    @UpdatedBy SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;


    DECLARE @NewSupplierName NVARCHAR(200);

    SET @NewSupplierName = CONCAT('Supplier-', @Param1);


    IF dbo.fn_IsValidSupplierName(@NewSupplierName) = 0
    BEGIN
        RAISERROR('usp_RenameSupplier: invalid supplier name.',16,1);
        RETURN;
    END


    BEGIN TRY
        BEGIN TRANSACTION;


        UPDATE dbo.Suppliers
        SET
            SupplierName = @NewSupplierName,
            UpdatedAt = ISNULL(@Param2, SYSUTCDATETIME())
        WHERE EffectiveDate = ISNULL(@Param3, EffectiveDate);



        INSERT INTO dbo.SupplierAuditLog
        (
            SupplierName,
            ChangedBy,
            ChangeType
        )
        VALUES
        (
            @NewSupplierName,
            ISNULL(@UpdatedBy,SUSER_SNAME()),
            'RENAME'
        );


        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END
GO



/* -----------------------------------------------------------------------
   4. Update dbo.usp_DeleteOrder
      Adds history tracking before cancellation
   ----------------------------------------------------------------------- */

CREATE OR ALTER PROCEDURE dbo.usp_DeleteOrder
(
    @Param1 DATETIME2(0),
    @Param2 VARCHAR(20),
    @Param3 DATE = NULL,
    @HardDelete BIT = 0,
    @DeletedBy SYSNAME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;


    BEGIN TRY

        BEGIN TRANSACTION;


        IF (@HardDelete = 1)
        BEGIN

            DELETE FROM dbo.Orders
            WHERE OrderDate = @Param1
            AND Status = @Param2;

        END
        ELSE
        BEGIN

            INSERT INTO dbo.OrderStatusHistory
            (
                OrderID,
                PreviousStatus,
                NewStatus,
                ChangedBy
            )
            SELECT
                OrderID,
                Status,
                'Cancelled',
                ISNULL(@DeletedBy,SUSER_SNAME())
            FROM dbo.Orders
            WHERE OrderDate = @Param1
            AND Status = @Param2;


            UPDATE dbo.Orders
            SET
                Status = 'Cancelled',
                CancelledAt = SYSUTCDATETIME()
            WHERE OrderDate = @Param1
            AND Status = @Param2;

        END


        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END
GO



/* -----------------------------------------------------------------------
   5. Update dbo.usp_UpdateOrder
      Adds automatic priority calculation
   ----------------------------------------------------------------------- */

CREATE OR ALTER PROCEDURE dbo.usp_UpdateOrder
(
    @Param1 NVARCHAR(100),
    @Param2 DECIMAL(10,2) = NULL,
    @UpdatedBy SYSNAME = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;


    BEGIN TRY

        BEGIN TRANSACTION;


        UPDATE dbo.Orders
        SET
            Status = @Param1,
            TotalAmount = ISNULL(@Param2,TotalAmount),
            Priority = dbo.fn_GetOrderPriority(
                ISNULL(@Param2,TotalAmount)
            ),
            UpdatedBy = ISNULL(@UpdatedBy,SUSER_SNAME()),
            UpdatedAt = SYSUTCDATETIME()
        WHERE Status <> @Param1;


        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END
GO



/* -----------------------------------------------------------------------
   6. Update dbo.usp_MergeWarehouse
      Adds sync logging
   ----------------------------------------------------------------------- */

CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
(
    @Param1 DATETIME2(0) = NULL,
    @Param2 INT = NULL
)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;


    BEGIN TRY

        BEGIN TRANSACTION;


        MERGE dbo.Warehouses AS target

        USING
        (
            SELECT
                @Param2 WarehouseID,
                @Param1 LastSyncedAt
        ) AS source

        ON target.WarehouseID = source.WarehouseID


        WHEN MATCHED THEN

            UPDATE SET
                LastSyncedAt = source.LastSyncedAt


        WHEN NOT MATCHED THEN

            INSERT
            (
                WarehouseID,
                LastSyncedAt
            )

            VALUES
            (
                source.WarehouseID,
                source.LastSyncedAt
            );


        INSERT INTO dbo.WarehouseSyncLog
        (
            WarehouseID,
            SyncTime,
            SyncStatus
        )
        VALUES
        (
            @Param2,
            @Param1,
            'SUCCESS'
        );


        COMMIT TRANSACTION;

    END TRY
    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;

    END CATCH
END
GO