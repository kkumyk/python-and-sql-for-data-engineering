
-- 1. Which shippers do we have?

select * from shippers;

/*
 shipperid |    companyname    |     phone      
-----------+-------------------+----------------
         1 | Speedy Express    | (503) 555-9831
         2 | United Package    | (503) 555-3199
         3 | Federal Shipping  | (503) 555-9931
         4 | Alliance Shippers | 1-800-222-0451
         5 | UPS               | 1-800-782-7892
         6 | DHL               | 1-800-225-5345

Learnings:
- Postgres is case-sensitives for identifiers - table and column names.
- If tables and columns are in lowercase in db schema, the double quotes in the queries can be omitted.
- Single quotes are used for string literals (specific values in queries) to define text data that is not a database identifier.
*/

-- 2. Get certain fields from categories

select categoryname, description from categories;

/*
 categoryname  |                        description                         
----------------+------------------------------------------------------------
 Beverages      | Soft drinks, coffees, teas, beers, and ales
 Condiments     | Sweet and savory sauces, relishes, spreads, and seasonings
 Confections    | Desserts, candies, and sweet breads
 Dairy Products | Cheeses
 Grains/Cereals | Breads, crackers, pasta, and cereal
 Meat/Poultry   | Prepared meats
 Produce        | Dried fruit and bean curd
 Seafood        | Seaweed and fish
*/


-- 3. Sales reps

-- Return FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative.

select firstname, lastname, hiredate from employees where title = 'Sales Representative';

--  firstname | lastname  |  hiredate  
-- -----------+-----------+------------
--  Nancy     | Davolio   | 1992-05-01
--  Janet     | Leverling | 1992-04-01
--  Margaret  | Peacock   | 1993-05-03
--  Michael   | Suyama    | 1993-10-17
--  Robert    | King      | 1994-01-02
--  Anne      | Dodsworth | 1994-11-15


-- 4. Sales reps in US

select firstname, lastname, hiredate from employees where title = 'Sales Representative' and country = 'USA';

--  firstname | lastname  |  hiredate  
-- -----------+-----------+------------
--  Nancy     | Davolio   | 1992-05-01
--  Janet     | Leverling | 1992-04-01
--  Margaret  | Peacock   | 1993-05-03


-- 5. Orders placed by specific EmployeeID
-- Show all the orders placed by a specific employee. The EmployeeID for this Employee (Steven Buchanan) is 5.

select OrderID, OrderDate from Orders where EmployeeID = 5;

-- orderid | orderdate  
-- ---------+------------
--    10248 | 1996-07-04
--    10254 | 1996-07-11
-- ...
--    10954 | 1998-03-17
--    11043 | 1998-04-22
-- (42 rows)
