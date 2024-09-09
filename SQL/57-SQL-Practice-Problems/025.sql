-- 25. High freight charges

-- MS SQL Server
Select Top 3
    ShipCountry,
    AverageFright = Avg(freight)
From Orders
Group By ShipCountry
Order By AverageFright desc

-- Using Top is the easiest and most commonly used method of showing only a certain number of records. Another way is by using Offset:
Select
    ShipCountry,
    AverageFright = AVG(freight)
From Orders
Group By ShipCountry
Order By AverageFright desc
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY

-- PostgreSQL
SELECT ShipCountry, AVG(Freight) AS AverageFright
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFright DESC
LIMIT 3;

SELECT ShipCountry, AVG(Freight) AS AverageFright
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFright DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;

