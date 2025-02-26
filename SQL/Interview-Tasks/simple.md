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

[1148. Article Views I](https://leetcode.com/problems/article-views-i/)

<!-- +---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 

Note that equal author_id and viewer_id indicate the same person.

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.

The result format is in the following example.

Input: 
Views table:
+------------+-----------+-----------+------------+
| article_id | author_id | viewer_id | view_date  |
+------------+-----------+-----------+------------+
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |
+------------+-----------+-----------+------------+
Output: 
+------+
| id   |
+------+
| 4    |
| 7    |
+------+
-->

```sql
select author_id as id from Views where author_id=viewer_id group by id order by id

select distinct author_id id from Views where author_id=viewer_id order by author_id
```

[1683. Invalid Tweets](https://leetcode.com/problems/invalid-tweets/)

```sql
select tweet_id from Tweets where length(content)>15
```

[595. Big Countries](https://leetcode.com/problems/big-countries/)
```sql
select name, population, area from World where area>=3000000 or population>=25000000
```

[1378. Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)
```sql
select eu.unique_id, e.name from Employees e left join EmployeeUNI eu on eu.id=e.id 
```
<!-- Table: Employees

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| name          | varchar |
+---------------+---------+

Table: EmployeeUNI

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| unique_id     | int     |
+---------------+---------+ 

Input: 
Employees table:
+----+----------+
| id | name     |
+----+----------+
| 1  | Alice    |
| 7  | Bob      |
| 11 | Meir     |
| 90 | Winston  |
| 3  | Jonathan |
+----+----------+
EmployeeUNI table:
+----+-----------+
| id | unique_id |
+----+-----------+
| 3  | 1         |
| 11 | 2         |
| 90 | 3         |
+----+-----------+
Output: 
+-----------+----------+
| unique_id | name     |
+-----------+----------+
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |
+-----------+----------+ -->
Using <code>LEFT JOIN</code> ensures that we get all employees even if they don't have a corresponding entry in the employeeuni table. In no match was found "NULL" will be retured for the unique_id.

[1068. Product Sales Analysis I](https://leetcode.com/problems/product-sales-analysis-i/)

```sql
select p.product_name, s.year, s.price from Product p join Sales s on p.product_id=s.product_id order by s.year 
```

[1581. Customer Who Visited but Did Not Make Any Transactions](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/)
```sql
select v.customer_id, count(*) as count_no_trans from visits v LEFT JOIN transactions t on v.visit_id=t.visit_id where t.transaction_id is null group by v.customer_id
```

