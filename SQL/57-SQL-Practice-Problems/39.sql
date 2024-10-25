/* 39. Orders - accidental double entry details

CTE + Sub-query Expected Result:
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
   11030 |        59 |        55 |      100 |     0.25 */

WITH repeated_quantities AS (
    SELECT
      orderid
    FROM
      order_details
    WHERE
      quantity >= 60
    GROUP BY
      orderid, quantity
    HAVING
      count(*) > 1
)
SELECT
  orderid,
  productid,
  unitprice,
  quantity,
  discount
FROM
  order_details
WHERE
  orderid in (SELECT orderid FROM repeated_quantities)
ORDER BY
    orderid;

/* The query consists of two parts:

I. CTE - repeated_quantities:
    - find orders with at least one product with a quantity of 60 or more
    - the quantity should appear more than once within the same order 

    CTE result: a list of orderid values that match the above criteria

II. Main Query - uses the result of CTE
    - uses the list of orderid values to return the full details of the matching orders

Learnings: CTE (Common Table Expression)
- a temporary result set to reference withing a SELECT, INSERT, UPDATE, DELETE statements;
- WITH clause defines it
- used to simplify complex queries
- only exist for the duration of the query
- not stored as part of db schema
- can reference itself - recursive CTE
- multiple CTEs can be chained together */