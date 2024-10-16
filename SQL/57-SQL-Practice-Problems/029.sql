/*
29. Employee/Order detail report (join four tables) displaying only specific fields

Expected Result:
 employeeid | lastname  | orderid |           productname            | quantity 
------------+-----------+---------+----------------------------------+----------
          5 | Buchanan  |   10248 | Queso Cabrales                   |       12
          5 | Buchanan  |   10248 | Singaporean Hokkien Fried Mee    |       10
          5 | Buchanan  |   10248 | Mozzarella di Giovanni           |        5
          6 | Suyama    |   10249 | Tofu                             |        9
          6 | Suyama    |   10249 | Manjimup Dried Apples            |       40 ... 

Focus: practice (inner) joins across multiple tables */

SELECT
  o.employeeid,
  e.lastname,
  o.orderid,
  p.productname,
  od.quantity
FROM
  orders o
JOIN
  employees e on o.employeeid = e.employeeid
JOIN
  order_details od on o.orderid = od.orderid
JOIN
  products p on od.productid = p.productid
ORDER BY
  o.orderid, od.productid;