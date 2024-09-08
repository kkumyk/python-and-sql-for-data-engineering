-- 22. Products that need reordering

-- MS SQL Server
Select ProductID, ProductName, UnitsInStock, ReorderLevel
From Products
Where UnitsInStock <= ReorderLevel
Order by ProductID

-- PostgreSQL
SELECT ProductID, ProductName, UnitsInStock, ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel
ORDER BY ProductID;

/*
Learnings:

Instead of using a string or numeric value to filter, another field can be used.

*/