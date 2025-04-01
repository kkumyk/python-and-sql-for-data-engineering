/* 32. High-value customers -  total orders
- high-value customers are:
    - customers which have made orders totaling more than $15k

Expected Result:
 customerid |         companyname          | total_amount 
------------+------------------------------+--------------
 SAVEA      | Save-a-lot Markets           |     42806.25
 ERNSH      | Ernst Handel                 |     42598.90
 QUICK      | QUICK-Stop                   |     40526.99
 HANAR      | Hanari Carnes                |     24238.05
 HUNGO      | Hungry Owl All-Night Grocers |     22796.34
 RATTC      | Rattlesnake Canyon Grocery   |     21725.60
 KOENE      | Königlich Essen              |     20204.95
 FOLKO      | Folk och fä HB               |     15973.85
 WHITC      | White Clover Markets         |     15278.90

Learnings: Having clause
    - aggregate functions can only be used in the Having clause, not in the Where clause;
    - the above is the case because the Where filters the records, and does not filter aggregations;
    - the Where keyword filters individual records;
    - Having filters aggregations;

Focus: Grouping at a customer level, not at the order level as opposed to the previous task.
*/

SELECT
  c.customerid,
  c.companyname,
 -- o.orderid, 
  round(sum(od.unitprice * od.quantity)::numeric, 2) as total_amount
FROM
  customers c
INNER JOIN
  orders o on c.customerid = o.customerid
INNER JOIN
  order_details od on o.orderid = od.orderid
WHERE
  date_part('year', o.orderdate) = 1998
GROUP BY
  c.customerid, c.companyname
-- , o.orderid
HAVING
  sum(od.unitprice * od.quantity) > 15000
ORDER BY total_amount DESC;