[1757. Recyclable and Low Fat Products](https://leetcode.com/problems/recyclable-and-low-fat-products/)

```sql
select product_id from Products where low_fats = 'Y' and recyclable = 'Y'
```

[584. Find Customer Referee](https://leetcode.com/problems/find-customer-referee/description/)

In SQL, the != (or <>) operator does not compare NULL values because NULL represents an unknown value. In SQL, any comparison with NULL results in NULL (which is treated as unknown or false in a WHERE clause).

If referee_id is NULL, the condition becomes NULL != 2, which results in NULL.
Since SQL ignores NULL in WHERE conditions (it is neither TRUE nor FALSE), rows where referee_id is NULL are not included in the result.

To handle NULL values in comparisons, use IS NULL or IS NOT NULL explicitly.

```sql
select name from Customer where referee_id != 2 or referee_id is null
```

1415 Students and Examinations

```sql
SELECT  st.student_id,
        st.student_name,
        s.subject_name,
        COUNT(e.student_id) AS attended_exams
FROM students st
CROSS JOIN subjects s
LEFT JOIN examinations e
    ON st.student_id = e.student_id
    AND e.subject_name = s.subject_name
GROUP BY st.student_id, st.student_name, s.subject_name
ORDER BY st.student_id, st.student_name, s.subject_name;
```
 