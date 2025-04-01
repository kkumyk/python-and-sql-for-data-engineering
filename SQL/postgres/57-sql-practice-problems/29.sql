/* 29. Employee and Order detail report displaying only specific fields

Task: show employees and order detail information (orderid, productname, quantity).

Expected Result:
 employeeid | lastname  | orderid |           productname            | quantity 
------------+-----------+---------+----------------------------------+----------
          5 | Buchanan  |   10248 | Queso Cabrales                   |       12
          5 | Buchanan  |   10248 | Singaporean Hokkien Fried Mee    |       10
          5 | Buchanan  |   10248 | Mozzarella di Giovanni           |        5
          6 | Suyama    |   10249 | Tofu                             |        9
          6 | Suyama    |   10249 | Manjimup Dried Apples            |       40 ... 

Focus: practice (inner) joins across multiple tables
Four tables need to be joined: orders, employees, order_details and products. */

SELECT
  e.employeeid,
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
