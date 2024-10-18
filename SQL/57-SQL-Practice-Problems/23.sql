/* 023. Products that need reordering are where:
    - (unitsinstock + unitsonorder) <= reorderlevel

Products:
 productid |  productname  | supplierid | categoryid |   quantityperunit   | unitprice | unitsinstock | unitsonorder | reorderlevel | discontinued 
-----------+---------------+------------+------------+---------------------+-----------+--------------+--------------+--------------+--------------
         1 | Chai          |          8 |          1 | 10 boxes x 30 bags  |        18 |           39 |            0 |           10 |            1
         2 | Chang         |          1 |          1 | 24 - 12 oz bottles  |        19 |           17 |           40 |           25 |            1
         3 | Aniseed Syrup |          1 |          2 | 12 - 550 ml bottles |        10 |           13 |           70 |           25 |            0

Expected Results:
 productid |      productname      | unitsinstock | unitsonorder | reorderlevel | discontinued 
-----------+-----------------------+--------------+--------------+--------------+--------------
        30 | Nord-Ost Matjeshering |           10 |            0 |           15 |            0
        70 | Outback Lager         |           15 |           10 |           30 |            0      */

select productid, productname, unitsinstock, unitsonorder, reorderlevel, discontinued
from products
where (unitsinstock + unitsonorder) <= reorderlevel and discontinued = 0
order by productid;

-- Learnings: Discontinued = 0 | Discontinued = 'false'

















