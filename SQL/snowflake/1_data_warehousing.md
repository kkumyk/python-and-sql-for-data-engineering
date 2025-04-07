# Badge 1: Data Warehousing Workshop

## Organizing Database Objects
- Databases are used to group datasets (tables) together. A second-level organizational grouping, within a database, is called a schema. 
- Every time you create a database, Snowflake will automatically create two schemas for you.
- The INFORMATION_SCHEMA schema holds a collection of views. It cannot be deleted (dropped), renamed, or moved.
- The PUBLIC schema is created empty and you can fill it with tables, views and other things over time. It can be dropped, renamed, or moved at any time.  

- Snowflake warehouse is not a storage, it is a computing power.
- A warehouse is the machine that crunches the data.

- ROLE and WAREHOUSE Drop Menu Values are REQUIRED.
    - You cannot run a select statement without a warehouse to provide the compute power and you cannot run a select statement without a ROLE to define whether that data is accessible to the person* trying to run it. There are some minor exceptions, but for now, accept this as a rule.  

    * in this case the "person" is a USER with a current ROLE.  

- DATABASE and SCHEMA Drop Menu Values are SUGGESTED STARTING POINTS
    - The database and schema settings in a worksheet are just "home bases", or suggested starting places that tell Snowflake where to look for tables, views and other objects. These droplists exist so that you can simplify code and leave database and schema names out of your statements if you want to. Just because a Database is set in the menu, doesn't mean you can't run selects on other databases in the worksheet. 

### Snowflake Warehouses
- Within Snowflake, the data are the goods, and the servers are the workers.
- Snowflake calls them storage and compute.
- In Snowflake, Warehouses are "workforces" -- they are used to perform the processing of data. 
- When you create a Warehouse in Snowflake, you are defining a "workforce."
- The workforce of each warehouse is a team. A small warehouse has a small team, but just one team. An extra-large warehouse has a large team, but just one team.

#### Costs
- XS warehouses cost less than five dollars to run for an hour.
- The 6XL, costs over 500 times that amount, because it's like running 512 XS warehouses at one time.
- 400 credits: you can run an XS for 400 hours or you can run a 6XL for less than one hour.


### Clusters and Servers
- Snowflake Warehouse Sizes like eXtra-Small, Small, Medium, etc. all have one cluster. A small warehouse has one cluster made up of just a few servers. A larger warehouse has one cluster, made up of more servers: WAREHOUSE > CLUSTER > SERVERS
- Changing the size of warehouse changes the number of servers in the cluster. 
- Changing the size of an existing warehouse is called scaling up or scaling down.

### Scaling In and Out

- If multi-cluster/elastic warehousing is available (Enterprise edition or above) a warehouse is capable of scaling out in times of increased demand.  (Adding temporary teams, made up of a collection of temporary workers). 
- If multi-cluster scaling out takes place, clusters are added for the period of demand and then clusters are removed (snap back) when demand decreases. (Removing temporary teams). 
- The number of servers in the original cluster dictates the number of servers in each cluster during periods where the warehouse scales out by adding clusters. 
- Snapping Back = Scaling In

##  Using the INFORMATION_SCHEMA to Query Metadata
- The word "metadata" means "data about data." 
- The INFORMATION_SCHEMA that gets created in every Snowflake Database holds metadata.
- In other words, it holds statistics about the number of databases, schemas, tables, views and more. 
- It also holds data about the object names and other object details. Notice that in all the queries above, we are using the INFORMATION_SCHEMA to double-check our work and make sure we completed the tasks correctly.

