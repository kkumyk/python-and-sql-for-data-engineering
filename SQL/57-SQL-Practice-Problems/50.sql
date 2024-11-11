/* 50. Customer Grouping with Percentage
Show all the defined customer groups and the percentage in each.
Sort by the total in each group, in descending order.

Hint: Use CTE to get the counts in each customer grouping for the final output.

Solution Notes:
Three CTEs will be used in the final solution:
    1. total spend by customer in a specific year based on orders and order_details relations;
         customerid |    total_spend     
        ------------+--------------------
        ALFKI      |  2302.199996948242
        ANATR      |  514.3999910354614
        ANTON      |                660 ... 
    2. customer_groups CTE will use the initial CTE to define customers into groups;
       group   
        -----------
        Medium
        Low
        Low ...
    3. groups_count CTE will use customer_groups CTE to count the number of customers in a group:
    Expected Result:
      group   | group_total |     percentage      
    -----------+-------------+---------------------
    Medium    |          36 | 44.4444444444444444
    Low       |          20 | 24.6913580246913580
    Very High |          13 | 16.0493827160493827
    High      |          12 | 14.8148148148148148
    (4 rows)

The final SELECT statement is a nested SELECT statement that calculates the percentages in a group. */

WITH orders_1998 AS (
  SELECT
    o.customerid,
    COALESCE(sum(od.unitprice * od.quantity), 0) as total_spend
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
    CASE
      WHEN o.total_spend < 1000 THEN 'Low'
      WHEN o.total_spend BETWEEN 1000 AND 5000 THEN 'Medium'
      WHEN o.total_spend BETWEEN 5000 AND 10000 THEN 'High'
      WHEN o.total_spend >= 10000 THEN 'Very High'
    END as group
  FROM
    orders_1998 o
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