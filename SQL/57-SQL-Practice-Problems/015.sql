-- 15. When was the first order?

SELECT FirstOrder = min(OrderDate)
FROM Orders; -- MS SQL Server

SELECT min(OrderDate) as FirstOrder
FROM Orders; -- PostgreSQL