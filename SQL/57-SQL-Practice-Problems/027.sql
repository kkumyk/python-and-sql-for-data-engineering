-- 027. High freight charges with between

-- PostgreSQL

SELECT
    ShipCountry,
    AVG(Fright) AS AverageFreight
FROM Orders
WHERE OrderDate BETWEEN '2015-01-01' AND '2015-12-31 23:59:59'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
LIMIT 3;

/*
Learnings:

Since OrderDate is datetime/timestamp, including the time ensures that the full year of 2015 is captured.
*/