/* 32. High-value customers

- find high-value customers with order value at least 999.99
- high-value customers are:
    - made at least 1 order equal over 999.99
    - for orders made only in 2056

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

*/

-- PostgreSQL

select
    customers.customer_id,
    customers.customer_name,
    orders.order_id,
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
    customers.customer_name,
    orders.order_id
having sum(quantity * unit_price) > 999.99
order by total_order_amount desc;

-- Query Result:

--  customer_id |  customer_name   | order_id | total_order_amount 
-- -------------+------------------+----------+--------------------
--            1 | Drunken Botanist |        5 |          143998.56
--            2 | Drunken Chemist  |        7 |          121998.78


/*
Learnings:

Aggregate functions can only be used to filter in the Having clause, not the Where clause.

*/