/* 52. Countries with suppliers or customers
Extract a list of all countries where supplies and/or customers are based.
Hint:
Use the Union statement for this. It's a good way of putting together a simple result set from multiple SQL statements. 
The are two ways of using the Union statement. One is a simple Union statement as it is expected in the solution here.
Using a simple Union statement eliminates all the duplicates in the result set.

Expected Result:
   country   
-------------
 Argentina
 Australia
 Austria
 ...
 UK
 USA
 Venezuela
(25 rows) */

SELECT
  country
FROM
  suppliers
UNION
SELECT
  country
FROM
  customers 
ORDER BY country;
