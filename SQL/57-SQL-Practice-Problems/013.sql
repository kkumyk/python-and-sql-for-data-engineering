-- 13. OrderDetails amount per line item

SELECT
    OrderId,
    ProductID,
    UnitPrice,
    Quantity,
    TotalPrice =  UnitPrice * Quantity
FROM OrderDetails
ORDER BY
    OrderId,
    ProductID; -- MS SQL Server

SELECT
    OrderId,
    ProductID,
    UnitPrice,
    Quantity,
    TotalPrice =  UnitPrice * Quantity
FROM OrderDetails
ORDER BY
    OrderId,
    ProductID; -- PostgreSQL

    -- -- OrderId	ProductID	UnitPrice	Quantity	TotalPrice
    -- -       1	101	        10.00         2	        20.00
    -- -       1	102	        15.00         1     	15.00
    -- -       2	101	        10.00         3	        30.00
