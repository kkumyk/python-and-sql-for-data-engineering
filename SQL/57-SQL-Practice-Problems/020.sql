-- 20. Categories, and the total products in each category

Select CompanyName, TotalPRoducts = count(*)
From Products 
    Join Categories on Products.CategoryID = Categories.CategoryID    
Group by CompanyName
Order by count(*) desc-- MS SQL Server


SELECT CompanyName, COUNT(*) AS TotalProducts
FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
GROUP BY CompanyName
ORDER BY COUNT(*) DESC; -- PostgreSQL