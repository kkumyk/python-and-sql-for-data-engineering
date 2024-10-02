-- 8. Orders shipping to France or Belgium

-- In operator is used to find orders shipped to defined countries 

select OrderId, CustomerId, ShipCountry from Orders where ShipCountry in ('France', 'Belgium');

--  orderid | customerid | shipcountry 
-- ---------+------------+-------------
--    10248 | VINET      | France
--    10251 | VICTE      | France
--    10265 | BLONP      | France
--    10274 | VINET      | France
--    10295 | VINET      | France
--    10297 | BLONP      | France
--    10302 | SUPRD      | Belgium
--    10311 | DUMON      | France
--    10331 | BONAP      | France
--    10334 | VICTE      | France
--    10340 | BONAP      | France
-- ... skipping some rows
--    10972 | LACOR      | France
--    10973 | LACOR      | France
--    10978 | MAISD      | Belgium
--    11004 | MAISD      | Belgium
--    11035 | SUPRD      | Belgium
--    11038 | SUPRD      | Belgium
--    11043 | SPECD      | France
--    11051 | LAMAI      | France
--    11076 | BONAP      | France