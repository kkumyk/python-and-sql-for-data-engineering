/* 30. Customers with no orders

Expected Result:
 customers_customerid | orders_customerid 
----------------------+-------------------
 FISSA                | 
 PARIS                | 

Learnings:

The main options of LEFT OUTER are: IS NULL, NOT IN, NOT EXISTS

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

Focus: LEFT JOIN with IS NULL to return non-existing values
*/

SELECT
  c.customerid as customers_customerID,
  o.customerid as orders_customerID
FROM
  customers c
LEFT JOIN
  orders o on c.customerid = o.customerid
WHERE
  o.customerid is null;
