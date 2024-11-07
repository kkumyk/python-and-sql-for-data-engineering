/* Late Orders vs. total orders - percentage
- get the percentage of late orders over total orders

Expected Result:
 employeeid | lastname  | total | late_orders |       percentage       
------------+-----------+-------+-------------+------------------------
          9 | Dodsworth |    43 |           5 | 0.11627906976744186047
          4 | Peacock   |   156 |          10 | 0.06410256410256410256
          7 | King      |    72 |           4 | 0.05555555555555555556
          8 | Callahan  |   104 |           5 | 0.04807692307692307692
          6 | Suyama    |    67 |           3 | 0.04477611940298507463
          2 | Fuller    |    96 |           4 | 0.04166666666666666667
          3 | Leverling |   127 |           5 | 0.03937007874015748031
          1 | Davolio   |   123 |           3 | 0.02439024390243902439
          5 | Buchanan  |    42 |           1 | 0.02380952380952380952
(9 rows)

Hint:
Integer divided by integer returns the closes integer: 3/2 = 1 not 1.5
A common way of handling this is to convert one of the integers to a decimal data type,
e.g.: by multiplying it with 1.00 before the division.
*/

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
    coalesce(lo.total_late_orders,0) AS late_orders,
    coalesce((lo.total_late_orders::decimal/os.totals), 0) as percentage
  FROM
    orders_summary os
  JOIN employees e ON os.employeeid=e.employeeid
  LEFT JOIN late_orders lo ON os.employeeid=lo.employeeid
  ORDER BY percentage DESC;
