-- 9. Orders shipping to any country in Latin America

select OrderID, CustomerID, ShipCountry from Orders where ShipCountry in ('Brazil', 'Argentina', 'Venezuela');

/*

Using In operator to find orders from Latin America.  

Output Result:

 orderid | customerid | shipcountry 
---------+------------+-------------
   10250 | HANAR      | Brazil
   10253 | HANAR      | Brazil
   10256 | WELLI      | Brazil
   10257 | HILAA      | Venezuela
   10261 | QUEDE      | Brazil
   10268 | GROSR      | Venezuela
   10283 | LILAS      | Venezuela
   10287 | RICAR      | Brazil ...
*/