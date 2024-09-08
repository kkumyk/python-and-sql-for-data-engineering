-- 21. Total customers per country/city

-- MS SQL Server
Select Country, City, TotalCustomers = count(*)
From Customers
Group by Country, City
Order by count(*) desc

-- PostgreSQL
SELECT Country, City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country, City
ORDER BY COUNT(*) DESC;

/*
Learnings:

Once you have a Group by clause in a SQL statement, every field that appears in the Select statement needs
to either appear in the Group by clause, or needs to have some kind of aggregate function applied to it.
*/