
-- 1. Which shippers do we have?

select * from shippers; -- MS SQL Server
select * from "shippers"; -- PostgreSQL

-- 2. Get certain fields from categories

select CategoryName, Description from Categories; -- MS SQL Server
select "CategotyName", "Description" from "Categories"; -- PostgreSQL

-- 3. Sales reps

select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative'; -- MS SQL Server
select "FirstName", "LastName", "HireDate" from "Employees" where "Title" is 'Sales Representative' -- PostgreSQL

-- 4. Sales reps in US

select FirstName, LastName, HireDate from Employees where Title = 'Sales Representative' and Country = 'USA'; -- MS SQL Server
select "FirstName", "LastName", "HireDate" from "Employees" where "Title" is 'Sales Representative' and "Country" = 'USA' -- PostgreSQL

-- 5. Orders placed by specific EmployeeID

select OrderID, OrderDate from Orders where EmployeeID = 5; -- MS SQL Server
select "OrderID", "OrderDate" from "Orders" where "EmployeeId" = 5 -- PostgreSQL

/*
Learnings:
- Postgres is case-sensitives for identifiers - table and column names.
- Double quotes are used for identifiers to preserve case sensitivity and special characters.
- If tables and columns are in lowercase in db schema, the double quotes in the queries can be omitted.
- Single quotes are used for string literals (specific values in queries) to define text data that is not a database identifier.
*/