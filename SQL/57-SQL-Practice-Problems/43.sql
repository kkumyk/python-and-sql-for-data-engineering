/* 43. Late orders vs. total orders

Expected Result:
 employeeid | lastname  | total | late_orders 
------------+-----------+-------+-------------
          4 | Peacock   |   156 |          10
          3 | Leverling |   127 |           5
          1 | Davolio   |   123 |           3
          8 | Callahan  |   104 |           5
          2 | Fuller    |    96 |           4
          7 | King      |    72 |           4
          6 | Suyama    |    67 |           3
          9 | Dodsworth |    43 |           5
          5 | Buchanan  |    42 |           1
(9 rows)

Hint:
- you can use more CTE in one query
- the are two SQL statements that could be put into CTE: late and total orders
*/

-- Late Orders (from 42 task):
SELECT
  o.employeeid, e.lastname, count(o.orderid) as late_orders 
FROM
  orders o
JOIN
  employees e ON o.employeeid=e.employeeid
WHERE
  requireddate <= shippeddate
GROUP BY
  o.employeeid, e.lastname
ORDER BY
  count(o.orderid) DESC;

-- Total Orders (reusing prev solution and removing by row filtering with WHERE):
SELECT
  o.employeeid, e.lastname, count(o.orderid) as total
FROM
  orders o
JOIN
  employees e ON o.employeeid=e.employeeid
GROUP BY
  o.employeeid, e.lastname
ORDER BY
  count(o.orderid) DESC;

-- Two CTEs combined solution:
WITH late_orders AS (
    SELECT
    o.employeeid, e.lastname, count(o.orderid) as lates
    FROM
    orders o
    JOIN
    employees e ON o.employeeid=e.employeeid
    WHERE
    requireddate <= shippeddate
    GROUP BY
    o.employeeid, e.lastname
    ORDER BY
    count(o.orderid) DESC
  ), total_orders as (
    SELECT o.employeeid, e.lastname, count(o.orderid) as total
        FROM
        orders o
        JOIN
        employees e ON o.employeeid=e.employeeid
        GROUP BY
        o.employeeid, e.lastname
        ORDER BY
        count(o.orderid) DESC
  )
  SELECT
    total_orders.employeeid,total_orders.lastname, total_orders.total, late_orders.lates
  FROM
    total_orders
  JOIN late_orders ON late_orders.employeeid=total_orders.employeeid;

/*
  Two CTEs combined solution optimization:
    1.  Combine CTEs using conditional aggregation and calculate both metrics - total and late orders in a single CTE.
        This will reduces the number of times the order table needs to be scanned and removes the need of joining two CTEs.
    2.  Remove ORDER BY clause from both CTEs as they don't impact the final output.
        Sorting should be done only in the main query to reduce the processing workload.
    3.  Use COALESCE to handle missing late orders: if a sales person does not have any late orders, the final output will recunt NULL.
        We can use COALESCE to replace NULL with 0.
*/

WITH orders_summary as (
    SELECT
        o.employeeid, e.lastname,
        count(o.orderid) as total,
        count(CASE WHEN o.requireddate<=o.shippeddate THEN 1 END) as late_orders
    FROM orders o
    JOIN 
        employees e ON o.employeeid=e.employeeid
    GROUP BY
        o.employeeid, e.lastname
)
SELECT
    os.employeeid, os.lastname, os.total, COALESCE(os.late_orders, 0) as late_orders
FROM
    orders_summary os
ORDER BY
    os.total DESC;

