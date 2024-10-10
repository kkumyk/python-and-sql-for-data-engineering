/*
13. OrderDetails amount per line item

Return a new field - total_price - by multiplying two existing fields: unitprice * quantity

 orderid | productid | unitprice | quantity |    total_price     
---------+-----------+-----------+----------+--------------------
   10248 |        11 |        14 |       12 |                168
   10248 |        42 |       9.8 |       10 |  98.00000190734863
   10248 |        72 |      34.8 |        5 | 173.99999618530273
*/

select
    orderid,
    productid,
    unitprice,
    quantity,
    unitprice * quantity as total_price
from order_details
order by
    orderid,
    productid;



