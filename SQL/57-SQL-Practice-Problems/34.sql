/* 32. High-value customers - with discount

- now high-value customers are:
    - customers which have made orders totaling more than 112000 in 2056 taking into consideration the discount
    - the discount is applied as a percentage
    - use parenthesis around (1 - Discount) to make sure that calculation is done first

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
 order_id | product_id | unit_price | quantity | discount 
----------+------------+------------+----------+----------
        4 |          2 |     999.99 |        1 |         
        8 |          2 |     999.99 |        1 |         
       10 |          2 |     999.99 |       10 |         
       11 |          2 |     999.99 |       11 |         
        1 |          1 |    3000.77 |      666 |     0.15
        2 |          2 |     999.99 |      999 |     0.15
        3 |          2 |     999.99 |        1 |     0.05
        5 |          2 |     999.99 |      144 |     0.07
        7 |          2 |     999.99 |      122 |     0.09
*/

-- PostgreSQL

select
    customers.customer_id,
    customers.customer_name,
    sum(quantity * unit_price) as totals_without_discount,
    sum(quantity * unit_price * (1-discount)) as totals_with_discount
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
having sum(quantity * unit_price * (1-discount)) > 112000
order by totals_with_discount desc;


-- Query Result:

 customer_id |  customer_name   | totals_without_discount | totals_with_discount 
-------------+------------------+-------------------------+----------------------
           1 | Drunken Botanist |               153998.46 |          133918.6608

/*
Learnings:

The new calculation for order totals with discounts needs to be used three times in the:
    1. SELECT statement when defining the alias 
    2. HAVING clause - here we cannot use the alias and the calculation needs to be repeated
    3. ORDER BY clause - here we can reuse the alias created in the SELECT statement.

When testing writing the query on the command line, kept getting "Column reference is ambiguous" error.
This was caused by a typo in select statement when the two calculating columns were given the same name.
As a result, the name could not be resolved until it was corrected.
*/