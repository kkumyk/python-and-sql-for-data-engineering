/* 31. Customers with no orders for employee with ID 4

Because the filters in the Where clause are applied after the results of the Join, the ID filter should be applied in the Join clause.

Expected Result:
 customerid | customerid 
------------+------------
 CONSH      | 
 DUMON      | 
 FISSA      | 
 FRANR      | 
 GROSR      | 
 LAUGB      | 
 LAZYK      | 
 NORTS      | 
 PARIS      | 
 PERIC      | 
 PRINI      | 
 SANTG      | 
 SEVES      | 
 SPECD      | 
 THEBI      | 

Focus: Filtering with the JOIN clause instead of the WHERE clause */

SELECT
  c.customerid,
  o.customerid
FROM
  customers c
LEFT JOIN
  orders o on c.customerid = o.customerid 
  and o.employeeid = 4
WHERE
  o.customerid is null
  order by c.customerid;