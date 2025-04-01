/* 40. Orders - accidental double entry details, derived table

- Another way of getting the same result as in 39 task.
- This time the solution is based on a derived table instead of a CTE.
- The main table order_details od will be joined with the potential_problem table containing unique orderid s. This table was extracted via a subquery.
- The subquery find orderid s  in the order_details table that meet two conditions: 
    - orders with eat least one line item with the quantity of 60 or more
    - there are multiple line items with the same quantity under the same orderid: having count(*)>1

Expected Result:
 orderid | productid | unitprice | quantity | discount 
---------+-----------+-----------+----------+----------
   10263 |        16 |      13.9 |       60 |     0.25
   10263 |        24 |       3.6 |       28 |        0
   10263 |        30 |      20.7 |       60 |     0.25
   10263 |        74 |         8 |       36 |     0.25
   10658 |        21 |        10 |       60 |        0
   10658 |        40 |      18.4 |       70 |     0.05
   10658 |        60 |        34 |       55 |     0.05
   10658 |        77 |        13 |       70 |     0.05
   10990 |        21 |        10 |       65 |        0
   10990 |        34 |        14 |       60 |     0.15
   10990 |        55 |        24 |       65 |     0.15
   10990 |        61 |      28.5 |       66 |     0.15
   11030 |         2 |        19 |      100 |     0.25
   11030 |         5 |     21.35 |       70 |        0
   11030 |        29 |    123.79 |       60 |     0.25
   11030 |        59 |        55 |      100 |     0.25
(16 rows) */
 
SELECT
  od.orderid,
  od.productid,
  od.unitprice,
  od.quantity,
  od.discount
FROM
  order_details od
JOIN (
  SELECT
    DISTINCT orderid
  FROM
    order_details
  WHERE
    quantity >= 60
  GROUP BY
    orderid, quantity
  HAVING
    count(*) > 1
  ) potential_problem on potential_problem.orderid = od.orderid
ORDER BY
  od.orderid, od.productid;