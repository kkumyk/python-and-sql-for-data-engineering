/*
17. Contact titles for customers:
 customerid |            companyname             |  contactname   |     contacttitle     |            address            |    city     | region | postalcode | country |    phone     |     fax      
------------+------------------------------------+----------------+----------------------+-------------------------------+-------------+--------+------------+---------+--------------+--------------
 ALFKI      | Alfreds Futterkiste                | Maria Anders   | Sales Representative | Obere Str. 57                 | Berlin      |        | 12209      | Germany | 030-0074321  | 030-0076545
 ANATR      | Ana Trujillo Emparedados y helados | Ana Trujillo   | Owner                | Avda. de la Constitución 2222 | México D.F. |        | 05021      | Mexico  | (5) 555-4729 | (5) 555-3745
 ANTON      | Antonio Moreno Taquería            | Antonio Moreno | Owner                | Mataderos  2312               | México D.F. |        | 05023      | Mexico  | (5) 555-3932 | 

Expected Results:
          contacttitle          | total_titles 
--------------------------------+--------------
 Owner                          |           17
 Sales Representative           |           17
 Marketing Manager              |           12
 Sales Manager                  |           11
 Accounting Manager             |           10
 Sales Associate                |            7
 Marketing Assistant            |            6
 Sales Agent                    |            5
 Order Administrator            |            2
 Assistant Sales Agent          |            2
 Assistant Sales Representative |            1
 Owner/Marketing Assistant      |            1
*/

select contacttitle, count(*) as total_titles from customers group by contacttitle order by count(*) desc;

/*Learnings:

In Postgres alias cannot be used in ORDER BY because of the way Postgres processes queries:
it evaluates the SELECT and ORDER BY clauses at different stages - ORDER BY is processed before SELECT,
and therefore Postgres does not see the alias defined in the SELECT statement.
Therefore ORDER BY needs to be applied to the actual expression, here it is count(*).
*/