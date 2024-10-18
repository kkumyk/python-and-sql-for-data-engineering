/* 32. High-value customers
- find high-value customers with order value at least 10000
- high-value customers are:
    - made at least 1 order equal over 10000 or more not including the discount
    - for orders made only in 1998

Expected Result:
 customerid |         companyname          | orderid | total_amount 
------------+------------------------------+---------+--------------
 QUICK      | QUICK-Stop                   |   10865 |     17250.00
 SAVEA      | Save-a-lot Markets           |   11030 |     16321.90
 HANAR      | Hanari Carnes                |   10981 |     15810.00
 KOENE      | Königlich Essen              |   10817 |     11490.70
 RATTC      | Rattlesnake Canyon Grocery   |   10889 |     11380.00
 HUNGO      | Hungry Owl All-Night Grocers |   10897 |     10835.24

Learnings: Aggregate functions can only be used to filter in the Having clause, not the Where clause.

Focus: the use of aggregate functions in the HAVING clause */

SELECT
  c.customerid,
  c.companyname,
  o.orderid,
  round(sum(od.unitprice * od.quantity)::numeric, 2) as total_amount
FROM
  customers c
JOIN
  orders o on c.customerid = o.customerid
JOIN
  order_details od on o.orderid = od.orderid
WHERE
  date_part('year', o.orderdate) = 1998
GROUP BY
  c.customerid, c.companyname, o.orderid
HAVING
  sum(od.unitprice * od.quantity) >= 10000
ORDER BY
  total_amount DESC;

