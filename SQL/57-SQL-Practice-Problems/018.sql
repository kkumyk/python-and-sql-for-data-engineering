-- 18. Products with associated supplier names

Select ProductId, ProductName, Supplier = CompanyName
From Products
Join Suppliers on Products.SupplierID = Suppliers.SupplierID  -- MS SQL Server

SELECT ProductId, ProductName, CompanyName AS Supplier
FROM Products
JOIN Suppliers ON Products.SupplierID = Suppliers.SupplierID; -- PostgreSQL

/*
Learnings:

Alias with AS keyword in Postgres and = in SQL Server
In SQL Server, you can use =, but in Postgres, this is written as CompanyName AS Supplier.
*/