/* 34. High-value customers - with discount
    - use discount when calculation high-value customers
    - the discount is applied as a percentage
    - use parenthesis around (1 - Discount) to make sure that calculation is done first.
*/

select
    customers.customerid,
    customers.contactname,
    sum(quantity * unitprice) as totals_without_discount,
    sum(quantity * unitprice * (1-discount)) as totals_with_discount
from customers
    join orders
        on orders.customerid = customers.customerid
    join order_details
        on orders.orderid = order_details.orderid
where
    orderdate >= '2016-01-01' and orderdate < '2017-01-01'
group by
    customers.customerid,
    customers.contactname
having sum(quantity * unitprice * (1-discount)) > 15000
order by totals_with_discount desc;

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