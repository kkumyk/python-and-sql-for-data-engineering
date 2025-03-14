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

