[570. Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/)

```sql
SELECT m.name
FROM Employee e
JOIN Employee m ON m.id=e.managerId
GROUP BY m.name, e.managerId
HAVING COUNT(e.id) >= 5;
```

[1934. Confirmation Rate](https://leetcode.com/problems/confirmation-rate/description/)

```sql
SELECT s.user_id, round(avg(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END), 2) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id=c.user_id
GROUP BY s.user_id
```

[1251. Average Selling Price](https://leetcode.com/problems/average-selling-price/description/)
```sql
SELECT p.product_id, COALESCE(ROUND(SUM(u.units*p.price)/SUM(u.units)::decimal, 2), 0) as average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON u.product_id = p.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id

-- Runtime: 182 ms - slightly slower due to how it handles null values and data type conversions

----------------------------------------------
-- SQL queries execute in the following order:

--     FROM & JOIN: Combines Prices and UnitsSold tables based on product_id and purchase_date.
--     WHERE (ON condition in LEFT JOIN): Filters only valid price periods for each sale.
--     GROUP BY: Groups by product_id to aggregate values.
--     SELECT: Computes the average_price calculation.
--     CASE & COALESCE: Handles cases where a product has no sales.
--     ROUND(): Ensures output has 2 decimal places.

    SELECT 
        p.product_id,
        CASE
            WHEN SUM(u.units) is null
            THEN 0
            ELSE
                ROUND(SUM(u.units * p.price) / SUM(u.units)::numeric, 2)
        END
        AS average_price
    FROM 
        Prices p
LEFT JOIN 
    UnitsSold u
ON 
    u.product_id = p.product_id 
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;

-- Runtime: 176 ms
```


[1045. Customers Who Bought All Products](https://leetcode.com/problems/customers-who-bought-all-products/description/)

```sql
select 
c.customer_id as customer_id
from customer c
group by c.customer_id
having count(distinct c.product_key) = (select count(*) from product)

```


[1070. Product Sales Analysis III](https://leetcode.com/problems/product-sales-analysis-iii/description/)
```sql
with first_year as (select product_id, min(year) as first_year
from sales
group by product_id )
select s.product_id, s.year as first_year, s.quantity, s.price
from sales s
join first_year f
on s.product_id = f.product_id and f.first_year = s.year
```


[180. Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/description/)

```sql
select distinct l1.num as ConsecutiveNums
from logs l1
join logs l2 on l2.id=l1.id+1 and l2.num=l1.num
join logs l3 on l3.id=l2.id+1 and l3.num=l2.num;
```

[1204. Last Person to Fit in the Bus](https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/)

```sql
select person_name
from (
    select
        person_id,
        person_name,
        sum(weight) over (order by turn) as cum_sum
    from queue
    order by turn desc
)
where cum_sum <= 1000
limit 1;
```