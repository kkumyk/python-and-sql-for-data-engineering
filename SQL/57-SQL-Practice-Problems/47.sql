/*
47. Late orders vs total orders - fix decimal

Cut the percentage of late orders off at 3 digits tot he right of the decimal point.

Expected Result:
 employeeid | lastname  | total | late_orders | percentage 
------------+-----------+-------+-------------+------------
          9 | Dodsworth |    43 |           5 |       0.12
          4 | Peacock   |   156 |          10 |       0.06
          7 | King      |    72 |           4 |       0.06
          8 | Callahan  |   104 |           5 |       0.05
          2 | Fuller    |    96 |           4 |       0.04
          6 | Suyama    |    67 |           3 |       0.04
          3 | Leverling |   127 |           5 |       0.04
          5 | Buchanan  |    42 |           1 |       0.02
          1 | Davolio   |   123 |           3 |       0.02
(9 rows) */

WITH late_orders AS (
    SELECT employeeid,
           count(employeeid) AS total_late_orders
    FROM   orders
    WHERE requireddate<=shippeddate
    GROUP BY
        employeeid
), orders_summary AS (
    SELECT  employeeid,
            count(employeeid) AS totals
    FROM orders
    GROUP BY
            employeeid
) SELECT
    os.employeeid,
    e.lastname,
    os.totals,
    COALESCE(lo.total_late_orders,0) AS late_orders,
    COALESCE(ROUND(lo.total_late_orders::decimal/os.totals, 2), 0) as percentage
  FROM
    orders_summary os
  JOIN employees e ON os.employeeid=e.employeeid
  LEFT JOIN late_orders lo ON os.employeeid=lo.employeeid
  ORDER BY percentage DESC;