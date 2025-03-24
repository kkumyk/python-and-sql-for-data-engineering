**1. Core Architecture & Compute (Most Important for SnowPro Core Exam)**

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