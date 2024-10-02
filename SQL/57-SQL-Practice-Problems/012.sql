/* 12. Employees full name

There are benefits of using CONCAT over + or || especially when dealing with NULL values in data:

    - when you use || and one of the values is NULL, the result will be NULL:
      SELECT 'Hello' || NULL || 'World';  # NULL

    - CONCAT treats NULL values as empty string and only non-null values will be concatenated:
      SELECT CONCAT('Hello', NULL, 'World'); # HelloWorld 


 firstname | lastname  |     fullname     
-----------+-----------+------------------
 Nancy     | Davolio   | Nancy Davolio
 Andrew    | Fuller    | Andrew Fuller
 Janet     | Leverling | Janet Leverling
 Margaret  | Peacock   | Margaret Peacock
 Steven    | Buchanan  | Steven Buchanan
 Michael   | Suyama    | Michael Suyama
 Robert    | King      | Robert King
 Laura     | Callahan  | Laura Callahan
 Anne      | Dodsworth | Anne Dodsworth
*/

select FirstName, LastName, concat(FirstName, ' ', LastName) as FullName from Employees;