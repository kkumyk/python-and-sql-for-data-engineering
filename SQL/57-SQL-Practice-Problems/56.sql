/* 56. Customers with multiple orders in 5 day period | SELF-JOIN

Expected Result:
customerid | initial_order_id | initial_order_date | nextorderid | nextorderdate | days_between_orders 
------------+------------------+--------------------+-------------+---------------+---------------------
 ANTON      |            10677 | 1997-09-22         |       10682 | 1997-09-25    |                   3
 AROUT      |            10741 | 1997-11-14         |       10743 | 1997-11-17    |                   3
 BERGS      |            10278 | 1996-08-12         |       10280 | 1996-08-14    |                   2
 BERGS      |            10444 | 1997-02-12         |       10445 | 1997-02-13    |                   1
 BERGS      |            10866 | 1998-02-03         |       10875 | 1998-02-06    |                   3
 BONAP      |            10730 | 1997-11-05         |       10732 | 1997-11-06    |                   1
 BONAP      |            10871 | 1998-02-05         |       10876 | 1998-02-09    |                   4
 BONAP      |            10932 | 1998-03-06         |       10940 | 1998-03-11    |                   5
 BOTTM      |            10410 | 1997-01-10         |       10411 | 1997-01-10    |                   0
 BOTTM      |            10944 | 1998-03-12         |       10949 | 1998-03-13    |                   1
 BOTTM      |            10975 | 1998-03-25         |       10982 | 1998-03-27    |                   2
 BOTTM      |            11045 | 1998-04-23         |       11048 | 1998-04-24    |                   1
 BSBEV      |            10538 | 1997-05-15         |       10539 | 1997-05-16    |                   1
 BSBEV      |            10943 | 1998-03-11         |       10947 | 1998-03-13    |                   2
 EASTC      |            11047 | 1998-04-24         |       11056 | 1998-04-28    |                   4
 ERNSH      |            10402 | 1997-01-02         |       10403 | 1997-01-03    |                   1
 ERNSH      |            10771 | 1997-12-10         |       10776 | 1997-12-15    |                   5
 ERNSH      |            10771 | 1997-12-10         |       10773 | 1997-12-11    |                   1
 ERNSH      |            10773 | 1997-12-11         |       10776 | 1997-12-15    |                   4
 ERNSH      |            10968 | 1998-03-23         |       10979 | 1998-03-26    |                   3
 ERNSH      |            11008 | 1998-04-08         |       11017 | 1998-04-13    |                   5
 FOLKO      |            10977 | 1998-03-26         |       10980 | 1998-03-27    |                   1
 FOLKO      |            10980 | 1998-03-27         |       10993 | 1998-04-01    |                   5
 FOLKO      |            10993 | 1998-04-01         |       11001 | 1998-04-06    |                   5
 FRANK      |            10670 | 1997-09-16         |       10675 | 1997-09-19    |                   3
 GODOS      |            10872 | 1998-02-05         |       10874 | 1998-02-06    |                   1
 GREAL      |            10616 | 1997-07-31         |       10617 | 1997-07-31    |                   0
 
Query Explanation Notes:
    - the query uses a self-join where the same table is joined with itself, enabling data comparison within the same dataset
    - a self join is a type of join where a table is joined with itself; useful when you need to compare rows within the same table
    - the query compares the initial order for each customer with their next order placed within 5 days
    - the comparison is always between orders made in chronological order (the initial_order comes before the next_order)
    - the orders table is used twice with different aliases:
        - initial_order for the initial order
        - next_order for the next order

Self Join Syntax:
The syntax for a self join is the same as for a regular join, but with one important difference -
the table is aliased twice to distinguish the two instances of the same table. See below.

  SELECT 
      a.column_name, 
      b.column_name
  FROM 
      table_name AS a
  JOIN 
      table_name AS b
  ON 
      a.common_column = b.common_column;

FROM orders initial_order:
defines the orders table as initial_order which refers to the first instance
the table itself is still orders, but the alias initial_order differentiates it from another instance of the same table - next_order */

SELECT
  initial_order.customerid,
  initial_order.orderid as initial_order_id,
  initial_order.orderdate as initial_order_date,
  next_order.orderid as nextorderid,
  next_order.orderdate as nextorderdate,
  (next_order.orderdate - initial_order.orderdate) as days_between_orders
FROM
  orders initial_order
JOIN
  orders next_order
ON
  initial_order.customerid = next_order.customerid
WHERE
  initial_order.orderid < next_order.orderid
  AND
  (next_order.orderdate - initial_order.orderdate) <= 5
ORDER BY
    initial_order.customerid,
    initial_order.orderid;