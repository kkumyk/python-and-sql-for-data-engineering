## 1. Understand the distribution of values in the data set

- find the most frequent values for a specific column
- find the most common product categories
- this query returns the product categories and their respective frequencies:
    ```sql
    select category, count(*) as cnt from orders group by category order by count(*) desc
    ```
- also try <code>GROUP BY 1 ORDER BY 2</code>

