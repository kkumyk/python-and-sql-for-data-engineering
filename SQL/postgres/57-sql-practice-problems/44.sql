/* 44. Late orders vs. total orders - missing employee | LEFT JOIN

Adjust the previous solution so that all employees who have taken orders are returned even though they are not associated with late orders. 

Hint: use left (outer) join to make sure that we show a row, evn if there are no late orders.
*/

WITH late_orders AS (
    SELECT
        o.employeeid, count(o.orderid) as lates
    FROM
        orders o
    JOIN
        employees e ON o.employeeid=e.employeeid
    WHERE
        requireddate <= shippeddate
    GROUP BY
        o.employeeid
  ), total_orders as (
    SELECT
        o.employeeid, count(o.orderid) as total
    FROM
        orders o
    GROUP BY
        o.employeeid
  ) SELECT
        too.employeeid,
        e.lastname,
        too.total,
        lo.lates
    FROM
        total_orders too
    INNER JOIN
        employees e ON too.employeeid=e.employeeid
    LEFT JOIN
        late_orders lo ON too.employeeid=lo.employeeid
    ORDER BY
        too.total DESC;
  