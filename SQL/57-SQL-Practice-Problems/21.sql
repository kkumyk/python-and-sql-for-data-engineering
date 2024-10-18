/* 21. Total customers per country/city
- show the total number of customers per country and city
- hint: as you can have multiple fields in a select clause, you can also have multiple fields ina group by clause

Customers:
 customerid |            companyname             |  contactname   |     contacttitle     |            address            |    city     | region | postalcode | country |    phone     |     fax      
------------+------------------------------------+----------------+----------------------+-------------------------------+-------------+--------+------------+---------+--------------+--------------
 ALFKI      | Alfreds Futterkiste                | Maria Anders   | Sales Representative | Obere Str. 57                 | Berlin      |        | 12209      | Germany | 030-0074321  | 030-0076545
 ANATR      | Ana Trujillo Emparedados y helados | Ana Trujillo   | Owner                | Avda. de la Constitución 2222 | México D.F. |        | 05021      | Mexico  | (5) 555-4729 | (5) 555-3745
 ANTON      | Antonio Moreno Taquería            | Antonio Moreno | Owner                | Mataderos  2312               | México D.F. |        | 05023      | Mexico  | (5) 555-3932 | 

Expected Results:
   country   |      city       | totalcustomers 
-------------+-----------------+----------------
 UK          | London          |              6
 Mexico      | México D.F.     |              5
 Brazil      | Sao Paulo       |              4
 Brazil      | Rio de Janeiro  |              3 ...

 Task's Focus: group by  multiple fields
*/

select country, city, count(*) as TotalCustomers
from customers
group by country, city
order by count(*) DESC;

/*
Learnings:
Once you have a Group by clause in a SQL statement, every field that appears in the Select statement needs
to either appear in the Group by clause, or needs to have some kind of aggregate function applied to it.
*/