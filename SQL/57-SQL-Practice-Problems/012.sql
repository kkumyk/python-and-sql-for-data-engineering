-- 12. Employees full name

select FirstName, LastName, FullName = FirstName + ' ' LastName from Employees; -- MS SQL Server

select "FirstName", "LastName", concat("FirstName", ' ', "LastName") as "FullName" from "Employees";  -- PostgreSQL