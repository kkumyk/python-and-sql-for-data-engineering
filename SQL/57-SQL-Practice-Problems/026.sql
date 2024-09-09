-- 026. High freight charges in 2015

-- MS SQL Server
Select Top 3
    ShipCountry,
    AverageFright = Avg(freight)
From Orders
Where OrderDate >= '20150101' and OrderDate < '20160101' -- YYYYMMDD
Group By ShipCountry
Order By AverageFright desc

/*
Learnings:
Where year(OrderData) = 2015
*/

-- PostgreSQL
SELECT
    ShipCountry,
    AVG(freight) AS AverageFreight
FROM Orders
WHERE OrderDate >= '2015-01-01'
  AND OrderDate < '2016-01-01'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;


SELECT
    ShipCountry,
    AVG(freight) AS AverageFreight
FROM Orders
WHERE EXTRACT(YEAR FROM OrderDate) = 2015
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

/*
Learnings:
The date format in PostgreSQL is YYYY-MM-DD.
The EXTRACT(YEAR FROM OrderDate) function extracts the year from the OrderDate field.
*/