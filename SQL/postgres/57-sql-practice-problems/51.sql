/* 51. Customer grouping - flexible

Add flexibility in grouping the customers based on the amount they have ordered.
Don't edit the previous SQL query to change the boundaries of the customer groups.
Instead use customergroupthreshold to define the customer groups.

The returned result will give the same result as in the previous problem.
However, instead of using hard-coded values in the Case statement to define the boundaries of the customer groups,
the boundary values are provided in a table:

  SELECT
    CASE
      WHEN o.total_spend < 1000 THEN 'Low'
      WHEN o.total_spend BETWEEN 1000 AND 5000 THEN 'Medium'
      WHEN o.total_spend BETWEEN 5000 AND 10000 THEN 'High'
      WHEN o.total_spend >= 10000 THEN 'Very High'
    END as group
  FROM
    orders_1998 o

will be replaced with:

  SELECT
    cgt.groupname as group
  FROM
    orders_1998 o
  JOIN
    customergroupthreshold cgt ON o.total between cgt.rangebottom AND cgt.rangetop

The benefit of this is that we don't need to duplicate the code in the case statement as in the previous solution.
*/

WITH orders_1998 AS (
  SELECT
    o.customerid,
    coalesce(sum(od.unitprice * od.quantity),0) as total
  FROM
    orders o
  JOIN
    order_details od on o.orderid = od.orderid
  WHERE
    EXTRACT(YEAR FROM o.orderdate) = 1998
  GROUP BY
    o.customerid
), customer_groups AS (
  SELECT
    cgt.groupname as group
  FROM
    orders_1998 o
  JOIN
    customergroupthreshold cgt ON o.total between cgt.rangebottom AND cgt.rangetop
), groups_count AS (
  SELECT
    cg.group,
    count(cg.group) as group_total
  FROM
    customer_groups cg
  GROUP BY
    cg.group
)
SELECT
  gc.group,
  gc.group_total,
  (100*gc.group_total/(SELECT sum(group_total) FROM groups_count)) as percentage
FROM
  groups_count gc
ORDER BY
  gc.group_total DESC;