/*
15. When was the first order?

Show the date of the first order ever made in the orders table:
 orderid | customerid | employeeid | orderdate  | requireddate | shippeddate | shipvia | freight |         shipname          |    shipaddress     |    shipcity    | shipregion | shippostalcode | shipcountry 
---------+------------+------------+------------+--------------+-------------+---------+---------+---------------------------+--------------------+----------------+------------+----------------+-------------
   10248 | VINET      |          5 | 1996-07-04 | 1996-08-01   | 1996-07-16  |       3 |   32.38 | Vins et alcools Chevalier | 59 rue de l'Abbaye | Reims          |            | 51100          | France
   10249 | TOMSP      |          6 | 1996-07-05 | 1996-08-16   | 1996-07-10  |       1 |   11.61 | Toms Spezialitäten        | Luisenstr. 48      | Münster        |            | 44087          | Germany
   10250 | HANAR      |          4 | 1996-07-08 | 1996-08-05   | 1996-07-12  |       2 |   65.83 | Hanari Carnes             | Rua do Paço, 67    | Rio de Janeiro | RJ         | 05454-876      | Brazil

Expected results:
 First Order 
-------------
 1996-07-04
*/

select min(orderdate) as "First Order" from orders;

/*
Learnings:

For the aggregate function Count, you don't need to specify a column name - just count(*) will work.
For other aggregate functions such as Min, Avg, Sum etc., you will need to specify a column name since you are not just counting all rows.
*/