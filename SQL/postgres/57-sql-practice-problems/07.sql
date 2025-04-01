-- 7. Products with "auc" in ProductName

/*
Task:
Return the ProductID and ProductName for those products where the ProductName includes the string "au"

Learnings:
The LIKE operator is always used with wildcards, such as % , which substitutes for any number of characters.
*/

select
    productid, productname
from products
where
    productname like '%au%';


--  productid |           productname            
-- -----------+----------------------------------
--          8 | Northwoods Cranberry Sauce
--         28 | Rössle Sauerkraut
--         59 | Raclette Courdavault
--         62 | Tarte au sucre
--         65 | Louisiana Fiery Hot Pepper Sauce
--         67 | Laughing Lumberjack Lager
-- (6 rows)
