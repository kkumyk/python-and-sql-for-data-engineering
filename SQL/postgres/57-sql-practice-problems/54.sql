/* 54. Countries with suppliers or customers - version 3
Improve the results from the previous query and return:
- country name
- total number of suppliers and customers. 

Expected Result:

   country   | total_suppliers | total_customers 
-------------+-----------------+----------------
 Argentina   |               0 |              3
 Australia   |               2 |              0
 Austria     |               0 |              2
 Belgium     |               0 |              2
 Brazil      |               9 |              9
 Canada      |               6 |              6
 Denmark     |               2 |              2
 Finland     |               2 |              2
 France      |              33 |             33
 Germany     |              33 |             33
 Ireland     |               0 |              1
 Italy       |               6 |              6
 Japan       |               2 |              0
 Mexico      |               0 |              5
 Netherlands |               1 |              0
 Norway      |               1 |              1
 Poland      |               0 |              1
 Portugal    |               0 |              2
 Singapore   |               1 |              0
 Spain       |               5 |              5
 Sweden      |               4 |              4
 Switzerland |               0 |              2
 UK          |              14 |             14
 USA         |              52 |             52
 Venezuela   |               0 |              4
(25 rows) */

WITH countries AS (
  SELECT country FROM suppliers
  UNION
  SELECT country FROM customers
)
SELECT
  c.country,
  COALESCE(COUNT(sp.country), 0) AS total_suppliers,
  COALESCE(COUNT(ct.country), 0) AS total_customers
FROM
  countries c
LEFT JOIN
  suppliers sp ON c.country = sp.country
LEFT JOIN
  customers ct ON c.country = ct.country
GROUP BY
  c.country
ORDER BY c.country;