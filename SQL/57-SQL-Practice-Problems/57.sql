/* 57. Customers with multiple orders in 5 days or less between orders - v2 
 Use Window functions to solve 

Expected Result:
 customerid | initial_order_id | initial_order_date | next_order_date | daysbetween 
------------+------------------+--------------------+-----------------+-------------
 ANTON      |            10677 | 1997-09-22         | 1997-09-25      |           3
 AROUT      |            10741 | 1997-11-14         | 1997-11-17      |           3
 BERGS      |            10278 | 1996-08-12         | 1996-08-14      |           2
(69 rows)

Query Explanation Notes:

CTE with LEAD window function
    - Uses a LEAD window function to retrieve the next order date for each customer directly within the same table scan (orders).
    - The LEAD function ensures that comparisons are made only between consecutive orders for each customer based on the orderdate.
    - The filtering of daysbetween happens in the final SELECT with WHERE.
    - The query results are strictly one-to-one, as each initial_order_id is compared only to its immediate next order (LEAD).

* selects all columns from the customer_orders CTE, here: customerid, initial_order_id, initial_order_date and next_order_date.

Note, that:
- for LEAD(o.orderdate) it is necessary to explicitly reference the column orderdate in the orders table;
- PARTITION BY customerid works without the alias because SQL automatically assumes that the customerid column comes from the table defined in the FROM clause, in this case, orders.
*/

WITH customer_orders AS (
  SELECT
    customerid,
    orderid as initial_order_id,
    orderdate as initial_order_date,
    LEAD (o.orderdate, 1)
        OVER ( PARTITION BY customerid ORDER BY orderdate) AS next_order_date
  FROM
    orders o
  ORDER BY
    o.customerid, o.orderdate
)
SELECT
  *,
  (co.next_order_date - co.initial_order_date) as daysbetween
FROM
  customer_orders co
WHERE
  (co.next_order_date - co.initial_order_date) <= 5; -- basically, WHERE daysbetween less or equal than 5

/* Learning Notes

The LEAD function
- a part of the window functions family;
- allows you to access the value of a column from the next row (in a result set) without a self-join;
- particularly useful when comparing values between consecutive rows in a sorted order;
- commonly used in time-series analysis, where you want to compare the current row's value to the next row's value.

Syntax of LEAD:
LEAD(expression, offset, default_value) 
    OVER (PARTITION BY partition_columns ORDER BY order_columns)

- expression - the column/calculation whose "next" value to retrieve
- offset (optional) - the number of rows to look ahead from the current row (default=1 / the immediate next row
- default_value (optional) - the value to return if there is no "next" row (e.g.: for the last row, this will be used).
- PARTITION BY divides the result set into partitions (groups of rows), so the LEAD function operates independently within each partition */