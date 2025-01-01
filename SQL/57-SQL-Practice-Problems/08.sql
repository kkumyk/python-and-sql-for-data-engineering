-- 8. Orders shipping to France or Belgium

-- In operator is used to find orders shipped to defined countries 

select
    orderid, customerid, shipcountry
from
    orders
where
    shipcountry in ('France','Belgium');


--  orderid | customerid | shipcountry 
-- ---------+------------+-------------
--    10248 | VINET      | France
--    10251 | VICTE      | France
--    10252 | SUPRD      | Belgium
-- ...
--    11051 | LAMAI      | France
--    11076 | BONAP      | France
-- (96 rows)
