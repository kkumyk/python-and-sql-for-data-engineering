# SQLZoo Tutorial

## [SELECT within SELECT](https://www.sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial)

```sql
/*
List each country name where the population is larger than that of 'Russia'.

This select with select only works if we only use a single value whihin the internal select statement,
here - population. So, you cannot ask for population and area in the internal select statement.
You also cannot ask to check for more than one row with the WHERE using LIKE. Only a single row should be returned
from the subquery. Also, the query will return an error if there is an option that returns zero values.
Brackets are mandatory in this statement.
*/

select name from world
where population >
(select population from world
    where name = 'Russia')
```

```sql
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

select name
from world
where continent='Europe' and gdp/population > (
    select gdp/population
    from world
    where name='United Kingdom'
)
```

```sql
/*
List the name and continent of countries in the continents containing either Argentina or Australia.
Order by name of the country.
*/

select name, continent
from world
where continent in (
    select continent from world
    where name in ('Argentina', 'Australia')
)
```

```sql
-- Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

select name, population
from world
where
    population > (select population from world where name='United Kingdom') and
    population < (select population from world where name='Germany') 
```


```sql
/*
Percentages of Germany
Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
*/

select
    name,
    concat(
        round(population / (select population from world where name='Germany') * 100),
    '%' ) as percentage
from world
where continent='Europe'

```