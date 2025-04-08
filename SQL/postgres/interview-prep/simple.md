
[1667. Fix Names in a Table](https://leetcode.com/problems/fix-names-in-a-table/description/)

```sql

select
    user_id,
    upper(substring(name from 1 for 1)) || lower(substring(name from 2)) as name
from Users
order by user_id

```


[Patients with a condition](https://leetcode.com/problems/patients-with-a-condition/description/)

```sql
select patient_id, patient_name, conditions
from patients
where conditions like 'DIAB1%' or conditions like '% DIAB1%'
```


[1193. Monthly Transactions I](https://leetcode.com/problems/monthly-transactions-i/description/)

```sql

-- Execution Performance
--     FILTER clause (Query 2) is generally more concise and potentially more optimized internally.
--     CASE WHEN (Query 1) is very common, but can be slightly more verbose.
--     In very large datasets, the performance difference is usually negligible,
--     but FILTER might have a tiny edge in clarity and parsing efficiency.

select 
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    sum(case when state='approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state ='approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country


SELECT TO_CHAR(trans_date, 'YYYY-MM') AS month,
            country,
            COUNT(*) AS trans_count, 
            COUNT(state) FILTER (WHERE state = 'approved') AS approved_count, 
            SUM(amount) AS trans_total_amount,
            COALESCE(SUM(amount) FILTER (WHERE state = 'approved'), 0) AS approved_total_amount
FROM Transactions
GROUP BY "month", country;

/*
Snowflake CTEs (Common Table Expressions) can increase cost if misused — but in some cases (like this one), they can actually help performance or readability without impacting cost much.

This CTE is good because:
    - Used only once – Snowflake will likely inline it during execution.
    - Avoids recomputing TO_CHAR(trans_date, 'YYYY-MM') in both SELECT and GROUP BY — this saves CPU cycles.
    - Improves readability — without adding real cost in this case.

When CTEs Can Increase Cost:
    - Snowflake does not cache CTEs, so they will re-run if used multiple times in the same query
    - 
    WITH cte AS (SELECT ... FROM big_table)
    SELECT * FROM cte WHERE ...;
    SELECT COUNT(*) FROM cte;
This would scan big_table twice — doubling cost. Avoid this unless you materialize it as a temp table or view.

Pro Optimization Tip:
    If you're worried about CTE cost:
        - Replace with a subquery in FROM clause: Same benefits, same plan.
        - Or use a TEMP TABLE or MATERIALIZED VIEW if reused many times.

        
*/

WITH prepped AS (
    SELECT 
        TO_CHAR(trans_date, 'YYYY-MM') AS month,
        country,
        state,
        amount
    FROM transactions
)
SELECT 
    month,
    country,
    COUNT(*) AS trans_count,
    COUNT(*) FILTER (WHERE state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    COALESCE(SUM(amount) FILTER (WHERE state = 'approved'), 0) AS approved_total_amount
FROM prepped
GROUP BY month, country;

```


[196. Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/description/)
```sql
    delete from person
    where id not in (
        select min(id)
        from person
        group by email)

with min_ids as (
    select min(id) as keep_id from person group by email
)
delete from person
where id not in (select keep_id from min_ids)
```

[1484. Group Sold Products By The Date](https://leetcode.com/problems/group-sold-products-by-the-date/description/)

```sql
select
    sell_date,
    count(distinct product) as num_sold,
    string_agg(distinct product, ',' order by product) as products
from activities
group by sell_date
order by sell_date


select
    sell_date,
    count(distinct product) as num_sold,
    string_agg(product, ',' order by product) as products
from (
    select distinct sell_date, product fro activities
) sub
group by sell_date
order by sell_date
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
)


select round(avg(case
                    when order_date = customer_pref_delivery_date then 1
                    else 0
                end) * 100, 2) as immediate_percentage
from delivery d
where order_date = (
    select min(order_date)
    from delivery d2
    where d.customer_id=d2.customer_id
)
```

[550. Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/description/)

```sql
with cte as (
    select
        count(distinct player_id) as active_user
    from (
        select *,
            rank() over (partition by player_id order by event_date asc) as rank,
            lag(event_date) over(partition by player_id order by event_date asc) as lag_date
            from activity) as x where x.rank <=2 and event_date = lag_date + interval '1 day'),
cte2 as (select
            count(distinct player_id) as total_user
            from activity)
select ROUND(active_user*1.0/total_user,2) as fraction from cte,cte2


SELECT 
    ROUND(COUNT(*)::numeric / (SELECT COUNT(DISTINCT player_id) FROM activity), 2) AS fraction
FROM activity a
WHERE (player_id, event_date) IN (
        SELECT player_id, MIN(event_date) + INTERVAL '1 day' 
        FROM activity 
        GROUP BY player_id
    )

-- MIN(event_date) is the first log date
-- MIN(event_date) + INTERVAL '1 day' finds the next day's log

WITH total_players AS (
    SELECT COUNT(DISTINCT player_id) AS total_user
    FROM activity
),
active_consecutive AS (
    SELECT COUNT(DISTINCT player_id) AS active_user
    FROM activity a
    WHERE (player_id, event_date) IN (
        SELECT player_id, MIN(event_date) + INTERVAL '1 day'
        FROM activity
        GROUP BY player_id
    )
)
SELECT ROUND(active_user::numeric / total_user, 2) AS fraction
FROM active_consecutive, total_players;


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





<hr>

## Revision Completed

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
-- join tables and filter nulls
select v.customer_id, count(*) as count_no_trans
from visits v
left join transactions t
on v.visit_id=t.visit_id
where t.transaction_id is null
group by v.customer_id

-- exclude visits in transactions
-- NOT IN makes clear that we only selecting visits that are not in transactions
select customer_id, count(*) as count_no_trans
from visits
where visit_id not in (select visit_id from Transactions)
group by customer_id


select v.customer_id, count(*) as count_no_trans
from Visits v
left join Transactions t
on t.visit_id=v.visit_id
where v.visit_id not in (select visit_id from Transactions)
group by v.customer_id

-- a more efficient query for some DBs with NOT EXISTS
-- NOT EXISTS here: Does a transaction exists for this visit? If not, count in. 

select customer_id, count(*) as count_no_trans
from visits v
where not exists (
    select 1 from Transactions t where t.visit_id=v.visit_id
)
group by customer_id
```

[197. Rising Temperature](https://leetcode.com/problems/rising-temperature/)
```sql
select today.id
from Weather yesterday
cross join Weather today
where today.recorddate - yesterday.recorddate = 1
and today.temperature > yesterday.temperature 


select y.id
from Weather y
cross join Weather t
where y.recordDate - t.recordDate = 1
and y.temperature > t.temperature
```


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

select id, movie, description, rating
from Cinema
where id%2!=0 and description != 'boring'
order by rating desc
```


[577. Employee Bonus](https://leetcode.com/problems/employee-bonus/)
```sql
select e.name, b.bonus
from employee e
left join bonus b
on e.empId=b.empId
where bonus < 1000
or bonus is null

select e.name, b.bonus
from Employee e
left join Bonus b
on b.empId=e.empId
where b.bonus<1000
or b.bonus is null
```

[1075. Project Employees I](https://leetcode.com/problems/project-employees-i/description/)
```sql
select p.project_id,
round(sum(e.experience_years)/count(p.project_id)::numeric, 2) as average_years
from Project p
join Employee e
on e.employee_id=p.employee_id
group by project_id

select project_id, round(avg(experience_years)::numeric, 2) as average_years
from Project p
left join Employee e
on e.employee_id=p.employee_id
group by project_id order by project_id;

select p.project_id, round(avg(experience_years)::numeric, 2) as average_years
from Project p
left join Employee e
on p.employee_id=e.employee_id
group by p.project_id
```

[2356. Number of Unique Subjects Taught by Each Teacher](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/description/)
```sql
select
    teacher_id,
    count(distinct subject_id) as cnt
from Teacher
group by teacher_id

-- The GROUP BY clause is required here because you are using an aggregate function (COUNT(DISTINCT subject_id)). Key SQL Rule:
-- Whenever you use an aggregate function in SELECT (like COUNT, SUM, AVG, etc.), all other columns must be grouped using GROUP BY.
-- If you are using an aggregate function but also selecting non-aggregated columns, you must use GROUP BY to avoid errors!
```

[1729. Find Followers Count](https://leetcode.com/problems/find-followers-count/description/)
```sql
select user_id, count(follower_id) as followers_count
from Followers
group by user_id
order by user_id 
```

[1211. Queries Quality and Percentage](https://leetcode.com/problems/queries-quality-and-percentage/description/)

```sql
select
        query_name,
        round(avg(rating::numeric / position), 2) as quality,
        round(avg(case when rating < 3 then 1 else 0 end) * 100, 2) as poor_query_percentage
from queries
group by query_name
```

[1633. Percentage of Users Attended a Contest](https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/)
```sql

select
    r.contest_id,
    round(count(distinct r.user_id) * 100.0  / (select count(user_id) from Users), 2) as percentage
from Register r
group by r.contest_id
order by percentage desc, r.contest_id asc

select
    contest_id,
    round((count(distinct user_id):: decimal / (select count(*) from Users)) * 100, 2) as percentage 
from Register
group by contest_id
order by percentage desc, contest_id

-- SQL executes queries in the following order:
-- 1️. FROM → Define tables and joins.
-- 2️. WHERE → Apply row filtering.
-- 3️. GROUP BY → Group data (if aggregation is used).
-- 4️. HAVING → Filter grouped results.
-- 5️. SELECT → Compute column expressions & assign aliases.
-- 6️. ORDER BY → Sort results (can use SELECT aliases).
-- 7️. LIMIT / OFFSET → Apply pagination.

with
    total_users as (
        select count(user_id) as all_users from Users
    ),
    pre_calc as (
        select
            r.contest_id,
            count(distinct r.user_id) as nr_reg
        from Register r
        group by r.contest_id
    )
select
    p.contest_id,
    round(cast(p.nr_reg as decimal) / nullif(tu.all_users, 0) * 100, 2) as percentage
from pre_calc p
cross join total_users tu
order by percentage desc, p.contest_id asc


select
    r.contest_id,
    round(count(distinct r.user_id) * 100.0 / u.total, 2) as percentage
from Register r
cross join (select count(user_id) as total from users) u
group by r.contest_id, u.total
order by percentage desc, r.contest_id asc

```

[1978. Employees Whose Manager Left the Company](https://leetcode.com/problems/employees-whose-manager-left-the-company/description/)
```sql

select employee_id from Employees
where manager_id not in (select employee_id from Employees)
and salary < 30000
order by employee_id

```

[596. Classes More Than 5 Students](https://leetcode.com/problems/classes-more-than-5-students/description/)
```sql
select class
from Courses
group by class
having count(student) >= 5
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


select max(num) as num
from (
    select num
    from MyNumbers
    group by num
    having count(num)=1
)

```

[1141. User Activity for the Past 30 Days I](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/description/)

```sql
select
    activity_date as day,
    count(distinct user_id) as active_users
from Activity   
where activity_date between (date('2019-07-27') - interval '29' day) and date('2019-07-27')
group by activity_date


select activity_date as day , count(distinct user_id) as active_users
from activity
where activity_date <= '2019-07-27' and activity_date > '2019-06-27'
group by activity_date;

select activity_date AS day, count(distinct user_id) AS active_users from Activity
where activity_date BETWEEN '2019-06-28' AND '2019-07-28'
group by activity_date

select
    activity_date as day,
    count(distinct user_id) as active_users
from
    Activity
where activity_date between date('2019-06-28') and date('2019-07-27')
group by activity_date 

```

[1731. The Number of Employees Which Report to Each Employee](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/)

```sql

-- most efficient in terms of logical clarity
select
    m.employee_id,
    m.name,
    count(e.employee_id) as reports_count,
    round(avg(e.age)) as average_age
from
    Employees m
join Employees e
    on m.employee_id=e.reports_to
group by
    m.employee_id,
    m.name
order by
    m.employee_id

select
    m.employee_id,
    m.name,
    count(e.reports_to) as reports_count,
    round(avg(e.age)) as average_age
from Employees m
join Employees e
on m.employee_id = e.reports_to
group by m.employee_id, m.name
order by m.employee_id

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

select
    employee_id,
    department_id
from
    Employee
where employee_id in (
    select
        employee_id
    from
        Employee
    group by employee_id
    having count(employee_id)=1
    )
    or primary_flag = 'Y'

select
    employee_id,
    department_id
from
    Employee
where employee_id in (
    select employee_id
    from Employee
    group by employee_id
    having count(employee_id)=1
) or primary_flag='Y'


select 
    employee_id,
    department_id
from Employee
where primary_flag = 'Y' or employee_id in (
    select
        employee_id
    from
        Employee
    group by employee_id
    having count(employee_id) = 1
)

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

```

[610. Triangle Judgement](https://leetcode.com/problems/triangle-judgement/description/)

```sql

select x, y, z, 
case
    when    
end as triangle
from Triangle

```