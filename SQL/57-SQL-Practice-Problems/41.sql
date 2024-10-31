/* 41. Late orders
- find orders that have arrived late
- sort the results vby orderid

Hint:
To determine which orders are late, use a combination of the required date and shipping date.
The shipping date is usually after the required date so you can be sure it is late.

Expected Result:
 orderid | orderdate  | requireddate | shippeddate 
---------+------------+--------------+-------------
   10264 | 1996-07-24 | 1996-08-21   | 1996-08-23
   10271 | 1996-08-01 | 1996-08-29   | 1996-08-30
   10280 | 1996-08-14 | 1996-09-11   | 1996-09-12
   10302 | 1996-09-10 | 1996-10-08   | 1996-10-09 ...
   10960 | 1998-03-19 | 1998-04-02   | 1998-04-08
   10970 | 1998-03-24 | 1998-04-07   | 1998-04-24
   10978 | 1998-03-26 | 1998-04-23   | 1998-04-23
   10998 | 1998-04-03 | 1998-04-17   | 1998-04-17
(40 rows)
*/

SELECT
  orderid,
  orderdate,
  requireddate,
  shippeddate
FROM
  orders
WHERE
  requireddate <= shippeddate;


