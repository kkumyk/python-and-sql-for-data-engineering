-- 6. Suppliers and ContactTitles
/*

Task: 
In the Suppliers table, show the SupplierID,
ContactName, and ContactTitle for those Suppliers
whose ContactTitle is not Marketing Manager.

Learnings:
Two ways to express "not": <>, !=
*/

select
    SupplierID,
    ContactName,
    ContactTitle
from
    Suppliers
where ContactTitle != 'Marketing Manager';


--  supplierid |        contactname         |         contacttitle         
-- ------------+----------------------------+------------------------------
--           1 | Charlotte Cooper           | Purchasing Manager
--           2 | Shelley Burke              | Order Administrator
--           3 | Regina Murphy              | Sales Representative
--           5 | Antonio del Valle Saavedra | Export Administrator
--           6 | Mayumi Ohno                | Marketing Representative
--           8 | Peter Wilson               | Sales Representative
--           9 | Lars Peterson              | Sales Agent
--          11 | Petra Winkler              | Sales Manager
--          12 | Martin Bein                | International Marketing Mgr.
--          13 | Sven Petersen              | Coordinator Foreign Markets
--          14 | Elio Rossi                 | Sales Representative
--          16 | Cheryl Saylor              | Regional Account Rep.
--          17 | Michael Björn              | Sales Representative
--          18 | Guylène Nodier             | Sales Manager
--          19 | Robb Merchant              | Wholesale Account Agent
--          20 | Chandra Leka               | Owner
--          21 | Niels Petersen             | Sales Manager
--          22 | Dirk Luchte                | Accounting Manager
--          23 | Anne Heikkonen             | Product Manager
--          24 | Wendy Mackenzie            | Sales Representative
--          26 | Giovanni Giudici           | Order Administrator
--          27 | Marie Delamare             | Sales Manager
--          28 | Eliane Noz                 | Sales Representative
--          29 | Chantal Goulet             | Accounting Manager
