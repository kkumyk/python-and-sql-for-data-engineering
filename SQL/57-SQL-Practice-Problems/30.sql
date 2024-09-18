-- 30. Customers with no orders

-- MS SQL Server
Select
    Customers_CustomerID = Customers.CustomerID,
    Orders_CustomerID = Orders.CustomerID
From Customers
    left join Orders
        on Orders.CustomerID = Customers.CustomerID
Where
    Orders.CustomerID is null


/*Learnings:

This query is called a LEFT OUTER JOIN because the table mentioned on the left of the join operator will have each of its rows in the output at least once,
whereas the table on the right will only have those rows output that match some row of the left table.
When outputting a left-table row for which there is no right-table match, empty (null) values are substituted for the right-table columns.

INNER JOIN:
    - the resulting table only contains data that belongs in both of the tables.

OUTER JOINs:

If asymmetric data
    - use a LEFT JOIN, RIGHT JOIN or FULL JOIN to ensure that the data is not left out of the results.

LEFT (OUTER) JOIN
    - includes rows from A regardless of whether a matching row is found in B

RIGHT (OUTER) JOIN
    - keeping rows in B regardless of whether a match is found in A

FULL (OUTER) JOIN
     - rows from both tables are kept, regardless of whether a matching row exists in the other table

around_the_world_in_eighty_bottles=> select * from uk_white_grape_varieties;
 id | grape_variety_name 
----+--------------------
  1 | Chardonnay
  2 | Gewürztraminer
  3 | Seyval Blanc
  4 | Pinot Gris/Grigio
  5 | Müller-Thurgau
  6 | Madeleine Angevine
  7 | Reichensteiner
  8 | Schönburger
  9 | Ortega
(9 rows)

around_the_world_in_eighty_bottles=> select * from china_white_grape_varieties;
 id | grape_variety_name 
----+--------------------
  1 | Chardonnay
  2 | Italian Riesling
  3 | Longyan
  4 | Vidal Blanc

*/

--- INNER JOIN: find the white wine varieties that UK and China have in common

SELECT china_white_grape_varieties.grape_variety_name as china_and_uk_common_white_grapes
FROM china_white_grape_varieties
INNER JOIN uk_white_grape_varieties
    ON uk_white_grape_varieties.grape_variety_name = china_white_grape_varieties.grape_variety_name;

--  china_and_uk_common_white_grapes 
-- ----------------------------------
--  Chardonnay
