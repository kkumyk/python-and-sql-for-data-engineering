
# SnowPro Core Exam Domains

<!-- vscode-markdown-toc -->
1. [Snowflake AI Data Cloud Features & Architecture -	(24%)](#SnowflakeAIDataCloudFeaturesArchitecture-24)
2. [Account Access and Security - (18%)](#AccountAccessandSecurity-18)
3. [Performance and Cost Optimization Concepts -	(16%)](#PerformanceandCostOptimizationConcepts-16)
4. [Data Loading and Unloading -	(12%)](#DataLoadingandUnloading-12)
5. [Data Transformations -	(18%)](#DataTransformations-18)
6. [Data Protection and Data Sharing -	(12%)](#DataProtectionandDataSharing-12)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->


##  1. <a name='SnowflakeAIDataCloudFeaturesArchitecture-24'></a>Snowflake AI Data Cloud Features & Architecture -	(24%)

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



##  2. <a name='AccountAccessandSecurity-18'></a>Account Access and Security - (18%)
##  3. <a name='PerformanceandCostOptimizationConcepts-16'></a>Performance and Cost Optimization Concepts -	(16%)
##  4. <a name='DataLoadingandUnloading-12'></a>Data Loading and Unloading -	(12%)
##  5. <a name='DataTransformations-18'></a>Data Transformations -	(18%)
##  6. <a name='DataProtectionandDataSharing-12'></a>Data Protection and Data Sharing -	(12%)


















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













<!-- https://iqraanwar.medium.com/ -->



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
