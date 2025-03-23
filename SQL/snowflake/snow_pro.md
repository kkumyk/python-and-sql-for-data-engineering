# Snowflake – The Complete Masterclass Course

## Interface Intro

### Worksheets
Projects > Worksheets - most of the time will be spent here.

#### SQL Worksheets Tips
1. Before running, you'll need to set the context. Each worksheet has a context, that consists of
    - Role
    - Warehouse
    - Database & Schema
2. You can run a single query or multiple queries. To run a single query, place your cursor in the query editor and select the Run button. To run the entire worksheet, select 'Run All' from the dropdown next to the Run button.

### Snowflake architecture
- Cloud Services:
    - Brain of the system
- Query Processing:
    - Muscle of the system - performs MMP (Massive Parallel Processing)
- Storage:
    - Hybrid Columnal Storage - saved in blobs

- We use the virtual warehouses as compute resources to process queries. True or false? True. In Snowflake, virtual warehouses act as compute resources to process queries. They handle tasks like querying, loading, and transforming data. Each virtual warehouse provides scalable compute power, and you can resize or suspend them as needed to optimize performance and costs.

- A virtual warehouse of the size M has ... how many servers running to process queries? A Medium (M) virtual warehouse has 4 servers (nodes) running to process queries.

Warehouse Size	Number of Servers (Nodes)

X-Small (XS)	1

Small (S)	    2

Medium (M)	    4

Large (L)	    8

X-Large (XL)	16

2X-Large (2XL)	32

3X-Large (3XL)	64

4X-Large (4XL)	128

### Setting Up Warehouse

- Warehouses provide the capacity to execute the workload.
- Warehouses can be created via UI or SQL command:

```sql
create or replace warehouse second_wh
with
warehouse_size = xsmall
auto_suspend = 300
scaling_policy = 'Economy'
min_cluster_count = 1
max_cluster_count = 3
initially_suspended = true
comment = 'this is our second warehouse'
```