/* 22. Products that need reordering
- use unitsinstock <= reorderlevel
- sort by productid

Products:
 productid |  productname  | supplierid | categoryid |   quantityperunit   | unitprice | unitsinstock | unitsonorder | reorderlevel | discontinued 
-----------+---------------+------------+------------+---------------------+-----------+--------------+--------------+--------------+--------------
         1 | Chai          |          8 |          1 | 10 boxes x 30 bags  |        18 |           39 |            0 |           10 |            1
         2 | Chang         |          1 |          1 | 24 - 12 oz bottles  |        19 |           17 |           40 |           25 |            1
         3 | Aniseed Syrup |          1 |          2 | 12 - 550 ml bottles |        10 |           13 |           70 |           25 |            0

Expected Results:
 productid |        productname        | unitsinstock | reorderlevel 
-----------+---------------------------+--------------+--------------
         2 | Chang                     |           17 |           25
         3 | Aniseed Syrup             |           13 |           25
         5 | Chef Anton's Gumbo Mix    |            0 |            0
        11 | Queso Cabrales            |           22 |           30
        17 | Alice Mutton              |            0 |            0
        21 | Sir Rodney's Scones       |            3 |            5
        29 | Thüringer Rostbratwurst   |            0 |            0
        30 | Nord-Ost Matjeshering     |           10 |           15
        31 | Gorgonzola Telino         |            0 |           20

Task's Focus: filtering based on another filed instead of a specific value;
*/

select productid, productname, unitsinstock, reorderlevel
from products
where unitsinstock <= reorderlevel;

/*
Learnings: Instead of using a string or numeric value to filter, another field can be used. */
