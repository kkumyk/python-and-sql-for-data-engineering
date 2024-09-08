-- 023. Products that need reordering, continued

-- MS SQL Server
Select ProductId, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
From Products
Where UnitsInStock + UnitsOnOrder <= ReorderLevel and Discontinued = 'false'
Order by ProductID 

-- PostgreSQL
SELECT ProductId, ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued
FROM Products
WHERE (UnitsInStock + UnitsOnOrder) <= ReorderLevel AND Discontinued = false
ORDER BY ProductID;

/*
Learnings:

Discontinued = 0 | Discontinued = 'false'

*/