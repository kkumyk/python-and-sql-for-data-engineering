/* 53. Countries with suppliers or customers - version 2

Instead of a raw list of countries from the previous task, return a list as shown below.
Expected Results:
 suplier_country | customer_country 
-----------------+------------------
                 | Argentina
 Australia       | 
                 | Austria
                 | Belgium
 Brazil          | Brazil
 Canada          | Canada
 Denmark         | Denmark
 Finland         | Finland
 France          | France
 Germany         | Germany
                 | Ireland
 Italy           | Italy
 Japan           | 
                 | Mexico
 Netherlands     | 
 Norway          | Norway
                 | Poland
                 | Portugal
 Singapore       | 
 Spain           | Spain
 Sweden          | Sweden
                 | Switzerland
 UK              | UK
 USA             | USA
                 | Venezuela
(25 rows)

Hint:
Use either Distinct or Group By to avoid duplicating countries.
CTEs are not always the right answer. The main case in which you should switch from a CTE to something else. e.g.:
a table variable or temporary table would be when you need to reference the results of the select statement multiple times.

Further Reading:
https://www.essentialsql.com/introduction-common-table-expressions-ctes/
https://www.essentialsql.com/recursive-cte/

Solution Notes:
1. CTE 1: countries returns a list of countries with duplicates removed from the list of all countries across suppliers and customers tables.
2. CTE 2: suppliercountry CTE returns a list of countries with duplicates removed from the suppliers table.
3. CTE 3: customercountry CTE: same as above for a list of countries from the customers table.
4. the main query is built using LEFT JOIN statements, joining the 2nd and the 3rd CTEs to the 1st CTE countries on the country field. */

WITH countries AS (
  SELECT
    country
  FROM
    suppliers
  UNION
  SELECT
    country
  FROM
    customers
), suppliercountry AS (
  SELECT
    distinct country
  FROM
    suppliers
), customercountry AS (
  SELECT
    distinct country
  FROM
    customers
)
SELECT
  sp.country as suplier_country,
  ct.country as customer_country
FROM
  countries c
LEFT JOIN
  suppliercountry sp on c.country = sp.country
LEFT JOIN
  customercountry ct on c.country = ct.country
ORDER BY c.country;
