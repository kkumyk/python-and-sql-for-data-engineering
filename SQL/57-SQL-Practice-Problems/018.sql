-- 18. Products with associated supplier names

Select ProductId, ProductName, Supplier = CompanyName
From Products
Join Suppliers on Products.SupplierID = Suppliers.SupplierID  -- MS SQL Server

 -- PostgreSQL