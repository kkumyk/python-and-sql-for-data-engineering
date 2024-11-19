/* 57. Customers with multiple orders in 5 days or less between orders - v2 
 Use Window functions to solve 

Expected Result:
 customerid | initial_order_id | initial_order_date | next_order_date | daysbetween 
------------+------------------+--------------------+-----------------+-------------
 ANTON      |            10677 | 1997-09-22         | 1997-09-25      |           3
 AROUT      |            10741 | 1997-11-14         | 1997-11-17      |           3
 BERGS      |            10278 | 1996-08-12         | 1996-08-14      |           2
 BERGS      |            10444 | 1997-02-12         | 1997-02-13      |           1
 BERGS      |            10866 | 1998-02-03         | 1998-02-06      |           3
 BONAP      |            10730 | 1997-11-05         | 1997-11-06      |           1
 BONAP      |            10871 | 1998-02-05         | 1998-02-09      |           4
 BONAP      |            10932 | 1998-03-06         | 1998-03-11      |           5
 BOTTM      |            10410 | 1997-01-10         | 1997-01-10      |           0
 BOTTM      |            10944 | 1998-03-12         | 1998-03-13      |           1
 BOTTM      |            10975 | 1998-03-25         | 1998-03-27      |           2
 BOTTM      |            11045 | 1998-04-23         | 1998-04-24      |           1
 BSBEV      |            10538 | 1997-05-15         | 1997-05-16      |           1
 BSBEV      |            10943 | 1998-03-11         | 1998-03-13      |           2
 EASTC      |            11047 | 1998-04-24         | 1998-04-28      |           4
 ERNSH      |            10402 | 1997-01-02         | 1997-01-03      |           1
 ERNSH      |            10771 | 1997-12-10         | 1997-12-11      |           1
 ERNSH      |            10773 | 1997-12-11         | 1997-12-15      |           4
 ERNSH      |            10968 | 1998-03-23         | 1998-03-26      |           3
 ERNSH      |            11008 | 1998-04-08         | 1998-04-13      |           5
 FOLKO      |            10977 | 1998-03-26         | 1998-03-27      |           1
 FOLKO      |            10980 | 1998-03-27         | 1998-04-01      |           5
 FOLKO      |            10993 | 1998-04-01         | 1998-04-06      |           5
 FRANK      |            10670 | 1997-09-16         | 1997-09-19      |           3
 GODOS      |            10872 | 1998-02-05         | 1998-02-06      |           1
 GREAL      |            10616 | 1997-07-31         | 1997-07-31      |           0
 HANAR      |            10250 | 1996-07-08         | 1996-07-10      |           2
 
Query Explanation Notes:

CTE and LEAD
    - Uses a LEAD window function to retrieve the next order date for each customer directly within the same table scan (orders).
    - The LEAD function ensures that comparisons are made only between consecutive orders for each customer based on the orderdate.
    - The filtering of daysbetween happens in the final SELECT with WHERE.
    - The query results are strictly one-to-one, as each initial_order_id is compared only to its immediate next order (LEAD).
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
  (co.next_order_date - co.initial_order_date) <= 5;

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
- PARTITION BY divides the result set into partitions (groups of rows), so the LEAD function operates independently within each partition

*/