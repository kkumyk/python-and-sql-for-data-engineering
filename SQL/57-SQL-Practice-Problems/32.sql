-- 31. High-value customers

-- find high-value customers with order value at least 999.99

-- PostgreSQL
select
    customers.customer_id,
    customers.customer_name,
    orders.order_id, sum(quantity * unit_price) as total_order_amount
from customers
    join orders
        on orders.customer_id = customers.customer_id
    join order_details
        on orders.order_id = order_details.order_id
where
    order_date >= '2053-02-23'
group by
    customers.customer_id, customers.customer_name, orders.order_id
having sum(quantity * unit_price) >= 999.99
order by total_order_amount desc;


--  customer_id |  customer_name   | order_id | total_order_amount 
-- -------------+------------------+----------+--------------------
--            1 | Drunken Botanist |        1 |         1998512.82
--            2 | Drunken Chemist  |        2 |          998990.01
--            3 | Sober Botanist   |        3 |             999.99



/*
Learnings:

Aggregate functions can only be used to filter in the Having clause, not the Where clause.

*/