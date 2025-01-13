# 57 SQL Practice Problems | Topics Overview
1. [Simple SELECT statement](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/01-5.sql): return data from all columns from a table.
2. [SELECT specific columns](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/01-5.sql) from a table.
3. [SELECT specific columns WHERE](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/01-5.sql) title matches a condition.
4. Extend the above query with another [condition using AND](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/01-5.sql).
5. [SELECT and WHERE continued](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/01-5.sql).
6. [Ways to express "not"](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/06.sql) (<>, !=) in the SELECT and WHERE statement.
7. [Use of wildcards](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/07.sql) with the LIKE operator.
8. [Filtering with the IN](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/08.sql) operator.
9. [IN operator for filtering and grouping](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/09.sql).
10. [ORDER BY clause](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/10.sql) to sort the result.
11. [CAST function and data type conversion](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/1.sql).
12. Different [ways for manipulating strings](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/12.sql) in returned results: CONCAT, +, ||.
13. [Calculated fields and aliases](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/13.sql).
14. Aggregate functions: [COUNT()](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/14.sql).
15. Aggregate functions: [MIN(), AVG(), SUM()](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/15.sql).
16. Differences in using [GROUP BY and DISTINCT](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/16.sql) to get unique values.
17. [Order evaluation in query execution](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/17.sql) and its impact on usage of aliases.
18. [INNER JOIN](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/18.sql)
19. [INNER JOIN with WHERE](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/19.sql) condition.
20. [A parent-child relationship between two joined tables](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/20.sql): INNER JOIN, GROUP BY the data from the parent table and aggregate the data from the child table.
21. [GROUP BY multiple fields](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/21.sql).
22. [Filtering using another field](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/22.sql) instead of a specific value.
23. Ways to [define missing values for results filtering](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/23.sql).
24. Use of [CASE expression in the ORDER BY](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/24.sql) clause.
25. [LIMIT to top X results vs. OFFSET](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/25.sql) to show a certain number of records.
26. Use of built-in functions such as [EXTRACT and DATE_PART](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/26.sql).
27. Return records for a specific time period using the [BETWEEN operator](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/27.sql).
28. [Dynamic date range with INTERVAL data type](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/28.sql) using subquery in WHERE clause.
29. [Multiple INNER JOINs](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/29.sql).
30. [LEFT JOIN with IS NULL](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/30.sql) to return non-existing values.
31. [Filtering with the LEFT JOIN](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/30.sql) instead of the WHERE clause.
32. [Aggregate functions in the HAVING clause](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/32.sql).
33. [Aggregate functions in the HAVING clause continued](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/33.sql).
34. [Calculated fields](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/34.sql): when to use aliases and when to reference the actual calculations.
35. [DATE_TRUNC and INTERVAL functions](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/35.sql) to get a specific day.
36. [LIMIT returned results](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/36.sql).
37. [BERNOULLI function](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/37.sql) to perform random sampling on a table.
38. The difference between [filtering with WHERE (pre-aggregation) vs HAVING (post-aggregation)](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/38.sql).
39. [CTE and Subquery](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/39.sql) to get accidental entries.
40. [Use a derived table instead of a CTE and a subquery](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/40.sql) to get accidental entries.
41. [Filtering by table fields](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/41.sql).
42. [GROUP BY multiple fields, ORDER BY a calculated field](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/42.sql).
43. Referencing [multiple CTEs in one query](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/43.sql).
44. Previous solution extended with the [use of INNER and LEFT joins](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/44.sql).
45. [Multiple CTEs in combination with COALESCE, INNER and LEFT joins](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/45.sql).
46. Previous solution extended with [percentage calculation](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/46.sql).
47. Fix decimal: [formatting returned percentage result](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/47.sql).
48. [Multiple grouping with CASE statement](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/48.sql).
49. [Fix NULL values](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/49.sql) in the previous solution.
50. Extend the previous solution by [calculating percentages for each group](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/50.sql).
51. [Multiple grouping with defined boundaries](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/51.sql) instead of hard-coded values.
52. [Simple UNION statement to remove duplicate results](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/52.sql).
53. Handling duplicate entries: [DISTINCT vs GROUP BY](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/53.sql).
54. [Handling missing values in grouped results with COALESCE](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/54.sql).
55. [Window / Rank functions for rank assignment](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/55.sql) based on multiple conditions.
56. [SELF-JOIN for data comparison](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/56.sql) within the same dataset.
57. [LEAD window function in a CTE](https://github.com/kkumyk/python-and-sql-for-data-engineering/blob/main/SQL/57-SQL-Practice-Problems/57.sql).

<hr>

# Postgres Database Setup on Ubuntu 

1. Verify Postgres is installed
    ```bash
    psql --version
    ```
2. Start the PostgreSQL Service.

    PostgreSQL operates as a database server (a background process that manages posgres dbs and allows applications to connect to them). Without starting this service you won't be able to interact with the db.
    ```bash
    sudo systemctl start postgresql
    ```
3. Switch to the PostgreSQL's sdefault user <i>postgres</i> and access the PostgreSQl interactive terminal:
    ```bash
    sudo -i -u postgres
    psql
    ```
4. Create a new database.
    ```bash
    CREATE DATABASE sqlproblems;
    ```
5. Create a new user , grant access to the database and exit. (OPTIONAL)
    ```bash
    CREATE USER sqllearner WITH PASSWORD 'password';
    GRANT ALL PRIVILEGES ON DATABASE sqlproblems TO sqllearner;
    \q
    ```
6. Access the database
    ```bash
    psql -U postgres -d sqlproblems;
    ```
7. Populate database with the [data from the northwind.sql](https://github.com/rgerhardt/57-sql-problems/blob/master/northwind.sql).