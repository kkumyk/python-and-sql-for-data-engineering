/* 55. First order in each country - Window/Ranking functions

Return details for each order made first in a particular country, ordered by order_id.

Expected Result:
shipcountry | customerid | orderid | orderdate  
-------------+------------+---------+------------
 Argentina   | OCEAN      |   10409 | 1997-01-09
 Austria     | ERNSH      |   10258 | 1996-07-17
 Belgium     | SUPRD      |   10252 | 1996-07-09
 Brazil      | HANAR      |   10250 | 1996-07-08
 Canada      | MEREP      |   10332 | 1996-10-17
 Denmark     | SIMOB      |   10341 | 1996-10-29
 Finland     | WARTH      |   10266 | 1996-07-26
 France      | VINET      |   10248 | 1996-07-04
 Germany     | TOMSP      |   10249 | 1996-07-05
 Ireland     | HUNGO      |   10298 | 1996-09-05
 Italy       | MAGAA      |   10275 | 1996-08-07
 Mexico      | CENTC      |   10259 | 1996-07-18
 Norway      | SANTG      |   10387 | 1996-12-18
 Poland      | WOLZA      |   10374 | 1996-12-05
 Portugal    | FURIB      |   10328 | 1996-10-14
 Spain       | ROMEY      |   10281 | 1996-08-14
 Sweden      | FOLKO      |   10264 | 1996-07-24
 Switzerland | CHOPS      |   10254 | 1996-07-11
 UK          | BSBEV      |   10289 | 1996-08-26
 USA         | RATTC      |   10262 | 1996-07-22
 Venezuela   | HILAA      |   10257 | 1996-07-16
(21 rows)

Hint:
Because of some limitations with Window functions, you cannot directly filter the computed column, Use a CTE to solve the problem.

Notes on RANK, Window function and PARTITION:
The RANK() function is used in conjunction with a window function and partitioning to assign a rank to each order based on its order date, grouped by shipcountry.

RANK():
The RANK() function is a window function that assigns a unique rank to each row within the specified partition.
The rank starts at 1 for the first row and increases by 1 for each subsequent row.
Note that, if there are rows with the same value in the column you’re ordering by, RANK() will assign the same rank to those rows but leave a gap in the ranking for the next distinct value.
As a result, if two rows are tied for the first rank, both will get rank 1, but the next row will get rank 3 (not 2)!
In the query below, RANK() is applied over the rows partitioned by shipcountry and ordered by orderdate.
This means that within each shipcountry, orders are ranked by orderdate.

Window Function:
A window function allows you to perform calculations across a set of table rows that are somehow related to the current row.
Unlike aggregate functions like SUM(), COUNT(), which collapse multiple rows into a single result,
window functions retain the individual rows and calculate the value based on other rows in the "window."
In the query below, RANK() is the window function, and it operates over a "window" of rows determined by the PARTITION BY and ORDER BY clauses.

Partitioning (PARTITION BY shipcountry):
The partitioning part of the query is the PARTITION BY shipcountry in the RANK() function.
This clause divides the dataset into groups (partitions) based on the value of shipcountry.
Each group of rows with the same shipcountry will have their own independent ranking.
Without the PARTITION BY, the RANK() function would apply to the entire dataset as a single group, ranking all rows based on orderdate across the entire table.
With PARTITION BY shipcountry, the ranking starts fresh for each unique shipcountry, so each country’s orders are ranked separately.

Order (ORDER BY orderdate):
The ORDER BY orderdate clause determines the order in which the rows within each partition are ranked.
The orders are sorted by orderdate in ascending order, so the earliest orders get the rank of 1, the second-earliest get the rank of 2, and so on.

Query Summary:
1. Rank Orders:
    - for each order, the RANK() function assigns a rank based on the order date within each shipcountry:
        the earliest order gets rank 1, the next gets rank 2 etc.
2. PARTITION BY shipcountry:
    - ensures that the ranking is reset for each country:
        if shipcountry = 'US', it ranks the orders of US customers separately from the orders of customers in other countries.
3. ORDER BY orderdate:
    - within each shipcountry, the orders are ranked by orderdate, with the earliest orders getting the lowest rank (1, 2, 3, etc.).
4. Filter with WHERE ranking = 1:
    after the ranking is applied, the WHERE ranking = 1 clause filters out only the first-ranked order per country (i.e., the earliest order in each shipcountry).

The final result will contain the earliest order for each shipcountry, and the results will be ordered by shipcountry alphabetically. */

WITH ranked_orders AS (
  SELECT
    shipcountry,
    customerid,
    orderid,
    orderdate,
    rank() OVER (PARTITION BY shipcountry ORDER BY orderdate) as ranking
  FROM
    orders
)
SELECT
  shipcountry,
  customerid,
  orderid,
  orderdate
FROM
  ranked_orders
WHERE
  ranking = 1
ORDER BY
  shipcountry;