# [SELECT Basics](https://sqlzoo.net/wiki/SELECT_basics)
(some of the) [tasks's source](https://sqlzoo.net/wiki/SELECT_from_Nobel_Tutorial)

## WHERE

```sql
/* Show the name and population in millions for the countries of the continent 'South America'.
Divide the population by 1000000 to get population in millions. */
select name, population/1000000, continent from world where continent="South America"

-- Show Nobel prizes for 1950
SELECT yr, subject, winner FROM nobel WHERE yr = 1950;


-- Show all details (yr, subject, winner) of the literature prize winners for 1980 to 1989 inclusive.
SELECT * FROM nobel WHERE subject = 'literature' AND yr BETWEEN 1980 AND 1989;
```

## IN Operator
Use IN to check if an item is in the list
```sql
-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark':
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway', 'Denmark');
```
## LIKE
LIKE determines whether a specific character string matches a patter: regex or wildcards
% - any string of zero or more characters

```sql
-- Select all countries and their populations starting with "Al":
SELECT name, population FROM world WHERE name LIKE "Al%";

-- Show the countries which have a name that includes the word 'United':
select name from world where name like "%United%";

-- Find all details of the prize won by PETER GRÜNBERG
SELECT * FROM nobel WHERE winner LIKE 'Peter Gr%nberg';

SELECT *
  FROM nobel 
  WHERE winner IN ('Peter Grünberg')
;

```
## Apostrophe Escaping

```sql
-- Find all details of the prize won by EUGENE O'NEILL
SELECT *
  FROM nobel 
  WHERE winner IN ('Eugene O''Neill');
```


## UNION
```sql
-- Show the year, subject, and name of physics winners for 1980 together with the chemistry winners for 1984.
SELECT yr, subject, winner
FROM nobel
WHERE yr=1980 AND subject = 'physics'
UNION
SELECT yr, subject, winner
FROM nobel
WHERE yr=1984 AND subject = 'chemistry'
ORDER by yr DESC;
```



## CASE WHEN
```sql
-- Show the 1984 winners & subject ordered by subject and winner name;
-- but list chemistry and physics last.

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY
CASE WHEN subject IN ('physics','chemistry') THEN 1 ELSE 0 END, subject, winner;

-- the query below is not a proper SQL syntax but does return the same result as the above query;
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('physics','chemistry'), subject, winner;
```