/*
18. Products with associated supplier names

Products:
 productid |  productname  | supplierid | categoryid |   quantityperunit   | unitprice | unitsinstock | unitsonorder | reorderlevel | discontinued 
-----------+---------------+------------+------------+---------------------+-----------+--------------+--------------+--------------+--------------
         1 | Chai          |          8 |          1 | 10 boxes x 30 bags  |        18 |           39 |            0 |           10 |            1
         2 | Chang         |          1 |          1 | 24 - 12 oz bottles  |        19 |           17 |           40 |           25 |            1
         3 | Aniseed Syrup |          1 |          2 | 12 - 550 ml bottles |        10 |           13 |           70 |           25 |            0

Suppliers:
 supplierid |        companyname         |   contactname    |     contacttitle     |    address     |    city     | region | postalcode | country |     phone      |      fax       |  homepage   
------------+----------------------------+------------------+----------------------+----------------+-------------+--------+------------+---------+----------------+----------------+-------------
          1 | Exotic Liquids             | Charlotte Cooper | Purchasing Manager   | 49 Gilbert St. | London      |        | EC1 4SD    | UK      | (171) 555-2222 |                | 
          2 | New Orleans Cajun Delights | Shelley Burke    | Order Administrator  | P.O. Box 78934 | New Orleans | LA     | 70117      | USA     | (100) 555-4822 |                | #CAJUN.HTM#
          3 | Grandma Kelly's Homestead  | Regina Murphy    | Sales Representative | 707 Oxford Rd. | Ann Arbor   | MI     | 48104      | USA     | (313) 555-5735 | (313) 555-3349 | 

Expected Result:
 productid |           productname            |                supplier                
-----------+----------------------------------+----------------------------------------
         1 | Chai                             | Specialty Biscuits, Ltd.
         2 | Chang                            | Exotic Liquids
         3 | Aniseed Syrup                    | Exotic Liquids...
        54 | Tourtière                        | Ma Maison
        55 | Pâté chinois                     | Ma Maison
        56 | Gnocchi di nonna Alice           | Pasta Buttini s.r.l.
*/

select productid, productname, companyname as supplier
from products p
join supplies on p.supplierid = s.supplierid;

/*
Learnings:

Alias with AS keyword in Postgres and = in SQL Server
In SQL Server, you can use =, but in Postgres, this is written as CompanyName AS Supplier.
*/