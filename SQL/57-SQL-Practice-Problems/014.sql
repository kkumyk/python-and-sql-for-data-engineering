-- 14. How many customers?

SELECT
    TotalCustomers = count(*)
FROM customers; -- MS SQL Server

SELECT count(*) as TotalCustomers
FROM Customers; -- PostgreSQL