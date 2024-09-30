/*SELECT basics exercises from https://sqlzoo.net/wiki/SQL_Tutorial */

/* Use IN to check if an item is in the list*/
SELECT name, population FROM world WHERE name IN ('Sweden', 'Norway')

/*
LIKE determines whether a specific character string matches a patter: regex or wildcards
% - any string of zero or more characters
Select all countries and their populations starting with "Al":
*/
SELECT name, population FROM world WHERE name LIKE "Al%"

/*Show the countries which have a name that includes the word 'United': */
select name from world where name like "%United%"

/*
Show the name and population in millions for the countries of the continent 'South America'.
Divide the population by 1000000 to get population in millions.
*/
select name, population/1000000, continent from world where continent="South America"





