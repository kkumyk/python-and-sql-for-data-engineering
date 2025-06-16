# PostgreSQl - Tasks By Topic

## JOINs

### INNER JOIN

- "give me the rows that exist in both tables"
- returns only the rows where it is a match in both tables based on a conditions - a common key


[1070. Product Sales Analysis III](https://leetcode.com/problems/product-sales-analysis-iii/description/)

```sql
/*
Write a solution to select the product id, year, quantity, and price for the first year of every product sold. If any product is bought multiple times in its first year, return all sales separately.
- start by building CTE to isolate the earliest year each product appearst in the Sales table
- the CTE here keeps the logic modular and makes the main query easier to read
- use min() to find the earliest year per product
- group by product_id ensures this is done per product
- using CTE instead of a subquery makes the query cleaner and better for debugging and reuse
- next, join the original data with the first_year data from the CTE on both -  product Id and year - this ensures I pull only the rows where the sale happened in that product's first year - not just any year.
*/

with first_year as (
    select
        product_id,
        min(year) as first_year
from sales
group by product_id)
select
    s.product_id,
    s.year as first_year,
    s.quantity,
    s.price
from sales s
join first_year f
on s.product_id = f.product_id
and s.year = f.first_year
```


[180. Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/description/)

```sql
/*
- Find all numbers that appear at least three times consecutively in the logs table.
- to find three consecutive rows with the same number, self-join the logs table twice
- first, match a row l1 with the next one - l2 by checking l2.id = l1.id+1 and ensure they have the same value: l2.num =  l1.num - this ensures that we are looking at three rows with the same values num and increasing id values
- select l1.num because that represents the first number in the 3-row sequence
- use DISTINCT to return each qualifying nubmer only once - even if that pattern appears multiple times
- this query identifies numers that appear at least three consecutive rows; use two self-joins to align a row with the next two rows using id + 1 and id + 2, and ensure all three have the same value num; select only the first number in the sequence and use DISTINCT to remove duplicates; this pattern is useful in detecting trends, anomalies, or behavioral patterns in ordered datasets.
*/

select
    distinct l1.num as ConsecutiveNums
from Logs l1
join Logs l2 on l2.id = l1.id + 1 and l1.num = l2.num
join Logs l3 on l3.id = l2.id + 1 and l2.num = l3.num
```


### LEFT JOIN

[1934. Confirmation Rate](https://leetcode.com/problems/confirmation-rate/description/)

```sql
/*
- include all records from the left/first table and matching records from the right/second table
- if there are no matches in the right table, returned value for not found matches will be NULL
- order matters: the "source of truth" / the primary table should be specified first

confirmation rate of each user:
- nr of 'confirmed' messages / total number of requested confirmation messages

- calc nr of 'confirmed' messages for each user
- calc nr of total action messages for each user
- use left join to join Signups table first as Confirmations table might not contain users that did not request confirmation; this way we are not missing any users
*/

select
    s.user_id,
    round(
        avg(case when c.action = 'confirmed' then 1 else 0 end), 2) as confirmation_rate 
from Signups s
left join Confirmations c
on s.user_id = c.user_id
group by s.user_id

```


[1251. Average Selling Price](https://leetcode.com/problems/average-selling-price/description/)
```sql
select
    p.product_id,
    coalesce(round(
        sum(u.units*p.price)/sum(u.units)::decimal, 2), 0) as average_price
from Prices p
left join UnitsSold u
on u.product_id = p.product_id and u.purchase_date between p.start_date and p.end_date
group by p.product_id

-- slightly slower due to how it handles null values and data type conversions

----------------------------------------------
-- SQL queries execute in the following order:

--     FROM & JOIN: Combines Prices and UnitsSold tables based on product_id and purchase_date.
--     WHERE (ON condition in LEFT JOIN): Filters only valid price periods for each sale.
--     GROUP BY: Groups by product_id to aggregate values.
--     SELECT: Computes the average_price calculation.
--     CASE & COALESCE: Handles cases where a product has no sales.
--     ROUND(): Ensures output has 2 decimal places.

select
    p.product_id,
    case
        when sum(u.units) is null
        then 0
        else
            round(sum(u.units * p.price) / sum(u.units)::numeric, 2)
        end
        as average_price
from prices p
left join unitssold u
on u.product_id = p.product_id and u.purchase_date between p.start_date and p.end_date
group by p.product_id;

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


## Window Functions (Part 1)

Topics:
- ROW_NUMBER(), RANK(), DENSE_RANK()
- all ranking window functions
- assign a number to each row to each row within a partition (e.g.: per customer, product, category)
- use PARTITION BY to group rows logically (like GROUP BY)
- use ORDER BY to define how to rank the rows

Practice:
- Find top 3 products by revenue per category
- First order per customer

- Goal: Understand row partitioning & ordering

### ROW_NUMBER()
- assigns a unique suquential number to each row
- no ties: every row will get a different rank even if the value is equal

#### Use Cases
- deduplicate rows: keep the latest row per group
- get the first or latest record per group
- paginate data

Example:

```sql
SELECT *
FROM (
  SELECT *,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY order_date DESC) AS rn
  FROM orders
) AS ranked_orders
WHERE rn = 1;

```


```sql
/*
Write a query to detect duplicate records in a table and delete only the extra duplicates, keeping one copy.
id | name | email | created_at
- remove duplicate rows based on name and email, keeping only one row per name + email combination
- use a CTE with the ROW_NUMBER() window function to identify duplicates
- PARTITION BY name, email: groups rows by duplicate-defining columns
- ROW_NUMBER(): assigns a number starting from 1 in each group 
- the row with rn=1 is kept, rows with rn>1 are deleted 
- DELETE FROM duplicates works in dbs that allow modifying CTEs (POSTGRES)
- always test your deletion with a SELECT before deleting
*/

with duplicates as (
    select *,
        row_number() over (
            partition by name, email
            order by id
        ) as rn
    from my_table
)
-- select * from duplicates
-- where rn > 1
delete from duplicates
where rn > 1;
```


[196. Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/description/)

```sql

/*
- ROW_NUMBER() assigns a rank to each row per email, ordering by id.
- You delete anything that is not the first row (i.e., not rn = 1).

- using two subqueries:
    - inner subquery:
    select
        id,
        row_number() over (partition by email order by id) as rn
    from person
    - this subquery gives each row a number within its group of duplicate emails ordered by smallest id first:
    | id | rn | email                                         | (implied) group: email        |
    | -- | -- | --------------------------------------------- | ----------------------------- |
    | 1  | 1  | [john@example.com](mailto:john@example.com)   | ← keep (first row for "john") |
    | 3  | 2  | [john@example.com](mailto:john@example.com)   | ← delete                      |
    | 2  | 1  | [bob@example.com](mailto:bob@example.com)     | ← keep                        |
    | 4  | 1  | [alice@example.com](mailto:alice@example.com) | ← keep                        |
    | 5  | 2  | [alice@example.com](mailto:alice@example.com) | ← delete                      |

    - outer subquery:
    select id
    from (
        -- the ranked table above
    ) as ranked
    where rn = 1
    - this subquery selects only the ids with the rn = 1 - the first occurence of each unique email: 1,2,4

- DELETE any rows not in the list of ids from the outer subquery: 1,2,4  

*/

delete from person
where id not in (
    select id
    from (
            select
                id,
                row_number() over (partition by email order by id) as rn
            from
                person
    )
    where rn = 1
)


delete from person
where id not in (
    select
        min(id)
    from person
    group by email)



with min_ids as (
    select min(id) as keep_id
    from person
    group by email
)
delete from person
where id not in (
    select keep_id
    from min_ids
)

-- Snowflake-Specific Considerations:
--  No DELETE with JOIN: Snowflake does not support DELETE with JOIN like in SQL Server or MySQL.
--  CTEs are materialized efficiently in Snowflake. So using a CTE isn't a bad idea.
--  NOT IN with NULLs can be problematic just like in other DBs, but NOT EXISTS is generally better.
--  MERGE or QUALIFY are often more performant in Snowflake for deduplication.
-- rank rows by email and keep only the first on eper email
```


### RANK()

Skippes numbers after a tie:
- assigns the same rank to tied values
- when multiple rows tie (have the same value), they get the same rank, but the next rank will be skipped
-e.g.: 
    - Alice is highest: Rank = 1
    - Bob and Carol both earn 900 → tie, so both get Rank = 2
    - The next rank is 4, not 3 — because 2 was used twice, so 3 is skipped
- skips numbers after ties leaving gaps in assigned rankings

#### Use Cases
- show rankings (e.g.: leaderboard)
- highlight top-N items, allowing for ties

Example:

```sql
/*
- use RANK() to rank products by revenue within each category
- if two products have the same revenue, they will share the same rank
- important if you want to include all top performance
*/

SELECT *
FROM (
  SELECT product_id,
         category,
         SUM(price * quantity) AS revenue,
         RANK() OVER (PARTITION BY category ORDER BY SUM(price * quantity) DESC) AS rnk
  FROM sales
  GROUP BY product_id, category
) t
WHERE rnk <= 3;
```


[https://leetcode.com/problems/movie-rating/description/](https://leetcode.com/problems/movie-rating/description/)


```sql

/*
- find the user who has rated the most movies
- if there’s a tie, return the name that comes first alphabetically
- join users and movie ratings on user_id to associate each rating with the user's name
- group by user name to get the total number of ratings each user submitted using COUNT(*)
- use the RANK() window function to rank users:
- desc by the counts of ratings so that users with most ratings come first
- asc by by name to break ties alphabetically
- choose RANK() over ROW_NUMBERS() to handle possible ties - RANK() gives the same gives the same rank to tied users
- tieds users - users with the same values
- wrap the ranked results in a subquery and filter to only top user
- the subquery handles the tie in a way so that if two or more users have the same highest rank,
- only the one with the alphabetically smaller name is kept due to order by clause in the RANK()
- we use RANK() without PARTITION BY because we want to calculate global rankacross all users
- in the subquery we are trying to find the user who has rated the most movies overall, not the most within any subgroup
- if we user PARTITION BY, it would reset the rank within each group >>> it would assign rank 1 to each user because each user is their own group
- we reserve PARTITION BY for situations where we want rankings within each group , e.g.: per department, country, product category

-- Why not MAX()
RANK() allows to multiple users if needed and it scales if we would want to see top 3 users

*/

with avg_rating as (
select
    title,
    AVG(rating) AS avg_rating,
    rank() over (order by avg(rating) desc, title asc) as rnk
from (
    select
        m.title as title,
        r.created_at as created_at,
        r.rating as rating
    from MovieRating r
    left join Movies m
    on m. movie_id = r.movie_id
    where date_trunc('month', r.created_at) = date '2020-02-01'
    group by m.title, r.created_at, r.rating
) as ranked_movies
group by title
),
top_user as (
    select name
from (
    select
        u.name,
        count(*) as nr_ratings,
        rank() over ( order by count(*) desc, u.name asc) as rnk
    from MovieRating m
    left join Users u
    on m.user_id = u.user_id
    group by u.name
) as ranked_users
where rnk = 1
)
select
    name as results
from top_user
union all
select title
from avg_rating
where rnk = 1
        
```





[550. Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/description/)

```sql
/*
Find the fraction of players that logged in again on the day after the day they first logged in:
- find users that logged in for at least two consecutive days starting from their first login date
- divide that number by the total number of players
- (player_id, event_date) is the primary key

Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |

Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+ 

select
    player_id,
    event_date,
    rank() over (partition by player_id order by event_date) as rnk,
    lag(event_date) over (partition by player_id order by event_date) as prev_date
from activity 

outputs:
| player_id | event_date | rnk | prev_date  |
| --------- | ---------- | --- | ---------- |
| 1         | 2016-03-01 | 1   | null       |
| 1         | 2016-03-02 | 2   | 2016-03-01 |
| 2         | 2017-06-25 | 1   | null       |
| 3         | 2016-03-02 | 1   | null       |
| 3         | 2018-07-03 | 2   | 2016-03-02 |
*/

-- using rank and lag window functions

with ranked_activity as (
select
    player_id,
    event_date,
    rank() over (partition by player_id order by event_date) as rnk,
    lag(event_date) over (partition by player_id order by event_date) as prev_date
from activity
),
consecutive_day_users as (
    select distinct player_id
    from ranked_activity
    where rnk = 2 and event_date = prev_date + interval '1 day'
),
total_users as (
    select count(distinct player_id) as total_user
    from activity
),
active_users as (
    select count(*) as active_user
    from consecutive_day_users
)
select
    round(cast(active_user as decimal)/ total_user , 2) as fraction
from active_users, total_users

-- using interval to match the consecutive day

with total_players as (
    select
        count(distinct player_id) as total_user
    from activity
),
active_consecutive as (
    select
        count(distinct player_id) as active_user
    from activity a
    where (player_id, event_date) in (
        select
            player_id, min(event_date) + interval '1 day'
        from activity a
        group by player_id
    )
)
select
    round(cast(active_user as decimal) / total_user, 2) as fraction
from active_consecutive, total_players
```


## Window Functions (Part 2)

Topics:
- LEAD(), LAG(), SUM() OVER, AVG() OVER

Practice:
- Calculate 7-day rolling averages
- Compare current vs previous order amount

- Goal: Answer time-series and behavioral pattern questions



[180. Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/description/)

```sql
-- using self-joins

select distinct l1.num as ConsecutiveNums
from Logs l1
join Logs l2 on l1.id = l2.id + 1 and l2.num = l1.num
join Logs l3 on l2.id = l3.id + 1 and l3.num = l2.num

/*
LAG(), LEAD() – window functions, access values from previous or next rows.

- patteern-matching problem with window functions
- define CTE to make logic readable and nums listed next to each other:
| num | prev_num | next_num |
| --- | -------- | -------- |
| 1   | null     | 1        |
| 1   | 1        | 1        |
| 1   | 1        | 2        |
| 2   | 1        | 1        |
| 1   | 2        | 2        |
| 2   | 1        | 2        |
| 2   | 2        | null     |

- in the outer query, filter rows where num is = to prev and next nums
*/

with numbered_logs as (
    select
        num,
        lag(num) over (order by id) as prev_num,
        lead(num) over (order by id) as next_num
    from logs
)
select distinct num as ConsecutiveNums
from numbered_logs
where num = prev_num and num = next_num

```





## UNION and UNION ALL

[1907. Count Salary Categories](https://leetcode.com/problems/count-salary-categories/description/)
```sql
with categories as (
select
    case
    when income > 50000 then 'High Salary'
    when income < 20000 then 'Low Salary' 
    else 'Average Salary'
    end
    as category,
    account_id
from Accounts
),
all_categories as (
    select 'High Salary' as category
    union all
    select 'Average Salary'
    union all
    select 'Low Salary'
)
select
    a.category,
    coalesce(count(c.category), 0) as accounts_count
from all_categories a
left join categories c
on c.category = a.category
group by a.category
order by a.category
```


[626. Exchange Seats](https://leetcode.com/problems/exchange-seats/description/)

```sql
/*
- use a CASE statement with a MAX(id) subquery to handle the case when the number of students is odd
- this avoids assigning a non-existing ID to the las student and keeps the logic clean

odd-numbered rows:
    - id % 2 = 1
    - try id + 1 ONLY if that id exists
even-numbered rows:
    - swap to id - 1 always safe

the final else id is a fallback - for safety of logic clarity
*/

select
    case
        when id % 2 = 1 and id + 1 <= (select max(id) from seat) then id + 1
        when id % 2 = 0 then id - 1
        else id
    end as id,
    student
from seat
order by id;
```





[1204. Last Person to Fit in the Bus](https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/)

```sql

/*

sum(...) over(...) construct is a window function
sum(...) will collapce rows into a single result
a window function does not collapce rows, returns cumulative result
sum(weight) is the function being applied
over(order by turn) defines the window - the order by which the rows are processed
cum_sum - the running cumulative sum of weights ordered by turn
*/

select person_name
from (
    select
        person_name,
        sum(weight) over (order by turn) as cum_sum
    from queue
)
where cum_sum <= 1000
order by cum_sum desc
limit 
```

https://leetcode.com/problems/count-salary-categories/description/?envType=study-plan-v2&envId=top-sql-50



[1174. Immediate Food Delivery II](https://leetcode.com/problems/immediate-food-delivery-ii/description/)

```sql
/*
- immediate order - delivery date is the same as the order date
- what is the percentage of immediate orders in the first orders
- round to two decimal places

- find the total nr of first orders
- find the nr of immediate orders
- use filter to filter out orders that are not first orders
*/

/* 
IN with a tuple and GROUP BY
Snowflake is great at optimizing set-based operations like IN (...) with GROUP BY.
Even though it doesn't support tuple comparison indexes per se, it can precompute the subquery result efficiently.

*/
select round(avg(case when order_date = customer_pref_delivery_date then 1
                else 0 end) * 100, 2) as immediate_percentage
from delivery
where (customer_id, order_date) in (
                select customer_id,
                    min(order_date)
                    from delivery
                    group by customer_id
)

/*
CTE + JOIN
*/
with first_orders as (
  select customer_id, min(order_date) as first_order_date
  from delivery
  group by customer_id
)
selec round(avg(case 
    when d.order_date = d.customer_pref_delivery_date then 1
    else 0 
end) * 100, 2) as immediate_percentage
from delivery d
join first_orders f
  on d.customer_id = f.customer_id and d.order_date = f.first_order_date;




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


[595. Big Countries](https://leetcode.com/problems/big-countries/)
```sql
select name, population, area from World where area>=3000000 or population>=25000000
```






[1661. Average Time of Process per Machine](https://leetcode.com/problems/average-time-of-process-per-machine/)
```sql

/*

CTE result:

| machine_id | process_id | duration           |
| ---------- | ---------- | ------------------ |
| 0          | 0          | 0.808              |
| 0          | 1          | 0.98               |
| 1          | 0          | 1                  |
| 1          | 1          | 0.99               |
| 2          | 0          | 0.4119999999999999 |
| 2          | 1          | 2.5                |
*/

with duration_time as (
select
    machine_id,
    process_id,
    max(case when activity_type = 'end' then timestamp end) -
    min(case when activity_type = 'start' then timestamp end) as duration
from activity
group by machine_id, process_id
order by machine_id, process_id
)
select
    machine_id,
    round(avg(duration::decimal), 3) as processing_time
from duration_time
group by machine_id
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


[1757. Recyclable and Low Fat Products](https://leetcode.com/problems/recyclable-and-low-fat-products/)

```sql
select product_id from Products where low_fats = 'Y' and recyclable = 'Y'
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
--     FILTER clause is generally more concise and potentially more optimized internally.
--     CASE WHEN (Query 1) is very common, but can be slightly more verbose.
--     In very large datasets, the performance difference is usually negligible,
--     but FILTER might have a tiny edge in clarity and parsing efficiency.

select
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    count(*) filter ( where state='approved') as approved_count,
    sum(amount) as trans_total_amount,
    coalesce(sum(amount) filter ( where state='approved'), 0) as approved_total_amount
from
    Transactions
group by month, country



select 
    to_char(trans_date, 'YYYY-MM') as month,
    country,
    count(*) as trans_count,
    sum(case when state='approved' then 1 else 0 end) as approved_count,
    sum(amount) as trans_total_amount,
    sum(case when state ='approved' then amount else 0 end) as approved_total_amount
from transactions
group by month, country

/*
Snowflake CTEs (Common Table Expressions) can increase cost if misused — 
but in some cases (like this one), they can actually help performance or readability without impacting cost much.

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
    count(product) as num_sold,
    string_agg(product, ',' order by product) as products
from (
    select distinct sell_date, product from activities
)
group by sell_date
order by sell_date


select
    sell_date,
    count(distinct product) as num_sold,
    string_agg(distinct product, ',' order by product) as products
from Activities
group by sell_date

/*
Most Efficient Version for Snowflake (Recommended)

If the dataset is large, go one step further with a temporary table or CTE to materialize the deduplicated data first — this helps Snowflake optimize better, especially when working with very large or frequently queried datasets.
*/

with distinct_activities as (
    select distinct sell_date, product
    from activities
)
select
    sell_date,
    count(*) as num_sold,
    string_agg(product, ',' order by product) as products
from distinct_activities
group by sell_date

/*
Why this is best:
- The DISTINCT is applied just once and efficiently.
- COUNT(*) is cheaper than COUNT(DISTINCT ...) now, because you've already deduplicated.
- Snowflake can parallelize the CTE nicely.
*/
```

[1321. Restaurant Growth](https://leetcode.com/problems/restaurant-growth/description/)


```sql

-- Solution 1

with daily_amount as (
    select
        visited_on,
        sum(amount) as daily_spend
    from customer
    group by visited_on
),
moving_average as (
    select
        visited_on,
        sum(daily_spend) over (rows between 6 preceding and current row ) as amount,
        round(avg(daily_spend) over (order by visited_on rows between 6 preceding and current row), 2) as average_amount
    from daily_amount
)
select *
from moving_average
where visited_on >= (
    select min(visited_on) + interval '6 days'
    from daily_amount
)
order by visited_on;


-- Solution 2


with daily_amount as (
    select
        visited_on,
        sum(amount) as daily_spend
    from customer
    group by visited_on
    order by visited_on
)
select
    visited_on,
    sum(daily_spend) over (rows between 6 preceding and current row) as amount,
    round( avg(daily_spend) over (order by visited_on rows between 6 preceding and current row) , 2) as average_amount
from
    daily_amount
offset 6 -- skips the first six rows of the result*

/*
- in a seven day moving average the first six days won't have enough data to calculate a full seven day average
- we set OFFSET 6 to skip incomplete windows in a moving average calculation
*/

```
[602. Friend Requests II: Who Has the Most Friends](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/)

```sql

with ra as (
    select
        requester_id as id,
        count(accepter_id) as friends
    from RequestAccepted
    group by requester_id
),
ar as (
    select
        accepter_id as id,
        count(requester_id) as friends
    from RequestAccepted
    group by accepter_id
),
raw_friends as (
select *
from ar
union all
select *
from ra
)
select
    id,
    sum(friends) as num
from raw_friends
group by id
order by num desc, id
limit 1

```

[1164. Product Price at a Given Date](https://leetcode.com/problems/product-price-at-a-given-date/description/)

```sql

-- Solution 1

with latest_before as (
    select
        product_id,
        new_price,
        row_number() over (
            partition by product_id
            order by change_date desc
        ) as rn
    from products
    where change_date <= '2019-08-16'
)
select
    p.product_id,
    coalesce(l.new_price, 10) as price
from ( -- all products
    select distinct product_id
    from products
    ) as p
left join latest_before as l
on p.product_id = l.product_id and l.rn = 1
order by p.product_id;


-- Solution 2

select
    distinct product_id,
    10 as price
from products
group by product_id
having min(change_date) > '2019-08-16'
union
select
    product_id,
    new_price as price
from products
where
    (product_id, change_date) in (
        select
            product_id,
            max(change_date)
        from
            products
        where change_date <= '2019-08-16'
        group by product_id
    )
```






# SQLZoo Tutorial

## [SELECT within SELECT](https://www.sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial): Using nested SELECT
```sql
/*
List each country name where the population is larger than that of 'Russia'.

This select with select only works if we only use a single value whihin the internal select statement,
here - population. So, you cannot ask for population and area in the internal select statement.
You also cannot ask to check for more than one row with the WHERE using LIKE. Only a single row should be returned
from the subquery. Also, the query will return an error if there is an option that returns zero values.
Brackets are mandatory in this statement.
*/

select name from world
where population >
(select population from world
    where name = 'Russia')
```

```sql
-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.

select name
from world
where continent='Europe' and gdp/population > (
    select gdp/population
    from world
    where name='United Kingdom'
)
```

```sql
/*
List the name and continent of countries in the continents containing either Argentina or Australia.
Order by name of the country.
*/

select name, continent
from world
where continent in (
    select continent from world
    where name in ('Argentina', 'Australia')
)
```

```sql
-- Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population.

select name, population
from world
where
    population > (select population from world where name='United Kingdom') and
    population < (select population from world where name='Germany') 
```


```sql
/*
Percentages of Germany
Germany (population roughly 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.

Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
*/

select
    name,
    concat(
        round(population / (select population from world where name='Germany') * 100),
    '%' ) as percentage
from world
where continent='Europe'

select name
from world
where continent!='Europe' and gdp > (select gdp from world where continent='Europe')

```

```sql

/*
Which countries have a GDP greater than every country in Europe?
[Give the name only.] (Some countries may have NULL gdp values) 
*/

select name
from world
where gdp > (
    select
        max(gdp) from world where continent = 'Europe')

```


```sql

/*

Largest in each continent
Find the largest country (by area) in each continent, show the continent, the name and the area.

Correlated or Synchronized sub-query

A correlated subquery works like a nested loop: the subquery only has access to
rows related to a single record at a time in the outer query.
The technique relies on table aliases to identify two different uses of the same table,
one in the outer query and the other in the subquery.
One way to interpret the line in the WHERE clause that references the two table is “
… where the correlated values are the same”.

In the example provided, you would say “select the country details from world where the population
is greater than or equal to the population of all countries where the continent is the same”.

Find the largest country (by area) in each continent, show the continent,
the name and the area: The above example is known as a correlated or synchronized sub-query. 
*/

select continent, name, area from world x
where area >= all
    (select area from world y
        where y.continent=x.continent
    )


/*
Query that does not use a correlated sub-query and more cost-efficient in Snowflake.
Uses a single scan + aggregation (MAX with GROUP BY).
Very efficient in Snowflake, because:
    Grouping and aggregation are optimized.
    Subquery is independent, can run in parallel.

*/

select continent, name, area
from world
where (continent, area) in (
    select continent, max(area)
    from world
    group by continent
)

```

```sql

/*
List each continent and the country that comes first alphabetically within that continent using a correlated subquery
*/

select continent, name
from world x
where name = (
    select min(name)
    from world y
    where y.continent=x.continent
)

select x.continent, x.name
from world x
where name = (
    select min(name)
    from world
    where continent = x.continent
)

```


```sql

/*
Find the continents where all countries have a population <= 25000000.
Then find the names of the countries associated with these continents.
Show name, continent and population. 
*/

with continent_select as (
    select continent
    from world
    group by continent
    having max(population) <= 25000000
)
select w.name, w.continent, w.population
from world w
join continent_select on w.continent=continent_select.continent
        
```


```sql

/*
Some countries have populations more than three times that of all of their neighbours (in the same continent).
Give the countries and continents.

Give me the countries where there is no neighbor in the same continent
that has at least one-third of their population.
*/

select x.name, x.continent
from world x
where not exists (

    select y.name
    from world y
    where y.continent=x.continent
    and y.name!=x.name
    and x.population <= 3*y.population

)

```


## [Nested SELECT Quiz](https://www.sqlzoo.net/wiki/Nested_SELECT_Quiz)


```sql

/*
1. Select the code that shows the name, region and population of the smallest country in each region 
*/


SELECT
    region, name, population
    FROM bbc x WHERE population <= ALL (SELECT population FROM bbc y WHERE y.region=x.region AND population>0)

```

```sql
/*
2. Select the code that shows the countries belonging to regions with all populations over 50000:
*/

select name, region, population
from bbc x
where 50000 < ALL (
  select population
  from bbc y
  where x.region = y.region AND y.population > 0
);
 
```

```sql

/*
Select the result that would be obtained from the following code: 

SELECT name FROM bbc
 WHERE population >
       (SELECT population
          FROM bbc
         WHERE name='United Kingdom')
   AND region IN
       (SELECT region
          FROM bbc
         WHERE name = 'United Kingdom')

France
Germany
Russia
Turkey
*/
        
```

```sql

/*
Select the code that would show the countries with a greater GDP than any country in Africa
(some countries may have NULL gdp values). 
*/

SELECT name FROM bbc
 WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa')
        
```

```sql

/*
Select the code that shows the countries with population smaller than Russia but bigger than Denmark 
*/

SELECT name FROM bbc
 WHERE population < (SELECT population FROM bbc WHERE name='Russia')
   AND population > (SELECT population FROM bbc WHERE name='Denmark')
        
```

```sql

/*
Select the result that would be obtained from the following code

Bangladesh
India
Pakistan
*/

SELECT name FROM bbc
 WHERE population > ALL
       (SELECT MAX(population)
          FROM bbc
         WHERE region = 'Europe')
   AND region = 'South Asia'

```

## [Using Null](https://www.sqlzoo.net/wiki/Using_Null)

```sql
/*
List the teachers who have NULL for their department. 
*/

SELECT name
FROM teacher
WHERE dept IS NULL;
```

```sql
/*
Note the INNER JOIN misses the teachers with no department and the departments with no teacher. 
*/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
```

```sql
/*
Use a different JOIN so that all teachers are listed. 
*/

SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
```

```sql
/*
Use a different JOIN so that all departments are listed
*/
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
```

```sql
/*
Use COALESCE to print the mobile number. Use the number '07986 444 2266' 
if there is no number given. Show teacher name and mobile number or '07986 444 2266'
*/
SELECT name, COALESCE(mobile, '07986 444 2266')
 FROM teacher   
```

```sql
/*
Use the COALESCE function and a LEFT JOIN to print the teacher name and department name.
Use the string 'None' where there is no department. 
*/
SELECT teacher.name, coalesce(dept.name, 'None')
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
```

```sql
/*
Use COUNT to show the number of teachers and the number of mobile phones. 
*/
select count(name), count(mobile)
from teacher   
```

```sql
/*
Use COUNT and GROUP BY dept.name to show each department and the number of staff.
Use a RIGHT JOIN to ensure that the Engineering department is listed. 
*/
SELECT dept.name, count(teacher.name)
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
group by dept.name  
```

```sql
/*
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2 and 'Art' otherwise. 
*/
SELECT name, case when dept in (1,2) then 'Sci' else 'Art' end
 FROM teacher
   
```

```sql
/*
Use CASE to show the name of each teacher followed by 'Sci' if the teacher is in dept 1 or 2,
show 'Art' if the teacher's dept is 3 and 'None' otherwise. 
*/
SELECT
 name,
 CASE
    WHEN dept IN (1,2) THEN 'Sci'
    WHEN dept = 3 THEN 'Art'
 ELSE 'None' END
FROM teacher

```





```sql
/*

*/
 
```




















```sql
/*

*/
    
```













```sql

/*

*/




        
```




## 1. Understand the distribution of values in the data set

- find the most frequent values for a specific column
- find the most common product categories
- this query returns the product categories and their respective frequencies:
    ```sql
    select category, count(*) as cnt from orders group by category order by count(*) desc
    ```
- also try <code>GROUP BY 1 ORDER BY 2</code>


[585. Investments in 2016](https://leetcode.com/problems/investments-in-2016/description/)

```sql
select round(sum(tiv_2016)::decimal,2) as tiv_2016
from Insurance
where tiv_2015 in
    (select tiv_2015
    from insurance
    group by tiv_2015
    having count(*) > 1)
and (lat, lon) in (
    select distinct lat, lon
    from insurance
    group by lat, lon
    having count(*) = 1
)
```

[1327. List the Products Ordered in a Period](https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/)

```sql
with total_feb_units as (
    select
        product_id,
        sum(unit) as total_units
    from orders
    where to_char(order_date, 'YYYY-MM') = '2020-02'
    -- where order_date >= '2020-02-01' and order_date < '2020-03-01' 
    group by product_id
    having sum(unit) >= 100
)
select
    p.product_name,
    t.total_units as unit
from total_feb_units t 
join products p
on p.product_id = t.product_id;


select
    product_name,
    sum(unit) as unit
from orders o
inner join products
using(product_id)
where to_char(order_date, 'YYYY-MM') = '2020-02'
group by product_id, product_name
having sum(unit) >= 100;
```

[176. Second Highest Salary](https://leetcode.com/problems/second-highest-salary/description/)

```sql

-- 1. MAX(salary) WHERE salary < (SELECT MAX(salary))

select
    max(salary) as SecondHighestSalary
from Employee
where salary < 
    (select max(salary) from Employee);


with highest_salary as (
    select
        max(salary) as max_salary
    from Employee
)
select max(salary) as SecondHighestSalary
from Employee
where salary <
    (select max_salary from highest_salary);


select max(salary) as SecondHighestSalary
from (
    select max(salary) as salary
    from employee
    group by salary
    order by salary desc
    offset 1
);

-- 2. LIMIT + MIN + CASE
select
    case
        when count(salary) > 1
        then min(salary) 
        else null 
    end as SecondHighestSalary
from
    (select distinct salary
    from Employee
    order by salary desc
    limit 2);


select
    case
        when count(*) > 1 then min(salary)
        else null
    end as SecondHighestSalary
from
    (select distinct salary
    from Employee
    order by salary desc
    limit 2);


-- 3. ROW_NUMBER() 

select salary as SecondHighestSalary
from (
    select
        salary,
        row_number() over (order by salary desc) as rn
    from (
        select distinct salary from Employee
        ) as distinct_salaries
    ) as ranked_orders
where rn = 2

union all

select null
    where not exists (
        select 1
        from (
            select distinct salary from Employee
        ) as temp
        offset 1
);

/*
| Step | Description                                                                                  |
| ---- | -------------------------------------------------------------------------------------------- |
| 1️  | **FROM (SELECT DISTINCT salary FROM Employee)** — Get unique salaries                        |
| 2️  | **OFFSET 1** — Skip the first row (highest salary), start from the second one                |
| 3️  | **SELECT 1 FROM ...** — Try to fetch something starting from the second row                  |
| 4️  | **NOT EXISTS (...)** — Check if step 3 returned anything.                                    |
| 5️  | **WHERE NOT EXISTS (...)** — If no rows were returned in step 3, this condition is TRUE      |
| 6️  | **SELECT NULL** — Only executed if `WHERE` condition is TRUE, i.e., **no second row exists** |
*/

-- 4. DENSE_RANK()
-- slower than ROW_NUMBER() with large data
-- perfect when salaries can be duplicated

select
    max(salary) as SecondHighestSalary
from (
    select salary, dense_rank() over (order by salary desc) as rnk
    from Employee
) where rnk = 2;


-- 5. MAX with < and Nested MAX queries — clear, but does 2 subqueries

select max(salary) as SecondHighestSalary
from Employee
where salary < (
    select max(salary) from Employee);


select salary as SecondHighestSalary
from (
    select max(salary) as salary
    from Employee
    where salary < (select max(salary) from Employee)
);


-- 6. NOT IN
/*
- a scalar subquery returns exactly one value - a single row and column ->
- as a result it can be used as a constant in expressions and filters:
- select max(salary) from employee; use it in:
- where salary < (select max(salary) from employee)
- the query below finds the max salary that is not the highest - the second highest
- Postgres handles NOT IN (SELECT ...) correctly as long the subquery does not include NULL
- And since MAX(salary) only returns a single non-null value or nothing if the table is empty, it's safe to us.
- If there is only on distinct salary, e.g.: all salaries are 100, the subquery returns 100 and 
- WHERE salary NOT IN (100) will filter out all rows
- as a result, MAX(salary) from the outer subquery is computed over no rows which will result in NULL
- meaning that there is no second highest salary
- MAX(salary) never returns NULL unless the table is empty
*/

select max(salary) as SecondHighestSalary
from Employee
where salary not in (
    select max(salary) from Employee
);


-- 7. RANK() — less efficient due to gaps

/*
- need to use DISTINCT: since RANK() counts row positions, duplicate salaries will shift ranks even though they are the sale value
- to find the second highest distinct salary, we need to eliminate duplicates first when using RANK 
*/

select max(salary) as SecondHighestSalary
from (
    select
        salary,
        rank() over (order by salary desc) as rnk
    from (select distinct salary from employee)
)
where rnk = 2;

/* 8. Self-join — correct but costly

- simple way to avoid window funcions
- can be inefficient for large datasets: it's a self-join, meaning time complexity is O(n²) in worst case
- PostgreSQL may need to compare many salary pairs
*/

select max(e2.salary) as SecondHighestSalary
from employee e1
join employee e2
on e2.salary < e1.salary; 


/* 9. Correlated subquery — readable, but performance can degrade
- correlated subquery - subquery that uses values from the outer query and runs once per row
- correlated subquery is a well- established concept in SQL development
- correlated subqueries are powerful but slower for larger datasets because they are re-evaluated once per row
- the query below counts how many salaries are greater than each one and selecting the one where exactly one is greater
- this query has a terrible runtime - very slow
*/

-- main query
select distinct salary as SecondHighestSalary
from employee e1
where 1 = (
    -- the subquery below counts how many distinct salaries are greater than the current e1.salary
    select count(distinct salary)
    from employee e2
    where e2.salary > e1.salary
)

union all

select null as SecondHighestSalary
where not exists (
    select 1
    from (
        select distinct salary
        from employee
        offset 1
    )
)

/*
PostgreSQL generally executes SQL in this order:
    FROM
    WHERE
    GROUP BY
    HAVING
    SELECT
    DISTINCT
    ORDER BY
    LIMIT / OFFSET
    UNION / UNION ALL
*/

-- 10. GROUP BY + LIMIT combo — works, but has more operations than needed

select salary as SecondHighestSalary
from (
    select distinct salary
    from employee
    order by salary desc
    limit 1 offset 1
)

union all

select null as SecondHighestSalary
where not exists (
    select 1
    from (
        select distinct salary
        from employee
        offset 1
    )
);

```


[570. Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/)

```sql
/*
Write a solution to find managers with at least five direct reports:
- each employee has a managerId referencing another employee's id >>> use self-join
- alias e for the employee and m for the manager - this way each row will contain 
the manager name and the name of manager's report
- to count the number of employees per manager - group by both - m.name and e.managerId;
- group by both fields because m.name might not be unique - two people might share the same name >
 so e.managerId ensures accurate grouping on the manager's unique ID.
- use HAVING to filter aggregates after grouping:
- find those groups where the manager has 5 or more direct reports
- HAVING is used to filter aggregate functions like count()
*/

-- 1. JOIN, GROUP BY and HAVING
select
    m.name
from
    Employee e
join Employee m
on m.id = e.managerId
group by m.name, e.managerId
having count(e.managerId) >= 5;


-- 2. GROUP BY managerId and join back

select m.name
from (
    select managerId
    from employee
    group by managerId
    having count(*) >= 5
) as mgr
join employee m on m.id = mgr.managerId;


-- 3. Use CTE: functionally same as prev query, but using a CTE improves clarity for large/complex queries

with mgr_count as (
    select managerId
    from employee
    group by managerId
    having count(*) >= 5
)
select m.name
from mgr_count
join employee m
on m.id = mgr_count.managerId;


-- 4. Use a Subquery in the WHERE clause

select name
from employee
where id in (
    select managerId
    from employee
    group by managerId
    having count(*) >= 5
);


-- 5. EXISTS with correlated subquery

/* Order Execution:
    1. Scan employee as m
    2. For each m, run subquery:
        Filter employees e where e.managerId = m.id
        Group by managerId
        Check if COUNT(*) >= 5
    3. If subquery returns a row, EXISTS is true
        - If yes, the subquery returns a row (with just a 1, doesn’t matter what),
        which makes EXISTS true.
        - If not, returns no rows, and EXISTS is false.
    4. If EXISTS is true, output m.name
*/

select m.name
from employee m
where exists (
    select 1
    from employee e
    where m.id = e.managerId
    group by e.managerId
    having count(*) >= 5
);

-- 6. Derived table with COUNT + JOIN (slight variation)
    -- avoid filtering in HAVING

select m.name
from employee m
join (
    select managerId, count(*) as emp_count
    from employee
    group by managerId
) as nr_emps
on m.id = nr_emps.managerId
where nr_emps.emp_count >= 5;

```


[1045. Customers Who Bought All Products](https://leetcode.com/problems/customers-who-bought-all-products/description/)

```sql
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(product_key) from product)
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



[584. Find Customer Referee](https://leetcode.com/problems/find-customer-referee/description/)

In SQL, the != (or <>) operator does not compare NULL values because NULL represents an unknown value. In SQL, any comparison with NULL results in NULL (which is treated as unknown or false in a WHERE clause).

If referee_id is NULL, the condition becomes NULL != 2, which results in NULL.
Since SQL ignores NULL in WHERE conditions (it is neither TRUE nor FALSE), rows where referee_id is NULL are not included in the result.

To handle NULL values in comparisons, use IS NULL or IS NOT NULL explicitly.

```sql
select name
from Customer
where referee_id != 2 or referee_id is null;

select name
from customer
where referee_id is null or referee_id != 2;

```
