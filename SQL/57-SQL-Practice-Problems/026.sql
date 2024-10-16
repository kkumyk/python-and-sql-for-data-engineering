/* 026. High freight charges in 2015
- what are the high freight charges for orders in 2015
 orderid | customerid | employeeid | orderdate  | requireddate | shippeddate | shipvia | freight |         shipname          |    shipaddress     |    shipcity    | shipregion | shippostalcode | shipcountry 
---------+------------+------------+------------+--------------+-------------+---------+---------+---------------------------+--------------------+----------------+------------+----------------+-------------
   10248 | VINET      |          5 | 1996-07-04 | 1996-08-01   | 1996-07-16  |       3 |   32.38 | Vins et alcools Chevalier | 59 rue de l'Abbaye | Reims          |            | 51100          | France
   10249 | TOMSP      |          6 | 1996-07-05 | 1996-08-16   | 1996-07-10  |       1 |   11.61 | Toms Spezialitäten        | Luisenstr. 48      | Münster        |            | 44087          | Germany
   10250 | HANAR      |          4 | 1996-07-08 | 1996-08-05   | 1996-07-12  |       2 |   65.83 | Hanari Carnes             | Rua do Paço, 67    | Rio de Janeiro | RJ         | 05454-876      | Brazil

Expected Result:
 shipcountry |    avg_freight     
-------------+--------------------
 Austria     | 178.36428569612048
 Switzerland | 117.17749977111816
 Sweden      |  105.1599993986242
(3 rows)

Focus: Use of built-in functions such as EXTRACT and DATE_PART */

SELECT
    shipcountry,
    AVG(freight) AS avg_freight
FROM orders
WHERE EXTRACT(YEAR FROM orderdate) = 1997
GROUP BY shipcountry
ORDER BY avg_freight DESC
LIMIT 3;

SELECT
  shipcountry,
  avg(freight) as avg_freight
FROM orders
WHERE date_part('year', orderdate) = 1997
GROUP BY shipcountry
ORDER BY avg_freight DESC
LIMIT 3;
  
/*
Learnings:
The date format in PostgreSQL is YYYY-MM-DD.
The EXTRACT(YEAR FROM OrderDate) function extracts the year from the OrderDate field.
*/