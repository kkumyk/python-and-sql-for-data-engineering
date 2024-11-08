# [SELECT within SELECT](https://sqlzoo.net/wiki/SELECT_.._SELECT) | [Tutorial](https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial)

You can use the results from one query in another query.

## Subquery with FROM

```sql
-- Use the calculated values in the inner SELECT in the outer SELECT:

SELECT name, gdp_per_capita
FROM
    (SELECT name, gdp/population AS gdp_per_capita
     FROM world)
WHERE gdp_per_capita > 200000
```
## Subquery with IN - Derived Tables

```sql
-- Find the countries in the same continent as Bhutan:


```

## Nested Queries
```sql
```
