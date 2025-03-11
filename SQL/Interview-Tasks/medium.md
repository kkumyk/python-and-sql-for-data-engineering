[570. Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/)

```sql
SELECT m.name
FROM Employee e
JOIN Employee m ON m.id=e.managerId
GROUP BY m.name, e.managerId
HAVING COUNT(e.id) >= 5;
```