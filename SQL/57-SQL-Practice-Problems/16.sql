-- 16. Countries where there are customers 

select distinct country from customers;

select country from customers group by country;

/*
Learnings:
Although Group By and DISTINCT get to the same result, Group By is used more ofter as it can be combined with other functions such us Count and Sum.
*/