/* 34. High-value customers - with discount
    - use discount when calculating high-value customers
    - the discount is applied as a percentage
    - use parenthesis around (1 - Discount) to make sure that calculation is done first
    - order by total amount, taking into consideration the discount

Expected Result:
 customerid |         companyname          | total_amount 
------------+------------------------------+--------------
 ERNSH      | Ernst Handel                 |     41210.65
 QUICK      | QUICK-Stop                   |     37217.31
 SAVEA      | Save-a-lot Markets           |     36310.11
 HANAR      | Hanari Carnes                |     23821.20
 RATTC      | Rattlesnake Canyon Grocery   |     21238.27
 HUNGO      | Hungry Owl All-Night Grocers |     20402.12
 KOENE      | Königlich Essen              |     19582.77
 WHITC      | White Clover Markets         |     15278.90
(8 rows)

Learnings:
The new calculation for order totals with discounts needs to be used three times in the:
    1. SELECT statement when defining the alias 
    2. HAVING clause - here we cannot use the alias and the calculation needs to be repeated
    3. ORDER BY clause - here we can reuse the alias created in the SELECT statement.

Focus: Calculating fields: when the alias for this field can be used, and when the actual calculation should be repeated in the query.

Issue Encountered:
When testing writing the query on the command line, kept getting "Column reference is ambiguous" error.
This was caused by a typo in the select statement when the two calculating columns were given the same name.
As a result, the name could not be resolved until it was corrected.
*/

SELECT
  c.customerid,
  c.companyname,
  round(sum((od.unitprice * od.quantity) * (1 - od.discount))::numeric, 2) as total_amount
FROM
  customers c
JOIN
  orders o on c.customerid = o.customerid
JOIN
  order_details od on o.orderid = od.orderid
WHERE
  date_part('year', o.orderdate) = 1998
GROUP BY
  c.customerid, c.companyname
HAVING
  sum(od.unitprice * od.quantity * (1 - od.discount)) >= 15000
ORDER BY
  total_amount DESC;