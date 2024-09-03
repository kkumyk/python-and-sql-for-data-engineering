-- 7. Products with "queso" in ProductName

select
    ProductID, ProductName
from
    Products
where 
    ProductName LIKE '%queso%'; -- MS SQL Server

/*Learnings:

The LIKE operator is always used with wildcards, such as % , which substitutes for any number of characters.

Note that even though the search string used a lowercase "q" with the LIKE clause,
the resulting rows will have an uppercase Q.
*/

select "ProductID", "ProductName"
from "Products"
where "ProductName" like '%queso%'; -- PostgreSQL
