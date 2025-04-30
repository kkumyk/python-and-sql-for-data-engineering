# Window Functions
- analyze rows without groupping
- don't reduce the number of rows, don't collapse rows into a single result
- enchance each row with additional context; each row retails its identity
- the function gives running, cummulative result
- performs a calculation across a set of table rows that are related to the current row
- each row "sees" a window of other rows and returns a value per row
- return a value for every row
- you can combine aggregates and row-level data without subqueries and joins

## Common Window Functions

- ROW_NUMBER() – assigns a unique row number per partition.
- RANK(), DENSE_RANK() – useful for ordering and deduplicating.
- SUM(), AVG(), COUNT() – can do running totals, rolling averages, etc.
- LAG(), LEAD() – access values from previous or next rows.
- FIRST_VALUE(), LAST_VALUE() – get the first or last value in a window

##  The OVER Clause
Every window function uses OVER, and it defines:
- PARTITION BY – like GROUP BY, it resets the window per group.
- ORDER BY – sets the order within the window (e.g. for ranking or cumulative sums).
- ROWS BETWEEN – fine-grained control over which rows are included (e.g., rolling windows).

## Use Cases
- Running totals
- Percentiles and rankings
- Comparing current row to previous/next