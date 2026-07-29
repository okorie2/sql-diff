/* =====================================================================
   Migration 0508

   - Adds new supplier and reporting procedures
   - Updates existing procedures from migration 0507
   - Expands validation and calculation functions
   - Alters audit/reporting tables
   - Designed to generate meaningful SQL object diffs
   ===================================================================== */


/* -----------------------------------------------------------------------
   1. Alter existing tables
   ----------------------------------------------------------------------- */


ALTER TABLE dbo.SupplierAuditLog
ADD
    EntityID INT NULL,
    Details NVARCHAR(500) NULL;
GO


ALTER TABLE dbo.OrderStatusHistory
ADD
    Reason NVARCHAR(250) NULL;
GO


ALTER TABLE dbo.WarehouseSyncLog
ADD
    ErrorMessage NVARCHAR(1000) NULL;
GO


ALTER TABLE dbo.SupplierAuditLog
ADD CONSTRAINT CK_SupplierAuditLog_ChangeType
CHECK (ChangeType IN ('CREATE','RENAME','DELETE','UPDATE'));
GO


CREATE INDEX IX_OrderStatusHistory_OrderID
ON dbo.OrderStatusHistory(OrderID);
GO



/* -----------------------------------------------------------------------
   2. Update existing functions
   ----------------------------------------------------------------------- */


/*
    Updated priority calculation.
    Adds CRITICAL priority level.
*/
CREATE OR ALTER FUNCTION dbo.fn_GetOrderPriority
(
    @TotalAmount DECIMAL(10,2)
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @Priority VARCHAR(20);

    IF @TotalAmount >= 50000
        SET @Priority = 'CRITICAL';

    ELSE IF @TotalAmount >= 10000
        SET @Priority = 'HIGH';

    ELSE IF @TotalAmount >= 1000
        SET @Priority = 'MEDIUM';

    ELSE
        SET @Priority = 'LOW';


    RETURN @Priority;

END;
GO



/*
    Stronger supplier validation.
*/
CREATE OR ALTER FUNCTION dbo.fn_IsValidSupplierName
(
    @SupplierName NVARCHAR(200)
)
RETURNS BIT
AS
BEGIN

    DECLARE @Result BIT = 0;


    IF
    (
        @SupplierName IS NOT NULL
        AND LEN(TRIM(@SupplierName)) BETWEEN 3 AND 150
        AND @SupplierName NOT LIKE '%[^a-zA-Z0-9 ]%'
    )
        SET @Result = 1;


    RETURN @Result;

END;
GO



/*
    New function:
    Calculates supplier risk score.
*/
CREATE OR ALTER FUNCTION dbo.fn_CalculateSupplierRisk
(
    @SupplierName NVARCHAR(200),
    @OrderCount INT
)
RETURNS VARCHAR(20)
AS
BEGIN

    DECLARE @Risk VARCHAR(20);


    IF @OrderCount > 100
        SET @Risk = 'LOW';

    ELSE IF @OrderCount BETWEEN 20 AND 100
        SET @Risk = 'MEDIUM';

    ELSE
        SET @Risk = 'HIGH';


    RETURN @Risk;

END;
GO



/*
    New function:
    Calculates order age.
*/
CREATE OR ALTER FUNCTION dbo.fn_GetOrderAgeDays
(
    @OrderDate DATETIME2(0)
)
RETURNS INT
AS
BEGIN

    RETURN DATEDIFF
    (
        DAY,
        @OrderDate,
        SYSUTCDATETIME()
    );

END;
GO




/* -----------------------------------------------------------------------
   3. Update usp_RenameSupplier
   ----------------------------------------------------------------------- */


CREATE OR ALTER PROCEDURE dbo.usp_RenameSupplier
(
    @Param1 DECIMAL(10,2),
    @Param2 DATETIME2(0) = NULL,
    @Param3 DATE = NULL,
    @UpdatedBy SYSNAME = NULL
)
AS
BEGIN

    SET NOCOUNT ON;
    SET XACT_ABORT ON;


    DECLARE @NewSupplierName NVARCHAR(200);

    SET @NewSupplierName =
        CONCAT('Supplier-', @Param1);



    IF dbo.fn_IsValidSupplierName(@NewSupplierName) = 0
    BEGIN
        THROW 50001,
        'Invalid supplier name.',
        1;
    END



    IF EXISTS
    (
        SELECT 1
        FROM dbo.Suppliers
        WHERE SupplierName = @NewSupplierName
    )
    BEGIN
        THROW 50002,
        'Supplier name already exists.',
        1;
    END



    BEGIN TRY

        BEGIN TRANSACTION;


        UPDATE dbo.Suppliers
        SET
            SupplierName = @NewSupplierName,
            UpdatedAt = ISNULL(@Param2,SYSUTCDATETIME())
        WHERE EffectiveDate =
              ISNULL(@Param3,EffectiveDate);



        INSERT dbo.SupplierAuditLog
        (
            SupplierName,
            ChangedBy,
            ChangeType,
            Details
        )
        VALUES
        (
            @NewSupplierName,
            ISNULL(@UpdatedBy,SUSER_SNAME()),
            'RENAME',
            'Supplier renamed successfully'
        );


        COMMIT;

    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK;

        THROW;

    END CATCH

END;
GO




/* -----------------------------------------------------------------------
   4. Update usp_DeleteOrder
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


        IF @HardDelete = 1
        BEGIN

            INSERT dbo.OrderStatusHistory
            (
                OrderID,
                PreviousStatus,
                NewStatus,
                ChangedBy,
                Reason
            )
            SELECT
                OrderID,
                Status,
                'DELETED',
                ISNULL(@DeletedBy,SUSER_SNAME()),
                'Hard delete requested'
            FROM dbo.Orders
            WHERE OrderDate = @Param1
            AND Status = @Param2;



            DELETE dbo.Orders
            WHERE OrderDate = @Param1
            AND Status = @Param2;

        END

        ELSE

        BEGIN

            UPDATE dbo.Orders
            SET
                Status = 'Cancelled',
                CancelledAt = SYSUTCDATETIME()
            WHERE OrderDate = @Param1
            AND Status = @Param2;

        END


        COMMIT;


    END TRY

    BEGIN CATCH

        IF XACT_STATE() <> 0
            ROLLBACK;

        THROW;

    END CATCH

END;
GO




/* -----------------------------------------------------------------------
   5. Update usp_UpdateOrder
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


    IF @Param1 NOT IN
    (
        'Pending',
        'Processing',
        'Completed',
        'Cancelled'
    )
    BEGIN

        THROW 50003,
        'Invalid order status.',
        1;

    END



    UPDATE dbo.Orders
    SET
        Status = @Param1,
        TotalAmount =
            ISNULL(@Param2,TotalAmount),
        Priority =
            dbo.fn_GetOrderPriority(
                ISNULL(@Param2,TotalAmount)
            ),
        UpdatedBy =
            ISNULL(@UpdatedBy,SUSER_SNAME()),
        UpdatedAt =
            SYSUTCDATETIME()
    WHERE Status <> @Param1;

END;
GO




/* -----------------------------------------------------------------------
   6. Update usp_MergeWarehouse
   ----------------------------------------------------------------------- */


CREATE OR ALTER PROCEDURE dbo.usp_MergeWarehouse
(
    @Param1 DATETIME2(0)=NULL,
    @Param2 INT=NULL
)
AS
BEGIN

    SET NOCOUNT ON;


    BEGIN TRY

        MERGE dbo.Warehouses AS target

        USING
        (
            SELECT
                @Param2 WarehouseID,
                @Param1 LastSyncedAt

        ) source

        ON target.WarehouseID =
           source.WarehouseID


        WHEN MATCHED THEN

            UPDATE SET
                LastSyncedAt =
                source.LastSyncedAt


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


        INSERT dbo.WarehouseSyncLog
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


    END TRY

    BEGIN CATCH

        INSERT dbo.WarehouseSyncLog
        (
            WarehouseID,
            SyncTime,
            SyncStatus,
            ErrorMessage
        )
        VALUES
        (
            @Param2,
            SYSUTCDATETIME(),
            'FAILED',
            ERROR_MESSAGE()
        );


        THROW;

    END CATCH

END;
GO




/* -----------------------------------------------------------------------
   7. New stored procedure - Create Supplier
   ----------------------------------------------------------------------- */


CREATE OR ALTER PROCEDURE dbo.usp_CreateSupplier
(
    @SupplierName NVARCHAR(200),
    @CreatedBy SYSNAME
)
AS
BEGIN

    SET NOCOUNT ON;


    IF dbo.fn_IsValidSupplierName(@SupplierName)=0
        THROW 50004,
        'Invalid supplier.',
        1;


    INSERT dbo.Suppliers
    (
        SupplierName,
        CreatedAt
    )
    VALUES
    (
        @SupplierName,
        SYSUTCDATETIME()
    );


    INSERT dbo.SupplierAuditLog
    (
        SupplierName,
        ChangedBy,
        ChangeType
    )
    VALUES
    (
        @SupplierName,
        @CreatedBy,
        'CREATE'
    );

END;
GO




/* -----------------------------------------------------------------------
   8. New stored procedure - Order Reporting
   ----------------------------------------------------------------------- */


CREATE OR ALTER PROCEDURE dbo.usp_GetOrderReport
(
    @MinimumAmount DECIMAL(10,2)=0
)
AS
BEGIN

    SELECT
        OrderID,
        Status,
        TotalAmount,
        Priority,
        dbo.fn_GetOrderAgeDays(OrderDate)
            AS OrderAgeDays

    FROM dbo.Orders

    WHERE TotalAmount >= @MinimumAmount;

END;
GO