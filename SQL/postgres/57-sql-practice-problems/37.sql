/* Orders - random assortment
- get a random set of 2% of all orders

Expected Result:
 orderid | customerid | employeeid | orderdate  | requireddate | shippeddate | shipvia | freight |              shipname              |                  shipaddress                   |    shipcity     |  shipregion   | shippostalcode | shipcountry 
---------+------------+------------+------------+--------------+-------------+---------+---------+------------------------------------+------------------------------------------------+-----------------+---------------+----------------+-------------
   10249 | TOMSP      |          6 | 1996-07-05 | 1996-08-16   | 1996-07-10  |       1 |   11.61 | Toms Spezialitäten                 | Luisenstr. 48                                  | Münster         |               | 44087          | Germany
   10250 | HANAR      |          4 | 1996-07-08 | 1996-08-05   | 1996-07-12  |       2 |   65.83 | Hanari Carnes                      | Rua do Paço, 67                                | Rio de Janeiro  | RJ            | 05454-876      | Brazil
   10252 | SUPRD      |          4 | 1996-07-09 | 1996-08-06   | 1996-07-11  |       2 |    51.3 | Suprêmes délices                   | Boulevard Tirou, 255                           | Charleroi       |               | B-6000         | Belgium
   10254 | CHOPS      |          5 | 1996-07-11 | 1996-08-08   | 1996-07-23  |       2 |   22.98 | Chop-suey Chinese                  | Hauptstr. 31                                   | Bern            |               | 3012           | Switzerland
   10256 | WELLI      |          3 | 1996-07-15 | 1996-08-12   | 1996-07-17  |       2 |   13.97 | Wellington Importadora             | Rua do Mercado, 12                             | Resende         | SP            | 08737-363      | Brazil ...
   
   Focus: BERNOULLI function
   https://dev.to/jidemobell/sampling-in-postgresql-with-bernoulli-function-3988
   */

SELECT * FROM orders TABLESAMPLE BERNOULLI (20);