# Working with Date and Time

## DATE_TRUNC() and CURRENT_DATE

Write a query to get the total sales per month from the sales table for the last 6 months.

```sql
SELECT DATE_TRUNC('month', sate_date) AS month, SUM(amount) AS total_sales
FROM sales
WHERE sale_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY month
ORDER BY month;
```
DATE_TRUNC('month', sale_date):
- truncates the sale_date to the first day of the month (2024-11-15 becomes 2024-11-01)

CURRENT_DATE:
- returns the current date (without the time portion)
- it’s used to get today's date for comparison in the WHERE clause

INTERVAL '6 months': 
- used to subtract 6 months from the current date
- this will filter the data to only include sales from the past 6 months

