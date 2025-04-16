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

Largest in each continent
Find the largest country (by area) in each continent, show the continent, the name and the area.

Correlated or Synchronized sub-query

A correlated subquery works like a nested loop: the subquery only has access to
rows related to a single record at a time in the outer query.
The technique relies on table aliases to identify two different uses of the same table,
one in the outer query and the other in the subquery.
One way to interpret the line in the WHERE clause that references the two table is “
… where the correlated values are the same”.

In the example provided, you would say “select the country details from world where the population
is greater than or equal to the population of all countries where the continent is the same”.

Find the largest country (by area) in each continent, show the continent,
the name and the area: The above example is known as a correlated or synchronized sub-query. 
*/

select continent, name, area from world x
where area >= all
    (select area from world y
        where y.continent=x.continent
    )


/*
Query that does not use a correlated sub-query and more cost-efficient in Snowflake.
Uses a single scan + aggregation (MAX with GROUP BY).
Very efficient in Snowflake, because:
    Grouping and aggregation are optimized.
    Subquery is independent, can run in parallel.

*/

select continent, name, area
from world
where (continent, area) in (
    select continent, max(area)
    from world
    group by continent
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

select x.continent, x.name
from world x
where name = (
    select min(name)
    from world
    where continent = x.continent
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
Some countries have populations more than three times that of all of their neighbours (in the same continent).
Give the countries and continents.

Give me the countries where there is no neighbor in the same continent
that has at least one-third of their population.
*/

select x.name, x.continent
from world x
where not exists (

    select y.name
    from world y
    where y.continent=x.continent
    and y.name!=x.name
    and x.population <= 3*y.population

)

```

## [Nested SELECT Quiz](https://www.sqlzoo.net/wiki/Nested_SELECT_Quiz)


```sql

/*
2. Select the code that shows the countries belonging to regions with all populations over 50000:
*/

select name, region, population
from bbc x
where 50000 < ALL (
  select population
  from bbc y
  where x.region = y.region AND y.population > 0
);

        
```















```sql

/*

*/




        
```





















```sql

/*

*/


        
```