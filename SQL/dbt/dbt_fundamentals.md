
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


### Test Questions
You are working in the dbt Cloud IDE. How do you ensure the model you have created is built in your data platform?

- run dbt run
- it executes the SQL models in your dbt project and materializes them in your data platform


What are two functions of a staging model in dbt?

- a. Perform light transformations on your data set
- b. Connect to upstream sources using the source macro


What are two functions of a marts model in dbt?

- c. Apply business logic for stakeholders
- d. Reference upstream models using the ref macro


You want all models in a folder to be materialized as tables. Where can you accomplish this?
- in the dbt_project.yml file

Which of the following is a benefit of using subdirectories in your models directory?
- a. Subdirectories allow you to configure materializations at the folder level for a collection of models
- Subdirectories in your models directory help organize your dbt project. One of the benefits is that you can configure materializations at the folder level, meaning you can apply the same materialization (e.g., table, view) for all models within that subdirectory. This can help maintain consistency for groups of models.


## Sources

### What are Sources?
- you always start with raw data
- sources represent the raw data that is loaded into the data warehouse
- best way to ref sources with <code>source</code> function which enables:
    - configure multiple tables from a single source
    - freshness thresholds can be set in the YML file where sources are configured
    - for each table, the keys loaded_at_field and freshness must be configured:
    ```yml
    version: 2

    sources:
    - name: jaffle_shop
        database: raw
        schema: jaffle_shop
        tables:
        - name: orders
            loaded_at_field: _etl_loaded_at
            freshness:
            warn_after: {count: 12, period: hour}
            error_after: {count: 24, period: hour}
    ```
    - use <code>dbt source freshness</code> to check the freshness of raw table.
    - the Lineage Graph will represent the sources in green

### Tests
- data tests can be applied on models or directly on data sources
- data tests - assertions
- data tests constructed in development; they help validate models
- data tests are in the same code base as your modles
- two types of dbt tests:
    - singular
        - Singular tests are data tests defined by writing specific SQL queries that return records which fail the test conditions. These tests are referred to as "singular" because they are one-off assertions that are uniquely designed for a single purpose or specific scenario within the data models.
        - test specific models with custom SQL
    - (four built-in) generic:
        - Generic tests are a way to validate your data models and ensure data quality. These tests are predefined and can be applied to any column of your data models to check for common data issues. They are written in YAML files.
        - unique - use on primary keys
        - not_null - use on primary keys
        - relationshipts - asserts that every value in a column exists in the column of another table to maintain referential integrety
        - accepted_values - asserts that every value in the column exist in a predefined list
    - basic tests
    - can be applied broadly thoughout the project

#### dbt Commands

- Execute <code>dbt test</code> to run all generic and singular tests in your project.
- Execute <code>dbt test --select test_type:generic</code> to run only generic tests in your project.
- Execute <code>dbt test --select test_type:singular</code> to run only singular tests in your project.

- To run tests on one source (and all of its tables):
```bash
dbt test --select source:jaffle_shop`
```
- And, to run tests on one source table only:
```bash
dbt test --select source:jaffle_shop.orders
```





















<!--
https://www.getdbt.com/certifications/analytics-engineer-certification-exam
https://quizlet.com/489070274/dbt-certification-practice-exam-questions-flash-cards/
https://www.qanalabs.com/pages/free-dbt-practice-exam
https://www.getdbt.com/dbt-certification
https://www.getdbt.com/dbt-assets/certifications/dbt-certificate-study-guide
https://discourse.getdbt.com/t/dbt-analytics-engineering-exam-preparation/13371
https://medium.com/@nishadpatkar7/data-build-tool-dbt-interview-questions-and-answers-107f6799c7a3



https://www.reddit.com/r/snowflake/comments/1bmdlsv/why_is_dbt_so_popular_with_snowflake_seems_like/?rdt=60846
https://www.linkedin.com/posts/ephraim-ebong_dataengineering-snowflake-apacheairflow-activity-7303124610881847297-u3UJ
https://www.linkedin.com/search/results/all/?keywords=dbt%20snowflake&origin=GLOBAL_SEARCH_HEADER&page=3&sid=RbK
https://www.linkedin.com/pulse/end-to-end-data-pipeline-snowflake-airflow-dbt-nguy%25E1%25BB%2585n-tu%25E1%25BA%25A5n-d%25C6%25B0%25C6%25A1ng-8vjzc/


https://dbtips.substack.com/p/running-dbt-with-airflow

 -->