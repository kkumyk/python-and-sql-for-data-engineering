
/*
Learnings:
- Postgres is case-sensitives for identifiers - table and column names.
- If tables and columns are in lowercase in db schema, the double quotes in the queries can be omitted.
- Single quotes are used for string literals (specific values in queries) to define text data that is not a database identifier.
*/

-- 1. Which shippers do we have?

select * from shippers;

--  shipperid |    companyname    |     phone      
-- -----------+-------------------+----------------
--          1 | Speedy Express    | (503) 555-9831
--          2 | United Package    | (503) 555-3199
--          3 | Federal Shipping  | (503) 555-9931
--          4 | Alliance Shippers | 1-800-222-0451
--          5 | UPS               | 1-800-782-7892
--          6 | DHL               | 1-800-225-5345


-- 2. Get certain fields from categories

select CategoryName, Description from Categories;

--   categoryname  |                        description                         
-- ----------------+------------------------------------------------------------
--  Beverages      | Soft drinks, coffees, teas, beers, and ales
--  Condiments     | Sweet and savory sauces, relishes, spreads, and seasonings
--  Confections    | Desserts, candies, and sweet breads
--  Dairy Products | Cheeses
--  Grains/Cereals | Breads, crackers, pasta, and cereal
--  Meat/Poultry   | Prepared meats
--  Produce        | Dried fruit and bean curd
--  Seafood        | Seaweed and fish


-- 3. Sales reps

-- Return FirstName, LastName, and HireDate of all the employees with the Title of Sales Representative.

select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative';

--  firstname | lastname  |  hiredate  
-- -----------+-----------+------------
--  Nancy     | Davolio   | 1992-05-01
--  Janet     | Leverling | 1992-04-01
--  Margaret  | Peacock   | 1993-05-03
--  Michael   | Suyama    | 1993-10-17
--  Robert    | King      | 1994-01-02
--  Anne      | Dodsworth | 1994-11-15


-- 4. Sales reps in US

select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative' and Country = 'USA';

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
--    10269 | 1996-07-31
--    10297 | 1996-09-04
--    10320 | 1996-10-03
--    10333 | 1996-10-18
--    10358 | 1996-11-20
--    10359 | 1996-11-21
--    10372 | 1996-12-04
--    10378 | 1996-12-10
--    10397 | 1996-12-27
--    10463 | 1997-03-04
--    10474 | 1997-03-13
--    10477 | 1997-03-17
--    10529 | 1997-05-07
--    10549 | 1997-05-27
--    10569 | 1997-06-16
--    10575 | 1997-06-20
--    10607 | 1997-07-22
--    10648 | 1997-08-28
--    10649 | 1997-08-28
--    10650 | 1997-08-29
--    10654 | 1997-09-02
--    10675 | 1997-09-19
--    10711 | 1997-10-21
--    10714 | 1997-10-22
--    10721 | 1997-10-29
--    10730 | 1997-11-05
--    10761 | 1997-12-02
--    10812 | 1998-01-02
--    10823 | 1998-01-09
--    10841 | 1998-01-20
--    10851 | 1998-01-26
--    10866 | 1998-02-03
--    10869 | 1998-02-04
--    10870 | 1998-02-04
--    10872 | 1998-02-05
