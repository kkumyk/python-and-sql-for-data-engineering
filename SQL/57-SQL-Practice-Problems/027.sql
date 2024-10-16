/* 027. High freight charges with between

another solution to the previous task - get high freight charges for a specific year - using BETWEEN operator

Focus: return records for a specific time frame using BETWEEN operator
*/

SELECT
  shipcountry,
  avg(freight) as avg_freight
FROM
  orders
WHERE
  orderdate between '1997-01-01' and '1998-01-01'
GROUP BY
  shipcountry
ORDER BY
  avg_freight DESC
LIMIT 3;