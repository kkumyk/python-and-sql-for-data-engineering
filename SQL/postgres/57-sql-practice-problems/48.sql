/* 48. Customer Grouping
Task:
- put customers into groups based on their spend in a specific year
- grouping categories are:
    - Low: 0 to 1,000
    - Medium: 1,000 to 5,000
    - High: 5,000 to 10,000
    - Very High: over 10,000
- order results by customerid

Hints:
- a good starting point would be the solution to "32. High-value customers - total orders" with the aggregated filter for order totals over 15000 removed
- the above query can be used as CTE followed by CASE statement applied on the total order amount

Expected Result:
customerid |            companyname             |       total        |   group   
------------+------------------------------------+--------------------+-----------
 ALFKI      | Alfreds Futterkiste                |  2302.199996948242 | Medium
 ANATR      | Ana Trujillo Emparedados y helados |  514.3999910354614 | Low
... some rows are omitted; the total should be 81:
 WILMK      | Wilman Kala                        | 1986.9999809265137 | Medium
 WOLZA      | Wolski  Zajazd                     | 1865.0999908447266 | Medium
(81 rows) */

SELECT
  c.customerid,
  c.companyname,
  round(sum(od.unitprice * od.quantity)::numeric, 2) as total
FROM
  customers c
INNER JOIN
  orders o on c.customerid = o.customerid
INNER JOIN
  order_details od on o.orderid = od.orderid
WHERE
  date_part('year', o.orderdate) = 1998
GROUP BY
  c.customerid, c.companyname
ORDER BY total DESC;

/*
The above query returns and can be used as CTE in the final solution:
customerid |            companyname             | total 
------------+------------------------------------+--------------
 SAVEA      | Save-a-lot Markets                 |     42806.25
 ERNSH      | Ernst Handel                       |     42598.90
 QUICK      | QUICK-Stop                         |     40526.99
*/

-- Solution:
WITH orders_year AS (
    SELECT
        c.customerid,
        c.companyname,
        sum(od.unitprice * od.quantity) as total
    FROM
        customers c
    JOIN
        orders o on c.customerid = o.customerid
    JOIN
        order_details od on o.orderid = od.orderid
    WHERE
        date_part('year', o.orderdate) = 1998
    GROUP BY
        c.customerid, c.companyname
    ORDER BY total DESC
) SELECT
    c.customerid,
    o.companyname,
    o.total,
CASE
    WHEN o.total < 1000 THEN 'Low'
    WHEN o.total BETWEEN 1000 AND 5000 THEN 'Medium'
    WHEN o.total BETWEEN 5000 AND 10000 THEN 'High'
    WHEN o.total >= 10000 THEN 'Very High'
END AS group
FROM
customers c
JOIN
orders_year o ON c.customerid = o.customerid
ORDER BY
c.customerid;