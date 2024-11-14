/* 49. Customer grouping - fix null
The previous solution does not handle NULL values when it comes with the customer groups.
Adjust the query from the previous task to address this.
Using BETWEEN works well with integer values. However, the value we are working with is money, which has decimals.
Adjust the CASE expression to address it too by replacing BETWEEN with AND.

Hint:
Knowing the data types you are working with and understanding the differences between them is important to get the right results.
Using BETWEEN would have been fine for integer values, but not form money. */

WITH orders_1998 AS (
  SELECT
    o.customerid,
    COALESCE(SUM(od.unitprice * od.quantity), 0) AS total
  FROM
    orders o
  JOIN
    order_details od ON o.orderid = od.orderid
  WHERE
    EXTRACT(YEAR FROM o.orderdate) = 1998
  GROUP BY
    o.customerid
)
SELECT
  c.customerid,
  c.companyname,
  o.total,
  CASE
    WHEN o.total < 1000 THEN 'Low'
    WHEN o.total >= 1000 AND o.total < 5000 THEN 'Medium'
    WHEN o.total >= 5000 AND o.total < 10000 THEN 'High'
    WHEN o.total >= 10000 THEN 'Very High'
  END AS group
FROM
  customers c
JOIN
  orders_1998 o ON c.customerid = o.customerid
ORDER BY
  c.customerid;