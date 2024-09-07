-- 19. Orders and the Shipper that was used

Select
    OrderID, OrderDate = convert(date, OrderDate), Shipper = CompanyName
From Orders
    Join Shippers
        on Shippers.ShipperID = Orders.ShipVia
Where ProductID < 10270
Order by OrderID -- MS SQL Server

SELECT OrderID, OrderDate::date AS OrderDate, CompanyName AS Shipper
FROM Orders
JOIN Shippers ON Shippers.ShipperID = Orders.ShipVia
WHERE ProductID < 10270
ORDER BY OrderID; -- PostgreSQL

/*
Learnings:

Casting Data Types
In Postgres, ::type casts columns to different data types; cast a column to a date using ::date.
*/