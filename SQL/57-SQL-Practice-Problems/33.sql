/* 32. High-value customers -  total orders
- high-value customers are:
    - customers which have made orders totaling more than 999.99 in 2056

customers:
    customer_id |  customer_name   
    -------------+------------------
            1 | Drunken Botanist
            2 | Drunken Chemist
            3 | Sober Botanist
            4 | Sober Chemist

orders:
 order_id | order_date | customer_id 
----------+------------+-------------
        1 | 2055-12-31 |           1
        2 | 2053-02-23 |           2
        3 | 2055-10-11 |           3
        4 | 2053-02-22 |           4
        5 | 2056-10-11 |           1
        7 | 2056-05-12 |           2
        8 | 2056-05-12 |           3
       10 | 2056-10-11 |           1
       11 | 2056-02-22 |           2

order_details:
 order_id | product_id | unit_price | quantity 
----------+------------+------------+----------
        1 |          1 |    3000.77 |      666
        2 |          2 |     999.99 |      999
        3 |          2 |     999.99 |        1
        4 |          2 |     999.99 |        1
        5 |          2 |     999.99 |      144
        7 |          2 |     999.99 |      122
        8 |          2 |     999.99 |        1
       10 |          2 |     999.99 |       10
       11 |          2 |     999.99 |       11

*/

-- PostgreSQL

select
    customers.customer_id,
    customers.customer_name,
    sum(quantity * unit_price) as total_order_amount
from customers
    join orders
        on orders.customer_id = customers.customer_id
    join order_details
        on orders.order_id = order_details.order_id
where
    order_date >= '2056-01-01' and order_date < '2057-01-01'
group by
    customers.customer_id,
    customers.customer_name
having sum(quantity * unit_price) > 999.99
order by total_order_amount desc;


-- Query Result:
 customer_id |  customer_name   | total_order_amount 
-------------+------------------+--------------------
           1 | Drunken Botanist |          153998.46
           2 | Drunken Chemist  |          132998.67

/*
Learnings:

Having clause
    - aggregate functions can only be used in the Having clause, not in the Where clause;
    - the above is the case because the Where filters the records, and does not filter aggregations;
    - the Where keyword filters individual records;
    - Having filters aggregations;

*/