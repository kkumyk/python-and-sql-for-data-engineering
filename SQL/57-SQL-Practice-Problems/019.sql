/*
19. Orders and the Shipper that was used

Orders:
 orderid | customerid | employeeid | orderdate  | requireddate | shippeddate | shipvia | freight |         shipname          |    shipaddress     |    shipcity    | shipregion | shippostalcode | shipcountry 
---------+------------+------------+------------+--------------+-------------+---------+---------+---------------------------+--------------------+----------------+------------+----------------+-------------
   10248 | VINET      |          5 | 1996-07-04 | 1996-08-01   | 1996-07-16  |       3 |   32.38 | Vins et alcools Chevalier | 59 rue de l'Abbaye | Reims          |            | 51100          | France
   10249 | TOMSP      |          6 | 1996-07-05 | 1996-08-16   | 1996-07-10  |       1 |   11.61 | Toms Spezialitäten        | Luisenstr. 48      | Münster        |            | 44087          | Germany
   10250 | HANAR      |          4 | 1996-07-08 | 1996-08-05   | 1996-07-12  |       2 |   65.83 | Hanari Carnes             | Rua do Paço, 67    | Rio de Janeiro | RJ         | 05454-876      | Brazil

Shippers:
 shipperid |   companyname    |     phone      
-----------+------------------+----------------
         1 | Speedy Express   | (503) 555-9831
         2 | United Package   | (503) 555-3199
         3 | Federal Shipping | (503) 555-9931

Expected Result:
 orderid | orderdate  |     shipper      
---------+------------+------------------
   10248 | 1996-07-04 | Federal Shipping
   10249 | 1996-07-05 | Speedy Express
   ...
   10268 | 1996-07-30 | Federal Shipping
   10269 | 1996-07-31 | Speedy Express
(22 rows)
*/

SELECT orderid, orderdate, companyname AS shipper
FROM orders o
JOIN shippers s ON s.ShipperID = o.shipvia
WHERE orderid < 10270
ORDER BY orderid;