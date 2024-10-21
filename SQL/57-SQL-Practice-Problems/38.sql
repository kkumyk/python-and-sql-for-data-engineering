/* Orders - accidental double entries

 orderid | productid | unitprice | quantity | discount 
---------+-----------+-----------+----------+----------
   10263 |        16 |      13.9 |       60 |     0.25
   10263 |        24 |       3.6 |       28 |        0
   10263 |        30 |      20.7 |       60 |     0.25
   10263 |        74 |         8 |       36 |     0.25

Expected Result:

 orderid | nr_of_orders 
---------+--------------
   10263 |            2
   10658 |            2
   10990 |            2
   11030 |            2
(4 rows)                *

Learning Focus: 
- grouping data by multiple columns and its affect on the returned result 
- difference between filtering with WHERE (pre-aggregation) and HAVING (post-aggregation)
- using an aggregation function COUNT() to calculate the number of rows in each filtered group  */

SELECT
  orderid, count(orderid) as nr_of_orders
FROM
  order_details
WHERE
  quantity >= 60
GROUP BY
  orderid, quantity
HAVING
  count(*) > 1
ORDER BY
  orderid;

