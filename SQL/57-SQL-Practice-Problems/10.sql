/* 10. Employees in order of age

Return first name, last name, title, birth date and order by birth date with the oldest coming up first.

Order By clause is used to sort the results. 
 firstname | lastname  |          title           | birthdate  
-----------+-----------+--------------------------+------------
 Margaret  | Peacock   | Sales Representative     | 1937-09-19
 Nancy     | Davolio   | Sales Representative     | 1948-12-08
 Andrew    | Fuller    | Vice President, Sales    | 1952-02-19
 Steven    | Buchanan  | Sales Manager            | 1955-03-04
 Laura     | Callahan  | Inside Sales Coordinator | 1958-01-09
 Robert    | King      | Sales Representative     | 1960-05-29
 Michael   | Suyama    | Sales Representative     | 1963-07-02
 Janet     | Leverling | Sales Representative     | 1963-08-30
 Anne      | Dodsworth | Sales Representative     | 1966-01-27
(9 rows) */

select
    firstname, lastname, title, birthdate
from
    employees
order by birthdate;