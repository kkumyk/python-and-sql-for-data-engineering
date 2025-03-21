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
SELECT st.student_id,
       st.student_name,
       sub.subject_name,
       COUNT(e.student_id) AS attended_exams
FROM students st
CROSS JOIN subjects sub
LEFT JOIN examinations e
    ON st.student_id = e.student_id
    AND e.subject_name = sub.subject_name
GROUP BY st.student_id, st.student_name, sub.subject_name
ORDER BY st.student_id, sub.subject_name;
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

[197. Rising Temperature](https://leetcode.com/problems/rising-temperature/)
```sql
select today.id from Weather yesterday cross join Weather today where today.recorddate - yesterday.recorddate = 1 and today.temperature > yesterday.temperature 
```

[577. Employee Bonus](https://leetcode.com/problems/employee-bonus/)
```sql
select e.name, b.bonus from employee e left join bonus b on e.empId=b.empId where bonus < 1000 or bonus is null
```

[1661. Average Time of Process per Machine](https://leetcode.com/problems/average-time-of-process-per-machine/)
```sql
SELECT  machine_id,
        ROUND(
            AVG(
            CASE 
                WHEN activity_type = 'start' THEN -timestamp 
                ELSE timestamp
            END)::decimal * 2
            , 3) AS processing_time
FROM Activity
GROUP BY machine_id
ORDER BY machine_id ASC;
```

<!-- This query is more concise and might execute faster because it avoids a self-join and processes the data in a single pass.
It uses a CASE statement within an aggregate function (AVG) to compute the average processing time directly. 

Transforming start and end Timestamps in One Step:
    CASE WHEN activity_type = 'start' THEN -timestamp ELSE timestamp END
    This inverts start timestamps by making them negative while keeping end timestamps positive.

Summing Over Each machine_id and Averaging
    Since each (machine_id, process_id) pair has exactly one start and one end, summing them within AVG() results in:
    AVG(end−start)
    AVG(end−start)
    Multiplying by 2 compensates for the effect of averaging over two rows per process (one start and one end).

Using ROUND(..., 3) with Explicit Casting
    ::decimal * 2 ensures correct rounding behavior in PostgreSQL.

-->

[620. Not Boring Movies](https://leetcode.com/problems/not-boring-movies/description/)
```sql
SELECT id, movie, description, rating
FROM Cinema
WHERE id%2 != 0 AND description != 'boring'
ORDER BY rating DESC

SELECT id, movie, description, rating
FROM Cinema
WHERE id % 2 = 1 AND description != 'boring'
ORDER BY rating DESC;
```

[1075. Project Employees I](https://leetcode.com/problems/project-employees-i/description/)
```sql
select p.project_id,
round(sum(e.experience_years)/count(p.project_id)::numeric, 2) as average_years
from Project p
join Employee e
on e.employee_id=p.employee_id
group by project_id


select project_id,round(avg(experience_years)::numeric,2) as average_years
from Project p
left join Employee e on e.employee_id=p.employee_id
Group by project_id order by project_id;
```

[1633. Percentage of Users Attended a Contest](https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/)
```sql
SELECT 
    r.contest_id, 
    ROUND(COUNT(DISTINCT r.user_id) * 100.0 / (SELECT COUNT(*) FROM Users), 2) AS percentage
FROM Register r
GROUP BY r.contest_id
ORDER BY percentage DESC, contest_id ASC;
```

[1211. Queries Quality and Percentage](https://leetcode.com/problems/queries-quality-and-percentage/description/)

```sql
with query_stats as (
    select query_name,
    sum(rating::numeric/position) as total_quality, -- Dog: (5/1) + (5/2) + (1/200) = 7.505
    count(*) as total_queries, -- Dog: 3 queries
    count(*) filter(where rating < 3) as poor_queries -- Dog: 1 (1/200 row)
    from queries
    group by query_name
)
select
    query_name,
    round(total_quality / total_queries, 2) as quality,
    round(100.0 * poor_queries / total_queries, 2) as poor_query_percentage
from query_stats;
```

[2356. Number of Unique Subjects Taught by Each Teacher](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/)
```sql
select
    teacher_id,
    count(distinct(subject_id)) as cnt
from Teacher
group by teacher_id
```

[1141. User Activity for the Past 30 Days I](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/)

```sql
select
    activity_date as day,
    count(distinct user_id) as active_users
from Activity
where activity_date between (date('2019-07-27') - interval '29' day) and date('2019-07-27')
group by activity_date
```

[596. Classes More Than 5 Students](https://leetcode.com/problems/classes-more-than-5-students/description/)
```sql
select class
from Courses
group by class
having count(student) >= 5
```

[1729. Find Followers Count](https://leetcode.com/problems/find-followers-count/description/)
```sql
select user_id, count(follower_id) as followers_count
from Followers
group by user_id
order by user_id asc
```

[619. Biggest Single Number](https://leetcode.com/problems/biggest-single-number/description/)

```sql
with pre_processing as (
    select num
    from MyNumbers
    group by num
    having count(num)=1
)
select max(num) as num
from pre_processing
```

[1978. Employees Whose Manager Left the Company](https://leetcode.com/problems/employees-whose-manager-left-the-company/description/)
```sql
select employee_id from Employees
where manager_id not in (select employee_id from Employees)
and salary < 30000
order by employee_id
```

[1731. The Number of Employees Which Report to Each Employee](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/)
```sql
select
    e.reports_to as employee_id,
    m.name,
    count(e.employee_id) as reports_count,
    round(avg(e.age)) as average_age
from Employees e
join Employees m on m.employee_id = e.reports_to
where e.reports_to <> 0
group by e.reports_to, m.name
order by e.reports_to


select f.employee_id, f.name, count(1) as reports_count, ROUND(AVG(e.age), 0) as average_age
from Employees e
JOIN Employees f
ON e.reports_to = f.employee_id
group by f.employee_id, f.name
order by f.employee_id
```