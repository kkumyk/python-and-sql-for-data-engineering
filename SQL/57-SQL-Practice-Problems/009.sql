-- 9. Orders shipping to any country in Latin America

select OrderID, CustomerID, ShipCountry from Orders where ShipCountry in ('Brazil', 'Argentina', 'Venezuela') -- MS SQL Server

select "OrderID", "CustomerID", "ShipCountry" from "Orders" where "ShipCountry" in ('Brazil', 'Argentina', 'Venezuela')  -- PostgreSQL