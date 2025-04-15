# SQLZoo Tutorial

## [SELECT within SELECT](https://www.sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial): Using nested SELECT
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

select name
from world
where continent!='Europe' and gdp > (select gdp from world where continent='Europe')

```

```sql

/*
Which countries have a GDP greater than every country in Europe?
[Give the name only.] (Some countries may have NULL gdp values) 
*/

select name
from world
where gdp > (
    select
        max(gdp) from world where continent = 'Europe')

```


```sql

/*
Find the largest country (by area) in each continent, show the continent, the name and the area: The above example is known as a correlated or synchronized sub-query. 
*/

select continent, name, area from world x
where area >= all
    (select area from world y
        where y.continent=x.continent
    )
```

```sql

/*
List each continent and the country that comes first alphabetically within that continent using a correlated subquery
*/

select continent, name
from world x
where name = (
    select min(name)
    from world y
    where y.continent=x.continent
)
        
```


```sql

/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents.
Show name, continent and population. 
*/

with continent_select as (
    select continent
    from world
    group by continent
    having max(population) <= 25000000
)
select w.name, w.continent, w.population
from world w
join continent_select on w.continent=continent_select.continent
        
```









```sql

/*

*/


        
```