/* 42. Late orders - which employees?
- which salespeople have the most orders arriving late?
Hint:
- join the employee table to get the last name
- add count to show the total late orders       

Expected Result:
 employeeid | lastname  | total_late_orders 
------------+-----------+-------------------
          4 | Peacock   |                10
          3 | Leverling |                 5
          8 | Callahan  |                 5
          9 | Dodsworth |                 5
          2 | Fuller    |                 4
          7 | King      |                 4
          1 | Davolio   |                 3
          6 | Suyama    |                 3
          5 | Buchanan  |                 1
(9 rows) */

SELECT
  o.employeeid, e.lastname, count(o.orderid) as total_late_orders 
FROM
  orders o
JOIN
  employees e ON o.employeeid=e.employeeid
WHERE
  requireddate <= shippeddate
GROUP BY
  o.employeeid, e.lastname
ORDER BY
  count(o.orderid) DESC;