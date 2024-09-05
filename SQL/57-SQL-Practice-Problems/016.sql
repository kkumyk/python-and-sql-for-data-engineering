-- 16. Countries where there are customers 

SELECT Country FROM Customers GROUP BY Country; -- MS SQL Server
SELECT DISTINCT Country FROM Customers; -- MS SQL Server

SELECT "Country" FROM "Customers" GROUP BY "Country" -- PostgreSQL