-- 8. Orders shipping to France or Belgium

select OrderId, CustomerId, ShipCountry from Orders where ShipCountry = 'France' or 'Belgium'; -- MS SQL Server

select "OrderID", "CustomerID", "ShipCountry" from "Orders" where "ShipCountry" in ('France', 'Belgium'); -- PostgreSQL