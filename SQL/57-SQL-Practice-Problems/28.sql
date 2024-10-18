/* 28. High Freight Charges - last year

Expected Result:
 shipcountry |    avg_freight    
-------------+--------------------
 Ireland     |  200.2099952697754
 Austria     | 186.45960102081298
 USA         | 117.97046036692872

Focus: generating a dynamic date range with INTERVAL data type using sub-query in where clause
*/

select shipcountry, avg(freight) as avg_freight
from orders
where orderdate >= (select max(orderdate) - interval '12 months' from orders)
group by shipcountry
order by avg_freight desc
limit 3;