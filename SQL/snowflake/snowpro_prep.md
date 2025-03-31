<!-- 

find in google search three most relevant snowprocore exam questions from the text below and suggested to which of the 6 sections to put them into. Also, provide the link to the snowflake documentation that confirms the right answers to these questions 

1. Snowflake AI Data Cloud Features & Architecture
2. Account Access and Security
3. Performance and Cost Optimization Concepts
4. Data Loading and Unloading
5. Data Transformations
6. Data Protection and Data Sharing

 -->


# SnowPro Core Exam Domains




##  1. Snowflake AI Data Cloud Features & Architecture -	(24%)

- What is the expiration period for a file URL used to access unstructured data?
   - The length of time specified in the expiration_time argument
   - Explanation:
      - When generating a pre-signed file URL to access unstructured data in Snowflake, the expiration period is determined by the expiration_time argument. This allows for controlled access to external users or applications for a specified duration.

- What is the expiration period of a Pre-signed URL?
   - Length of time specified in the expiration_time argument.
   - Pre-signed URLs expire after the duration specified during their creation, and this time is defined by the expiration_time argument.

-  A Pre-Signed URL is ideal for:
   - Business intelligence applications or reporting tools that need to display the unstructured file contents.
   - A Pre-Signed URL provides temporary, direct access to a file without requiring authentication or authorization tokens. This makes it ideal for situations where files need to be accessed by external applications like business intelligence tools or reporting systems that display or analyze unstructured data. Unlike scoped URLs or file URLs, pre-signed URLs are often used when ease of access is prioritized, such as for data consumption or visualization without additional login steps.
   - While Pre-Signed URLs can be used in other applications, their primary ideal use case is for easily sharing file content in environments like reporting tools where file contents need to be displayed or processed quickly.
   - Used to download or access files without authenticating into Snowflake or passing an authorization token. Pre-signed URLs are open; any user or application can directly access or download the files. Ideal for business intelligence applications or reporting tools that need to display the unstructured file contents. ([Source](https://docs.snowflake.com/en/user-guide/unstructured-intro))

- How long does a scoped URL remain valid in Snowflake?
   - 24 hours
   - Scoped URL is an encoded URL that permits temporary access to a staged file without granting privileges to the stage.



##  2. Account Access and Security - (18%)


##  3. Performance and Cost Optimization Concepts -	(16%)
- What compute resources does Snowpipe use for loading data?
   - Snowpipe uses Snowflake-supplied compute resources.
   - Unlike bulk data loading, which requires a user-specified warehouse to execute COPY statements, Snowpipe utilizes Snowflake-supplied compute resources for loading data. [doc](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-intro#compute-resources)


##  4. Data Loading and Unloading -	(12%)
 
- How many days is load history for Snowpipe retained?
   - 14 days​
   - Snowflake stores load history for Snowpipe in the metadata of the pipe for 14 days. This information can be retrieved via a REST endpoint, SQL table function, or ACCOUNT_USAGE view.​ [doc](https://docs.snowflake.com/en/user-guide/data-load-snowpipe-intro#load-history)

- How does Snowpipe detect new data files for loading?
   - Snowpipe detects new data files using event notifications for cloud storage, which inform Snowpipe of the arrival of new data files to load.
   - Automated data loads leverage event notifications for cloud storage to inform Snowpipe of the arrival of new data files. Snowpipe polls these event notifications from a queue and loads the new data files into the target table based on the parameters defined in a specified pipe object. [doc source] (https://docs.snowflake.com/en/user-guide/data-load-snowpipe-auto)

- What is the purpose of creating a stage in Snowflake when setting up Snowpipe?
   - A stage in Snowflake serves as a pointer to an external storage location (e.g., AWS S3) or an internal location within Snowflake. It acts as an intermediary storage area where data files are stored before being loaded into Snowflake tables. [doc](https://docs.snowflake.com/en/user-guide/data-load-s3-create-stage)
   - Stages are essential components used for temporarily storing data files during loading and unloading operations. A stage specifies where data files are stored (that is, “staged”) so that the data in the files can be loaded into a table. [doc](https://docs.snowflake.com/en/user-guide/data-load-local-file-system-create-stage)



### Semi-Structured Data

- How will you store JSON data in Snowflake?
   - Using a column of the [VARIANT](https://docs.snowflake.com/en/user-guide/semistructured-considerations) type.
   - Semi-structured data is saved as VARIANT type in Snowflake tables, with a maximum limit size of 16 MB of uncompressed data, and it can be queried using JSON notation. However, in practice, the maximum size is usually smaller due to internal overhead. The maximum size is also dependent on the object being stored.
   - A [VARIANT](https://docs.snowflake.com/en/sql-reference/data-types-semistructured#variant) can store a value of any other type, including OBJECT and ARRAY.



##  5. Data Transformations -	(18%)
##  6. Data Protection and Data Sharing -	(12%)


















<!-- **1. Core Architecture & Compute (Most Important for SnowPro Core Exam)**

 - Snowflake Architecture (DDL, DML, Snowflake Editions, Cloud Providers, Layers, Snowflake SQL Client)

 - Warehouses
    - Scaling Policy
    - Multi-cluster Warehouses and Multi-warehouse Modes
    - Params you can configure
1. Which of the following are valid Snowflake Virtual Warehouse Scaling Policies?
    - Economy and Standard
    - Economy: This policy scales the warehouse in a more cost-efficient way, typically by using fewer resources or by being more conservative in scaling up.

    - Standard: This is the default scaling policy that offers a balance between cost and performance, dynamically scaling the warehouse as needed.
<hr>

 - Resource Monitors

    - Parameters and Types of Actions

 - Cache (Result caching, Query caching, and Warehouse cache)

 - Storage Features

    - Fail Safe

    - Time Travel

    - Zero-Copy Cloning

<hr>

 - Micro-partitions & Clustering Keys

    - Micro-partitioning concept and benefits
    - Use of Clustering keys for performance

1. Snowflake provides a mechanism for its customers to override its natural clustering algorithms. This method is:
    - Clustering keys
    - By specifying a clustering key, you can control how the data is physically organized within the micro-partitions, which can be helpful for large datasets or complex queries.

<hr>

 - Data Loading/Unloading

    - COPY Command

    - GET and PUT Commands

    - Snowpipe

**2. Data Management, Governance, & Security**

 - Roles & Access Management

    - Default system roles (Public, Sysadmin, Securityadmin, Useradmin, etc.)

    - Privileges and GRANT/REVOKE command

    - Role Hierarchy & Role Management

 - Data Types

    - Supported data types in Snowflake

    - Special data types (e.g., VARIANT, OBJECT, ARRAY)

 - Shares

    - Secure Data Sharing

    - Reader Accounts

  - Tagging and Security

    - Tagging for data classification

    - Dynamic Data Masking & Row Access Policies

 - Compliance (Overview and importance for governance)

    - Understanding how Snowflake supports compliance standards (GDPR, HIPAA)

    Networking & Security

    - Network policies, OAuth, SSO, MFA

**3. Advanced Features & Performance Optimization**

 - Views & Types

    - Regular Views vs. Materialized Views

    - Pros and cons of using each type

 - Stored Procedures & UDFs

    - How to create and use them in Snowflake

    - Benefits and use cases

 - Transactions & Streams

    - How Streams work for change data capture

    - Usage of transactions to maintain consistency

 - Performance Tuning

    - Query optimization (e.g., pruning, clustering)

    - Result caching and Query Acceleration Service (QAS)

    - Query profiling and optimization techniques

**Bonus Topics (Less Emphasis in Exam)**

 - External Tables & Data Lake Integration

    - How Snowflake integrates with external data sources (S3, Azure Blob, Google Cloud Storage)

    Replication & Failover

    - Setting up Snowflake for high availability and disaster recovery

**Not a Core Focus for SnowPro Certification (Optional)**

 - Data Marketplace & Ecosystem

    - Understanding of the Snowflake Data Marketplace (not heavily tested in the exam)

 - Query Profile (Deep Dive)

    - In-depth query profiling may not be as critical for the exam, but still beneficial for practical use.

 - Sequences

    - Not a major focus for SnowPro Certification.









 -->



<!-- 

https://learn.snowflake.com/en/certifications/snowpro-core/

https://docs.snowflake.com/en/guides
https://docs.snowflake.com/en/user-guide/unstructured-intro
https://docs.snowflake.com/en/sql-reference/functions-semistructured

https://iqraanwar.medium.com/ 
https://www.examtopics.com/exams/snowflake/snowpro-core/view/
https://iqraanwar.medium.com/20-snowflake-snow-pro-core-certification-c3c5eb3bd728










-->



<!-- 
https://www.youtube.com/watch?v=ajhLLBGyeDM&list=PLba2xJ7yxHB5X2CMe7qZZu-V4LxNE1HbF

https://www.youtube.com/watch?v=LaTXbpvCwcY
https://www.youtube.com/watch?v=VMYGZo-ibAE
https://www.youtube.com/watch?v=1hPbGshjndM
https://www.youtube.com/watch?v=vqqCUjC20MA
https://www.youtube.com/watch?v=J2CrnVDBN28
https://www.youtube.com/watch?v=cWSzwoy5nMQ
https://www.youtube.com/watch?v=981Lblg_qNw
https://www.youtube.com/watch?v=J2CrnVDBN28
https://www.youtube.com/watch?v=gK5-vQrlEsM
https://www.youtube.com/watch?app=desktop&v=vqqCUjC20MA
https://www.youtube.com/watch?v=a8-pXxFLMFM -->
