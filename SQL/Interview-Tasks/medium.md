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