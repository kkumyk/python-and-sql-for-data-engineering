/* Orders with many line items:
- show the 10 orders that have most individual line items
- use order_details table:
    orderid | productid | unitprice | quantity | discount 
    ---------+-----------+-----------+----------+----------
    10248 |        11 |        14 |       12 |        0
    10248 |        42 |       9.8 |       10 |        0 ...
- order by total line items;

Expected Result:
    orderid | total_items 
    ---------+-------------
    11077 |          25
    10979 |           6
    10657 |           6
    10847 |           6
    10360 |           5
    10893 |           5
    10553 |           5
    10294 |           5
    10514 |           5
    11064 |           5
    (10 rows)          
    
    Focus: Limit returned results. */


select orderid, count(*) as total_items
from order_details
group by orderid
order by count(*) desc
limit 10;
