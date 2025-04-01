/* 25. Countries with the highest average freight charges overall

- return in desc order by avg freight

Orders:
 orderid | customerid | employeeid | orderdate  | requireddate | shippeddate | shipvia | freight |         shipname          |    shipaddress     |    shipcity    | shipregion | shippostalcode | shipcountry 
---------+------------+------------+------------+--------------+-------------+---------+---------+---------------------------+--------------------+----------------+------------+----------------+-------------
   10248 | VINET      |          5 | 1996-07-04 | 1996-08-01   | 1996-07-16  |       3 |   32.38 | Vins et alcools Chevalier | 59 rue de l'Abbaye | Reims          |            | 51100          | France
   10249 | TOMSP      |          6 | 1996-07-05 | 1996-08-16   | 1996-07-10  |       1 |   11.61 | Toms Spezialitäten        | Luisenstr. 48      | Münster        |            | 44087          | Germany
   10250 | HANAR      |          4 | 1996-07-08 | 1996-08-05   | 1996-07-12  |       2 |   65.83 | Hanari Carnes             | Rua do Paço, 67    | Rio de Janeiro | RJ         | 05454-876      | Brazil


Expected Result:
 shipcountry |   averagefright    
-------------+--------------------
 Austria     | 184.78750057220458
 Ireland     | 145.01262895684494
 USA         | 112.87942660355665
(3 rows)

Learnings:
Using Top is the easiest and most commonly used method of showing only a certain number of records. Another way is by using Offset.

Focus: LIMIT to top X results vs. OFFSET to show a certain number of records.
*/

SELECT ShipCountry, AVG(Freight) AS AverageFright
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFright DESC
LIMIT 3;

SELECT ShipCountry, AVG(Freight) AS AverageFright
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFright DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY;
