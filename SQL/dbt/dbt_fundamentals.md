
# dbt Fundamentals | Course Notes

## Models

### What are Models?
- SQL select statements inside of your dbt project
- each represent a logic that will transform raw data into a table
- each model will map with either a table or a view in your data warehouse; there are some exceptions though

```bash
dbt run # build a dbt project
dbt run --select model_name # to run a single model
```
- by default, dbt creates a view not a table
- to create a table we need to add configuration at the top of our dbt model file:

```sql
{{
    config(
        materialized='table'
    )
}}
```