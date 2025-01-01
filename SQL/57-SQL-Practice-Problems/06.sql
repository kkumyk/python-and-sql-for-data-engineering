-- 6. Suppliers and ContactTitles
/*

Task: 
In the Suppliers table, show the supplier's id,
contact name, and contact title for those Suppliers
whose ContactTitle is not Marketing Manager.

Learnings:
Two ways to express "not": <>, !=
*/

select
    supplierid,
    contactname,
    contacttitle
from
    suppliers
where contacttitle != 'Marketing Manager';

--  supplierid |        contactname         |         contacttitle         
-- ------------+----------------------------+------------------------------
--           1 | Charlotte Cooper           | Purchasing Manager
--           2 | Shelley Burke              | Order Administrator
-- ...
--          28 | Eliane Noz                 | Sales Representative
--          29 | Chantal Goulet             | Accounting Manager
-- (24 rows)
