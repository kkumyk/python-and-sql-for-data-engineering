/* Late Orders vs total orders - fix null | multiple CTEs in combination with COALESCE, INNER and LEFT joins

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
(9 rows) */

WITH late_orders AS (
  SELECT
    employeeid,
    count(employeeid) AS total_lates
  FROM
    orders
  WHERE
    requireddate <= shippeddate
  GROUP BY
    employeeid
), 
orders_summary AS (
   SELECT
    employeeid,
    count(employeeid) AS total
  FROM
    orders
  GROUP BY
    employeeid
)
SELECT
  os.employeeid,
  e.lastname,
  os.total,
  COALESCE(lo.total_lates, 0) AS late_orders
FROM
  orders_summary os
JOIN
  employees e ON os.employeeid = e.employeeid
LEFT JOIN
  late_orders lo ON os.employeeid = lo.employeeid
ORDER BY
  os.total DESC;


/*
Explanations

1. CTE - late_orders returns the total number of late orders by an employee:

 employeeid | total_late_orders
------------+-------
          8 |     5
          9 |     5
          7 |     4
          1 |     3
          5 |     1
          4 |    10
          2 |     4
          6 |     3
          3 |     5
(9 rows)

2. CTE - order_summary - the same CTE with the WHERE clause removed - returns all orders by an employee:
 employeeid | total 
------------+-------
          8 |   104
          7 |    72
          9 |    43
          1 |   123
          5 |    42
          2 |    96
          4 |   156
          6 |    67
          3 |   127
(9 rows)


*/