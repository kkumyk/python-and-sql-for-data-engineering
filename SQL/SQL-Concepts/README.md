# SQL Must Know Commands

SQL (Structured Query Language) is divided into different command categories:

- DQL (Data Query Language): Primarily used to query and retrieve data.

- DML (Data Manipulation Language): Used to manipulate data (insert, update, delete).

- DDL (Data Definition Language): Defines and manages database schema (create, alter, drop, truncate).

- DCL (Data Control Language): Manages permissions (grant, revoke).

- TCL (Transaction Control Language): Manages database transactions (commit, rollback).

<img src="https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/_doc/sql_commands.png" width="550" height="650"></img>

[Graph Source](https://www.linkedin.com/posts/nelsonamigoscode_systemdesign-coding-interviewtips-activity-7259196704107687937-xxW0/)




<!-- SQL Must Know JOINs:

https://www.linkedin.com/posts/nelsonamigoscode_systemdesign-coding-interviewtips-activity-7252293916429881344-Zhqy/ -->

 <!-- This is how SQL get Executed by DB engines

✅ Coding Order (How SQL Queries are Written)
1. SELECT: Specifies the columns or expressions to retrieve from the database.
2. FROM: Indicates the table(s) to query and the source of the data.
3. WHERE: Filters the rows based on specified conditions before any grouping or aggregation occurs.
4. GROUP BY: Aggregates rows that share the same values in specified columns into summary rows.
5. HAVING: Filters groups based on a condition, similar to `WHERE` but applied after grouping.
6. ORDER BY: Sorts the result set based on specified columns or expressions.
7. LIMIT: Restricts the number of rows returned by the query.

✅ Execution Order (How SQL Queries are Processed)
1. FROM: The query starts by gathering data from the source tables.
2. WHERE: Filters the rows from the `FROM` step based on given conditions.
3. GROUP BY: Organizes filtered rows into groups defined by specified columns.
4. HAVING: Applies conditions to these groups to filter out those that don’t meet the criteria.
5. SELECT: Selects the specific columns or expressions to include in the result set.
6. ORDER BY: Sorts the selected rows according to specified columns.
7. LIMIT: Limits the number of rows returned, based on a specified number.


I wonder what about the JOIN and SUBQUERIES? Could you explain the execution order of a query which includes JOIN and/or SUBQUERIES?

FROM subquery – If the subquery is in the FROM clause, it is evaluated first and the result is used as a virtual table.

WHERE subquery – If the subquery is in the WHERE clause, it is executed during the filtering process.

SELECT subquery – If the subquery is in the SELECT clause, it is evaluated when selecting the columns.

 if the query has JOINS, they are processed along with the FROM step. The database combines the tables based on the join conditions at this stage before moving to the next steps like filtering with WHERE  -->
