
# dbt Fundamentals | Course Notes

## Models

### What are Models?
- .sql files that live in the models folder
- SQL select statements inside of your dbt project
- written as select statements - there is no DDL/DML that needs to be written around this
- each represent a logic that will transform raw data into a table
- each model will map with either a table or a view in your data warehouse; there are some exceptions though
- When dbt run is executing, dbt is wrapping the select statement in the correct DDL/DML to build that model as a table/view. If that model already exists in the data warehouse, dbt will automatically drop that table or view before building the new database object.
- The DDL/DML that is being run to build each model can be viewed in the logs through the cloud interface or the target folder.
- When dbt run is executed, dbt will automatically run every model in the models directory.

```bash
dbt run # build a dbt project; materialize the models into the data warehouse
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
#### Types of Models | Naming Conventions
Sources (src) refer to the raw table data that have been built in the warehouse through a loading process.

Staging (stg) refers to models that are built directly on top of sources. These have a one-to-one relationship with sources tables. These are used for very light transformations that shape the data into what you want it to be. These models are used to clean and standardize the data before transforming data downstream. Note: These are typically materialized as views.
- should be built one to one with the undelying data source
- light touch computations, like rename columns, conversion of a particular number

Intermediate (int) refers to any models that exist between final fact and dimension tables. These should be built on staging models rather than directly on sources to leverage the data cleaning that was done in staging.
- exist b/t staging and the rest of our final tables
- should always ref staging models and should not directly red source tables

Fact (fct) refers to any data that represents something that occurred or is occurring. Examples include sessions, transactions, orders, stories, votes. These are typically skinny, long tables.
- represent things that are occuring or already occured
- skinny tables
- orders, events, clicks - things that are not going to change much

Dimension (dim) refers to data that represents a person, place or thing.

- customers, products, candidates, buildings, employees.
- won't going to change significantly

##### Further Reading Sources
[Stakeholder-friendly model names: Model naming conventions that give context](https://docs.getdbt.com/blog/stakeholder-friendly-model-names)

### Modularity
- Modularity is the degree to which a system's components may be separated and recombined, often with the benefit of flexibility and variety in use.
- E.g.: For example, we can stage the raw customers and orders data to shape it into what we want it to look like. Then we can build a model that references both of these to build the final dim_customers model.
- Thinking modularly is how software engineers build applications. Models can be leveraged to apply this modular thinking to analytics engineering.

### ref Macro
- The ref function allows us to build dependencies between models in a flexible way that can be shared in a common code base. The ref function compiles to the name of the database object as it has been created on the most recent execution of dbt run in the particular development environment. This is determined by the environment configuration that was set up when the project was created.
- The ref function also builds a lineage graph like the one shown below. dbt is able to determine dependencies between models and takes those into account to build models in the correct order.

### Modeling History
- Multiple modeling paradigms since the advent of database technology; many of these are classified as normalized modeling
- Nonrmalized modeling techniques were designed when storage was expensive and computational power was not as affordable as it is today.
- With a modern cloud-based data warehouse, we can approach analytics differently in an agile or ad hoc modeling technique. This is often referred to as denormalized modeling.
- dbt can build your data warehouse into any of these schemas.
- dbt is a tool for how to build these rather than enforcing what to build.








<!--

https://www.reddit.com/r/snowflake/comments/1bmdlsv/why_is_dbt_so_popular_with_snowflake_seems_like/?rdt=60846
https://www.linkedin.com/posts/ephraim-ebong_dataengineering-snowflake-apacheairflow-activity-7303124610881847297-u3UJ
https://www.linkedin.com/search/results/all/?keywords=dbt%20snowflake&origin=GLOBAL_SEARCH_HEADER&page=3&sid=RbK
https://www.linkedin.com/pulse/end-to-end-data-pipeline-snowflake-airflow-dbt-nguy%25E1%25BB%2585n-tu%25E1%25BA%25A5n-d%25C6%25B0%25C6%25A1ng-8vjzc/

 -->