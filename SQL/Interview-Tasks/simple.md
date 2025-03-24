[1378. Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)

```sql
select eu.unique_id, e.name
from Employees e
left join EmployeeUNI eu
on eu.id=e.id 
```
Using <code>LEFT JOIN</code> ensures that we get all employees even if they don't have a corresponding entry in the employeeuni table. In no match was found "NULL" will be retured for the unique_id.

[1415 Students and Examinations](https://leetcode.com/problems/students-and-examinations/description/)

```sql
SELECT s.student_id,
       s.student_name,
       sub.subject_name,
       COUNT(e.student_id) AS attended_exams
FROM students s
CROSS JOIN subjects sub
LEFT JOIN examinations e
    ON s.student_id = e.student_id
    AND e.subject_name = sub.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
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

[595. Big Countries](https://leetcode.com/problems/big-countries/)
```sql
select name, population, area from World where area>=3000000 or population>=25000000
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


[1789. Primary Department for Each Employee](https://leetcode.com/problems/primary-department-for-each-employee/)
```sql
with ids as (select e.employee_id
from Employee e
group by e.employee_id
having count(e.employee_id)=1
)
select i.employee_id, e.department_id
from ids i
left join Employee e on i.employee_id=e.employee_id
union all
select employee_id, department_id
from Employee
where primary_flag='Y'


SELECT employee_id, department_id FROM Employee WHERE employee_id IN (
SELECT employee_id FROM Employee
GROUP BY employee_id HAVING COUNT(*) =1) OR primary_flag = 'Y'
```


[610. Triangle Judgement](https://leetcode.com/problems/triangle-judgement/description/)
```sql
select x, y, z, 
case
    when x+y>z and y+z>x and z+x> y then 'Yes' else 'No'
end as triangle
from triangle
```

[1667. Fix Names in a Table](https://leetcode.com/problems/fix-names-in-a-table/description/)
```sql
select user_id,
upper(substring(name from 1 for 1)) || lower(substring(name from 2)) as name
from Users order by user_id
```

[Patients with a condition](https://leetcode.com/problems/patients-with-a-condition/description/)

```sql
select patient_id, patient_name, conditions
from patients
where conditions like 'DIAB1%' or conditions like '% DIAB1%'
```

[196. Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/description/)
```sql
delete from person
where id not in (select min(id) from person group by email)
```

[1484. Group Sold Products By The Date](https://leetcode.com/problems/group-sold-products-by-the-date/description/)

```sql
select sell_date, count(distinct product) as num_sold,
string_agg(distinct product, ',' order by product) as products
from activities
group by sell_date
order by sell_date
```

[1193. Monthly Transactions I](https://leetcode.com/problems/monthly-transactions-i/description/)

```sql
select 
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    sum(case when state='approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state ='approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country 
```

[1174. Immediate Food Delivery II](https://leetcode.com/problems/immediate-food-delivery-ii/description/)

```sql
select round(avg(case when order_date = customer_pref_delivery_date then 1
                else 0 end) * 100, 2) as immediate_percentage
from delivery
where (customer_id, order_date) in (
                select customer_id,
                    min(order_date)
                    from delivery
                    group by customer_id
);
```

[550. Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/description/)

```sql
select round(
    1.0 * count(player_id) / 
    (select count(distinct player_id)
    from activity), 2) as fraction
from activity
where (player_id, event_date) in (
    select player_id, min(event_date) + 1
    from activity
    group by player_id
);

with cte as (
    select count(distinct player_id) as active_user
    from (
        select *,
               rank() over (partition by player_id order by event_date asc) as rank,
               lag(event_date) over (partition by player_id order by event_date asc) as lag_date
        from activity
    ) as x 
    where x.rank <= 2 
          and event_date = lag_date + interval '1 day'
),
cte2 as (
    select count(distinct player_id) as total_user 
    from activity
)

select round(active_user * 1.0 / total_user, 2) as fraction 
from cte, cte2;



```




### Revised

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

[1148. Article Views I](https://leetcode.com/problems/article-views-i/)

```sql
select author_id as id from Views where author_id=viewer_id group by id order by id

select distinct author_id id from Views where author_id=viewer_id order by author_id

select author_id as id
from Views
where author_id=viewer_id
group by author_id
```


[1683. Invalid Tweets](https://leetcode.com/problems/invalid-tweets/)
```sql
-- LENGTH(string)
-- Returns the number of bytes in the given string.
-- If the string contains multi-byte characters, the length will be greater than the number of characters.
select tweet_id from Tweets where length(content)>15

-- CHAR_LENGTH(string) / CHARACTER_LENGTH(string)
-- Returns the number of characters in the given string.
-- This is useful for handling multi-byte characters correctly.
select tweet_id
from tweets
where char_length(content) > 15;
```

[1068. Product Sales Analysis I](https://leetcode.com/problems/product-sales-analysis-i/)

```sql
-- INNER JOIN retrieves only matching rows from both tables.
select p.product_name, s.year, s.price
from Product p
join Sales s
on p.product_id=s.product_id
order by s.year 

-- LEFT JOIN - slightly slower than INNER JOIN due to additional data retrieval.
-- If a product_id is missing in Product, product_name will be NULL in the output.
-- LEFT JOIN might be slightly slower since it includes unmatched rows.
select p.product_name, s.year, s.price
from Sales s
left join Product p
on s.product_id=p.product_id

-- If all product_ids in Sales exist in Product, INNER JOIN is more efficient in both time and space.
-- If some product_ids in Sales may not exist in Product, and we still want those rows, use LEFT JOIN.
```