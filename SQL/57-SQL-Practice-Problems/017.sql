-- 17. Contact titles for customers

SELECT ContactTitle, TotalContactTitle = count(*)
FROM Customers
GROUP BY ContactTitle
ORDER BY count(*) desc -- MS SQL Server


SELECT "ContactTitle", COUNT(*) AS "TotalContactTitle"
FROM "Customers"
GROUP BY "ContactTitle"
ORDER BY COUNT(*) DESC; -- PostgreSQL

/*Learnings:

- in Postgres alias cannot be used in ORDER BY because of the way Postgres processes queries:
it evaluates the SELECT and ORDER BY clauses at different stages - ORDER BY is processed before SELECT,
and therefore Postgres does not see the alias defined in the SELECT statement;

- therefore ORDER BY needs to be applied to the actual expression, here it is count(*);
*/