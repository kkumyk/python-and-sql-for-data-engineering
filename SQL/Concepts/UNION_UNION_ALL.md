# UNION and UNION ALL

- are used to combine results from two or more SELECT statements;
- unlike joins, they stack the results vertically;
- each select statement used must return the same number of columns with compatible data types, also in the same order;
- often used to combine data fro similar tables like current and archived data;
- ALL UNION is generally faster than UNION as it doesn't need to check for duplicates;

## UNION
- removes duplicate rows, performing a distinct merge of results from the two queries;
```sql
SELECT product_id, product_name
FROM products
UNION
SELECT testproduct_id, product_name
FROM testproducts
ORDER BY product_id;

/*
 product_id |           product_name
------------+----------------------------------
          1 | Johns Fruit Cake
          1 | Chais
          2 | Marys Healthy Mix
          2 | Chang
          3 | Peters Scary Stuff
          3 | Aniseed Syrup     */
```
[Query source](https://www.w3schools.com/postgresql/trypostgresql.php?filename=demo_union)
## UNION ALL
- keeps all rows including duplicates;

```sql
SELECT product_id
FROM products
UNION ALL
SELECT testproduct_id
FROM testproducts
ORDER BY product_id;
/*
 product_id
------------
          1
          1
          2
          2
          3
          3 */
```
[Query source](https://www.w3schools.com/postgresql/trypostgresql.php?filename=demo_union_all)