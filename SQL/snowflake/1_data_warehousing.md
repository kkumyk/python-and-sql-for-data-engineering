# Badge 1: Data Warehousing Workshop

## Organizing Database Objects
- Databases are used to group datasets (tables) together. A second-level organizational grouping, within a database, is called a schema. 
- Every time you create a database, Snowflake will automatically create two schemas for you.
- The INFORMATION_SCHEMA schema holds a collection of views. It cannot be deleted (dropped), renamed, or moved.
- The PUBLIC schema is created empty and you can fill it with tables, views and other things over time. It can be dropped, renamed, or moved at any time.  