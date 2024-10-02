/* 010. Employees, in order of age

For all employees return first name, last name, title, birth date and order by birth date so that the oldest will come up first.

Order By clause is used to sort the results. 

 firstname | lastname  |          title           | birthdate  
-----------+-----------+--------------------------+------------
 Margaret  | Peacock   | Sales Representative     | 1937-09-19
 Nancy     | Davolio   | Sales Representative     | 1948-12-08
 Andrew    | Fuller    | Vice President, Sales    | 1952-02-19

*/

select FirstName, LastName, Title, BirthDate from Employees order by BirthDate;