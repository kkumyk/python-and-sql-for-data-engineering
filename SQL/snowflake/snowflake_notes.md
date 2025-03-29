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

### Sections 2 | Assignment


```sql
CREATE DATABASE EXERCISE_DB;

create table customers(
  customer_id int,
  first_name varchar,
  last_name varchar,
  email varchar,
  age int,
  city varchar);

copy into CUSTOMERS
  from s3://snowflake-assignments-mc/gettingstarted/customers.csv
  file_format = (
    type = csv 
    field_delimiter = ',' 
    skip_header = 1);


SELECT * FROM CUSTOMERS;
```

### Sections 3: Snowflake Architecture
#### What is a data warehouse?
##### 1. Purpose of a Data Warehouse  
- Integrates and consolidates data from multiple sources.  
- Optimized for reporting and analytical queries (not transactional).  
- Separates operational (OLTP - Online Transaction Processing) and analytical (OLAP - Online Analytical Processing) workloads.
    - OLTP is used for fast, real-time transactional processing.
    - OLAP is used for large-scale analytical processing and decision-making.

##### 2. ETL Process (Extract, Transform, Load)  
- Extract: Pulls data from different sources (databases, CSV, unstructured data).  
- Transform: Cleans, integrates, and structures data.  
- Load: Stores transformed data in the warehouse for analysis.  

##### 3. Data Warehouse Layers  
- Raw Data Layer (Staging Area)  
  - Stores extracted data as-is to avoid performance issues in source systems.  
  - Often implemented as a separate schema or database.  
- Data Integration Layer  
  - Cleans, transforms, and integrates data.  
  - Establishes relationships between datasets.  
- Access Layer  
  - Final processed data, optimized for queries and reporting.  
  - Used by BI tools (e.g., Power BI), data scientists, and applications.  

##### 4. Staging vs. Stages in Snowflake  
- Staging Area: A concept used to store raw data before transformation.  
- Stages (Snowflake Objects): Physical locations in Snowflake to store and load data (e.g., internal/external stages).  

#### Cloud computing & Snowflake  

##### 1. Why Cloud Computing?  
- Traditional data centers require physical space, maintenance, cooling, security, and upgrades → High overhead & costs.  
- Cloud computing outsources these responsibilities, allowing companies to focus only on their applications.  

##### 2️. What is Software-as-a-Service (SaaS)?  
- SaaS removes infrastructure management → Users only manage their databases & applications.  
- Snowflake is a SaaS → Users define their tables, schemas, and queries without worrying about hardware.  

##### 3️. Who Manages What? (Cloud vs. Snowflake)  
Cloud Providers (AWS, Azure, Google Cloud) manage:  
   - Physical servers  
   - Virtual machines  
   - Storage  

Snowflake manages:  
   - Operating system  
   - Metadata & data management  
   - Software to create and manage databases  

##### 4️. Benefits of Snowflake’s Cloud Model  
- No need to maintain hardware & servers  
- Automatic scalability & performance optimization  
- Secure, cost-efficient, and fully managed  
- Users focus only on building & querying data warehouses  


#### Snowflake Editions Overview  

##### 1. Overview of Snowflake Editions  
Snowflake offers multiple editions with increasing levels of features, scalability, and security:  

- Standard Edition (Basic Features)  
- Enterprise Edition (For Large-Scale Businesses)  
- Business Critical Edition (For Highly Sensitive Data)  
- Virtual Private Snowflake (VPS) (For Maximum Security & Isolation)  

##### 2. Standard Edition (Basic Features)  
- All foundational features suitable for getting started  
- All data is encrypted by default  
- Supports all data types including structured, semi-structured, and geospatial  
- Time Travel up to 1 day for querying historical data  
- Fail-safe disaster recovery allows Snowflake support to restore data up to 7 days  
- Network policies, secure data sharing, and Single Sign-On (SSO) included  

##### 3. Enterprise Edition (For Large Companies)  
- Includes all Standard Edition features  
- Multi-cluster warehouses for automatic scaling of high workloads  
- Time Travel extended to 90 days  
- Materialized Views and Search Optimization for faster queries  
- Column-Level Security to restrict access to specific columns  
- Early access to new Snowflake features through weekly releases  

##### 4. Business Critical Edition (For Highly Sensitive Data)  
- Includes all Enterprise Edition features  
- Compliance with strict regulations such as PHI for healthcare and financial institutions  
- Customer-managed encryption for enhanced security  
- Seamless database recovery and failover/failback for disaster recovery  

##### 5. Virtual Private Snowflake (VPS) (Maximum Security)  
- Dedicated virtual servers and separate metadata store  
- Completely isolated Snowflake account, not shared with other customers  
- Best for financial institutions, government, or extremely sensitive data  
- Requires direct contact with Snowflake to set up  

##### 6. Summary for the SnowPro Exam  
- Standard → Enterprise → Business Critical → VPS (Increasing security and scalability)  
- Time Travel: 1 day (Standard) → 90 days (Enterprise)  
- Enterprise Edition and above include Multi-cluster warehouses and Column-level security  
- Business Critical and VPS focus on regulatory compliance and highest security  
- VPS is fully isolated and requires direct setup with Snowflake  

#### Snowflake Pricing Overview  

##### 1. Main Cost Components  
Snowflake pricing consists of two main cost components:  

- Compute Cost  
- Storage Cost  

These two cost components are decoupled, meaning they can scale independently.  

##### 2. Compute Cost  
Compute cost is divided into three categories:  

- **Active Warehouses**  
  - Costs are based on the time warehouses are running  
  - Warehouses can be suspended to stop charges  
  - Used for query processing  

- **Cloud Services Layer**  
  - Supports behind-the-scenes tasks managed by Snowflake  
  - Charges only apply if the cost exceeds 10% of warehouse consumption  

- **Serverless Features**  
  - Used for automated processes like Snowpipe, search optimization, and re-clustering  
  - Snowflake manages compute resources dynamically  

##### 3. Active Warehouses Pricing  
- Charges are based on warehouse usage time  
- Billed per second with a minimum of one minute  
- Pricing factors:  
  - Duration of warehouse activity  
  - Number of active warehouses  
  - Warehouse size  

##### 4. Credit Consumption Model  
- Snowflake charges in **credits**, not in direct currency  
- Credit consumption depends on:  
  - Warehouse runtime  
  - Warehouse size  

###### Credit Usage by Warehouse Size  
- **Extra Small (XS)** → 1 compute node → 1 credit per hour  
- **Small (S)** → 2 compute nodes → 2 credits per hour  
- **Medium (M)** → 4 compute nodes → 4 credits per hour  
- **Large (L)** → 8 compute nodes → 8 credits per hour  
- Each step in size doubles the compute power and credit consumption  

##### 5. Credit Pricing  
- Credit price varies by:  
  - Snowflake Edition (Standard, Enterprise, Business Critical, VPS)  
  - Cloud Provider (AWS, Azure, GCP)  
  - Region (e.g., US East, Frankfurt)  
- Higher editions have higher per-credit costs  
- Pricing details can be checked at [Snowflake Pricing](https://www.snowflake.com/pricing)  

##### 6. Summary  
- Compute and storage costs are separate and scalable  
- Compute cost is based on warehouse runtime and size  
- Snowflake uses a credit-based billing system  
- Prices depend on edition, cloud provider, and region  
- Serverless features are managed dynamically by Snowflake  

#### Snowflake Storage and Data Transfer Costs  

##### 1. Storage Costs  
- Monthly fee based on the **daily average** storage usage.  
- Costs depend on the **cloud provider** and **region** where the account is based.  
- Example:  
  - **US East (AWS)** → $40 per terabyte per month.  
- Charges are calculated **after data compression** (Snowflake stores compressed data).  

##### 1.1 On-Demand Storage  
- Default pricing model.  
- Users pay for the **exact amount of storage used** in a given month.  
- Costs vary by region.  
- Example: Different pricing in **Frankfurt** compared to **US East**.  

##### 1.2 Capacity Storage (Prepaid Storage)  
- Users can **reserve storage capacity** at a lower price.  
- Requires **upfront payment**.  
- Example:  
  - **1 TB reserved capacity** → $23 upfront.  

##### Risks of Capacity Storage  
- **Underutilization:** If only **100 GB is used**, the full **$23 must still be paid**.  
- **Best Practice:** Start with **on-demand** storage to understand usage, then switch to capacity storage if predictable.  

#### 2. Data Transfer Costs  

##### 2.1 Data Ingress (Inbound Transfers)  
- **Free of charge** in Snowflake.  
- Cloud providers **do not charge** for inbound data transfers.  

##### 2.2 Data Egress (Outbound Transfers)  
- **Charged by cloud providers** when moving data **out of Snowflake**.  
- Costs depend on:  
  - **Cloud provider** (AWS, Azure, GCP).  
  - **Region** of data transfer.  

###### 2.2.1 Free Transfers  
- **Same region + same cloud provider** → **Free**.  
- Example: Transferring data between two Snowflake accounts on **AWS in US East** → **No charge**.  

###### 2.2.2 Charged Transfers  
- **Different region (same cloud provider)** → Higher cost.  
- **Different cloud provider (AWS → GCP, etc.)** → **Most expensive**.  

##### 2.3 Where to Check Pricing  
- Snowflake Pricing Guide: [Snowflake Pricing](https://www.snowflake.com/pricing).  
- Pricing varies based on:  
  - **On-demand usage** vs. **pre-purchased capacity**.  
  - **Cloud provider** (AWS, Azure, GCP).  
  - **Region** of data transfer.  

#### 3. Summary  
- **Storage Costs**  
  - On-demand: Pay for actual usage (monthly).  
  - Capacity storage: Lower cost but requires upfront payment.  
- **Data Transfer Costs**  
  - Ingress (into Snowflake) → Free.  
  - Egress (out of Snowflake) → Charged by cloud providers.  
  - Free if transferring within **same region and cloud provider**.  


#### Monitoring Costs in Snowflake  

#### 1. Introduction to Cost Monitoring  
- **Free Trial Credit**: Snowflake provides a credit for the first 30 days of the free trial (e.g., **$400** in credits).  
- **Required Role**: To monitor costs, you need to have the **Account Admin** role or another role with sufficient privileges.

#### 2. Accessing Cost Management  
- Navigate to the **Admin Section** of Snowflake.  
- Under **Cost Management**, you can monitor costs.  
- **Warehouse**: A warehouse is automatically spun up to run queries that gather cost data.  
  - **Tip**: Select a small warehouse to minimize compute costs.

#### 3. Cost Overview  
- The **Account Overview** provides an easy-to-understand breakdown:  
  - **Amount Spent** and **Credits Used** for the selected period (e.g., last 7 days).  
  - **Daily Breakdown**: Detailed costs and credit consumption per day.  

##### 3.1 Warehouse Costs  
- Overview of the most **expensive warehouses** in terms of credit usage.  
- Snowflake provides a **cloud services-only warehouse** for administrative tasks like metadata management and authentication.

##### 3.2 Storage Costs  
- See the cost breakdown by **storage usage**.  
- View the most expensive queries and the storage resources being used.

#### 4. Deep Dive into Cost Consumption  
- From the **Consumption** section, you can filter by:  
  - **Date**  
  - **Usage Type** (e.g., compute, storage, data transfer).  
  - If you are an **Org Admin**, you can view data for multiple accounts.

##### 4.1 Compute Costs  
- **Primary Category** for cost consumption.  
- Filter by:  
  - **Tags** (used to categorize costs by custom attributes like department or environment).  
  - **Service** (e.g., warehouse consumption or Snowpipe serverless feature usage).  
  - **Resource**: The actual warehouses consuming credits.  
  - **Type**: Separates consumption into compute (warehouses + serverless resources) and cloud services (administrative tasks).

#### 4.2 Tags for Cost Categorization  
- **Tags** help categorize costs and apply labels (key-value pairs) for better cost management.  
  - Example: `Department: Sales`, `Environment: Production`.  
  - Apply tags to resources to break down costs by categories such as **test**, **development**, or **production environments**.

##### 4.3 Cloud Services Costs  
- Breakdown of costs related to **cloud services** used for administrative tasks.  
- **Fail-safe**: Snowflake's data protection feature for system failure prevention (related to cloud services costs).

#### 5. Data Transfer Costs  
- **Data Ingress**: **Free**—no charges for data entering Snowflake.  
- **Data Egress**: **Charged** when transferring data out of Snowflake or to another region.  
- You can view data transfer costs and break them down by:
  - **Region**  
  - **Date Range**


#### 6. Summary  
- To monitor costs, ensure you have the appropriate privileges.  
- Use **Cost Management** to track credits used, warehouse, storage, and data transfer costs.  
- Break down costs using **tags** and **filters**.  
- Review **data transfer** and **resource monitoring** to optimize costs.

### Resource Monitors in Snowflake  

#### 1. Introduction to Resource Monitors  
- **Purpose**: Control and monitor **credit usage** of:  
  - Individual **warehouses**  
  - **Groups** of warehouses  
  - The **entire account**  
- **Availability**: Standard Edition and higher (available for all accounts).  
- **Credit Quota**:  
  - Defines a limit for credit usage within a cycle (e.g., monthly).  
  - Default: Resets every **month**, but can be customized.

#### 2. Scope of Resource Monitors  
- **Account-Level**: Applies to the entire Snowflake account.  
- **Warehouse-Level**: Monitors a specific **warehouse**.  
- **Group of Warehouses**: Monitors multiple warehouses under a single quota.  

#### 3. Actions Based on Usage  
Resource monitors allow actions when a percentage of the quota is reached.  
- **Notify Only**:  
  - Example: **Notify at 50% usage**.  
- **Suspend & Notify**:  
  - Warehouse completes ongoing queries but stops new ones.  
  - Can exceed the quota until all running queries are completed.  
- **Suspend Immediately & Notify**:  
  - **Hard stop**—all running queries are **aborted** when the limit is reached.  
- **Above 100% Quotas**:  
  - It’s possible to set actions for **percentages beyond 100%**.  

#### 4. Permissions & Role-Based Access  
- Only **Account Admins** can create resource monitors.  
- Admins can delegate privileges:  
  - **Monitor**: Allows viewing resource monitor data.  
  - **Modify**: Allows changes to resource monitor settings.  

#### 5. Cloud Services & Resource Monitors  
- Cloud service consumption **cannot be entirely prevented**.  
- Even when a **warehouse is suspended**, cloud services related to it may still incur costs.  

#### 6. Summary  
- **Resource monitors** help control credit usage at different levels.  
- **Actions** can be set for specific usage percentages.  
- **Permissions** can be delegated, but only **Account Admins** can create monitors.  
- Cloud services usage is **not completely preventable**.  

### Setting Up Resource Monitors in Snowflake  

## 1. What is a Resource Monitor?  
A **Resource Monitor** allows you to track and control **credit usage** for:  
- The **entire account** (Account-Level Monitor)  
- **Specific warehouses** (Warehouse-Level Monitor)  

It helps prevent **unexpected credit consumption** by defining limits and actions when usage thresholds are met.  

---

#### 2. Steps to Create a Resource Monitor  

##### **Step 1: Select the Correct Role**  
- You must have the **Account Admin** role to create resource monitors.  
- Navigate to **Cost Management > Resource Monitors**.  

##### **Step 2: Create a New Resource Monitor**  
1. Click **Create Resource Monitor**.  
2. Enter a **descriptive name** (e.g., `Monthly_Account_Budget`).  
   - ⚠ **Note**: Use underscores `_` instead of spaces.  
3. Define the **credit quota** (e.g., `10 credits`).  
4. Choose the **Scope**:  
   - **Account** (for the entire account)  
   - **Warehouse** (for specific warehouses)  

##### **Step 3: Set the Monitoring Period**  
- **Default**: Monthly cycle (resets automatically).  
- You can customize the start and end dates.  

---

#### 3. Configuring Actions Based on Usage  

| Threshold % | Action Type | Description |
|-------------|------------|-------------|
| **50%** | Notify | Sends an email alert but takes no action. |
| **80%** | Suspend & Notify | Notifies and suspends warehouses after queries complete. |
| **99%** | Suspend Immediately & Notify | Immediately stops all queries and suspends the warehouse. |

- **Custom Thresholds**:  
  - You can add multiple notifications (e.g., **25% notify, 50% notify**).  
  - You can **exceed 100%** (e.g., **105%**) to allow for a buffer before shutting down.  

---

#### 4. Finalizing and Activating the Resource Monitor  
- Click **Create**.  
- The **Resource Monitor** is now active and will enforce limits as defined.  

---

#### 5. Summary  
- **Monitors credit usage** at account or warehouse level.  
- **Triggers alerts and suspensions** at defined thresholds.  
- **Customizable periods and actions** to manage budgets efficiently.  


### Setting Up Resource Monitors in Snowflake

#### Introduction
A **resource monitor** helps us create a budget and monitor credit usage in Snowflake. There are two types of resource monitors:

1. **Account-level Resource Monitor** – Applies to the entire account.
2. **Warehouse-level Resource Monitor** – Applies to individual warehouses.

#### Steps to Create a Resource Monitor

##### 1. Select the Account Admin Role
Only the **Account Admin** role can create resource monitors. Ensure that you have this role selected.

##### 2. Navigate to Cost Management
- Go to **Cost Management**.
- Click on **Resource Monitors** to see all existing resource monitors.
- Other roles can view these, but only the Account Admin can create them.

##### 3. Create a New Resource Monitor
- Click **Create New Resource Monitor**.
- Provide a **descriptive name** (e.g., `Monthly_Account_Budget`).
  - **Note:** Spaces are not allowed in names; use underscores (`_`) instead.

##### 4. Set the Credit Quota
- Define the **quota** (e.g., `10` credits per month).
- Select the **monitoring scope**:
  - `Account` – Monitors the entire account.
  - `Warehouse` – Monitors specific warehouses.

##### 5. Configure the Monitoring Schedule
- Default schedule:
  - **Starts immediately**
  - **Resets every month**
  - **Never ends** (unless customized)

##### 6. Define Actions Based on Usage Percentage
Three types of actions can be set:

###### **1. Notify Only**
- Sends an email notification when a specific percentage of the quota is used.
- Example: Notify at **50%** (i.e., `5` credits used).

###### **2. Suspend and Notify**
- Notifies and **suspends warehouses** once a certain percentage is reached.
- Running queries **complete first** before suspension.
- Example: Suspend at **80%**.

###### **3. Suspend Immediately and Notify**
- **Immediately suspends** warehouses and **aborts running queries**.
- Ensures no more credits are used.
- Example: Suspend at **99%**.
- **Optional Buffer:** Set over **100%** (e.g., `105%`) to allow for query completion before shutdown.

##### 7. Add Multiple Actions (Optional)
- Example: Notify at **25%**, **50%**, and **80%** before suspension.
- Actions can be **added or removed** as needed.

##### 8. Finalize and Activate the Resource Monitor
- Click **Create**.
- The resource monitor is now active and will enforce the set actions.

#### Summary
- **Resource monitors** help control credit usage.
- They can be applied at the **account** or **warehouse** level.
- Only **Account Admins** can create them.
- They support **notifications, suspensions, and immediate shutdowns**.
- **Actions** trigger at **defined percentages** of the credit quota.


### Overview of Roles in Snowflake

- Roles are used to assign privileges and manage access in Snowflake.
- This is a high-level overview; a detailed section on access management will follow.

#### Role Hierarchy
- **System-defined roles** exist by default.
- **Custom roles** can be created and assigned as needed.
- **OrgAdmin** is outside the hierarchy but manages organizational-level actions.

#### Role Structure & Privilege Assignment
1. **Public Role**
   - Assigned to every user by default.
   - Grants basic access.

2. **Custom Roles**
   - Best practice: Assign them to **SysAdmin**.
   - Helps avoid conflicts when managing databases and warehouses.

3. **Privilege Assignment**
   - Privileges are granted to roles using the `GRANT` command.
   - Roles are then assigned to users.
   - Privileges are inherited up the hierarchy.

4. **User Role Management**
   - A user can have multiple roles.
   - Each session must have a **current role** for query execution.
   - The role that creates an object is its **owner**.

#### Key System Roles
1. **OrgAdmin**
   - Manages actions at the organizational level.
   - Can create multiple Snowflake accounts.

2. **AccountAdmin**
   - Top-level role in the hierarchy.
   - Has full access and inherits all privileges.
   - Can manage share and reader accounts.

3. **SecurityAdmin**
   - Manages global grants and security settings.
   - Inherits **UserAdmin** privileges.

4. **UserAdmin**
   - Creates and manages users and roles.

5. **SysAdmin**
   - Manages warehouses, databases, and objects.
   - Custom roles should be assigned here.

6. **Public Role**
   - Default role assigned to all users.
   - Cannot be removed.

#### Summary
- Roles define access control in Snowflake.
- System roles have predefined privileges, while custom roles provide flexibility.
- Access is assigned via **GRANT** and follows a hierarchical structure.
- **AccountAdmin** is the most powerful role, while **SysAdmin** is responsible for object management.
- The **OrgAdmin** role operates at a higher, organizational level.

<hr>

## Loading Data

Two load methods:
  - bulk loading
    - most frequent method
    - uses warehouses
    - loading from stages
    - COPY command
    - transformations possible
  - continuous loading
    - designed to load small volumes of data
    - automatically once they are added to stages
    - lates results for analysis
    - Snowpipe (Severless feature)

## Understanding Stages

### Stages in Snowflake:

- stages - DB objects in Snowflake that define the location where data files are stored and from which data can be loaded
- stages define where data is stored (typically in cloud storage) and how to access it
- focus on external stages for cloud-based storage solutions
- watch out costs of data transfer, especially when working across regions and cloud providers
- stage vs. staging area - watch the diff:
    - in data warehousing, "staging" refers to temporary storage before processing
    - in Snowflake, "stage" is a specific object used to load data from external locations

- properties of a stage:
  - location (e.g., AWS S3, GCS(Google Cloud Storage))
  - credentials to access the location (e.g., access keys, permissions)

- types of stages:
  - external stage:
    - the most common type, usually refers to cloud storage like AWS S3, Google Cloud, or Azure Blob 
    
  - internal stage:
    - used when there's no access to external cloud providers, often for local file storage managed by Snowflake

- cost considerations:
   - data transfer between different regions or cloud providers may incur additional costs
   - e.g.: transferring data out of Snowflake to another provider (e.g., Azure) can incur charges

- usage:
  - create stages using the CREATE STAGE command in Snowflake, typically within a database schema
  - external stages are more common and involve cloud storage
  - internal stages are used for local, Snowflake-managed storage

```sql
  -- Database to manage stage objects, fileformats etc.

CREATE OR REPLACE DATABASE MANAGE_DB;

CREATE OR REPLACE SCHEMA external_stages;


-- Creating external stage

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3'
    credentials=(aws_key_id='ABCD_DUMMY_ID' aws_secret_key='1234abcd_key');


-- Description of external stage

DESC STAGE MANAGE_DB.external_stages.aws_stage; 
    
    
-- Alter external stage   

ALTER STAGE aws_stage
    SET credentials=(aws_key_id='XYZ_DUMMY_ID' aws_secret_key='987xyz');
    
    
-- Publicly accessible staging area    

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

-- List files in stage

LIST @aws_stage;

--Load data using copy command

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';



-- COPY Command

-- Creating ORDERS table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
    
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS;
   
-- First copy command
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @aws_stage
    file_format = (type = csv field_delimiter=',' skip_header=1);

-- Copy command with fully qualified stage object
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1);

-- List files contained in stage
LIST @MANAGE_DB.external_stages.aws_stage;    

-- Copy command with specified file(s)

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails.csv');
  

-- Copy command with pattern for file names
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';
    

---- Assignment solution - Create stage & load data ----
 
-- create stage object
CREATE OR REPLACE STAGE EXERCISE_DB.public.aws_stage
    url='s3://snowflake-assignments-mc/loadingdata';

-- List files in stage
LIST @EXERCISE_DB.public.aws_stage;

-- Load the data 
COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
    FROM @aws_stage
    file_format= (type = csv field_delimiter=';' skip_header=1)

-- Assignment 3: Create a stage & load data

CREATE OR REPLACE DATABASE EXERCISE_DB;
USE EXERCISE_DB;
CREATE OR REPLACE TABLE customers (
    ID INT PRIMARY KEY,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    age INT,
    city VARCHAR
);

CREATE OR REPLACE STAGE aws_stage
URL='s3://snowflake-assignments-mc/loadingdata/'
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ';' SKIP_HEADER = 1);

LIST @aws_stage;

COPY INTO customers
FROM @aws_stage
FILE_FORMAT = (TYPE = 'CSV' FIELD_DELIMITER = ';' SKIP_HEADER = 1);

COPY INTO EXERCISE_DB.PUBLIC.CUSTOMERS
FROM @aws_stage
FILE_FORMAT = (TYPE = CSV FIELD_DELIMITER = ';' SKIP_HEADER = 1)
FILES = ('customers2.csv')
ON_ERROR = CONTINUE;
```

## Transform Data

```sql


CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

-- Example 1 - Table
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT
    );

-- Transforming using the SELECT statement
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (select s.$1, s.$2 from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');

   
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
   
-- Example 2 - Table    

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30));


-- Example 2 - Copy Command using a SQL function (subset of functions available)

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (select 
            s.$1,
            s.$2, 
            s.$3,
            CASE WHEN CAST(s.$3 as int) < 0 THEN 'not profitable' ELSE 'profitable' END 
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');


SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;


-- Example 3 - Table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    CATEGORY_SUBSTRING VARCHAR(5)
  
    );


-- Example 3 - Copy Command using a SQL function (subset of functions available)

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM (select 
            s.$1,
            s.$2, 
            s.$3,
            substring(s.$5,1,5) 
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');


SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
```

## Additional Transformation Techniques
```sql

-- Example 3 - Reset Table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30));

-- Example 4 - Using subset of columns

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX (ORDER_ID,PROFIT)
    FROM (select 
            s.$1,
            s.$3
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');

SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;


-- Example 5 - Table Auto increment

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID number autoincrement start 1 increment 1,
    AMOUNT INT,
    PROFIT INT,
    PROFITABLE_FLAG VARCHAR(30));


-- Example 5 - Auto increment ID

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX (PROFIT,AMOUNT)
    FROM (select 
            s.$2,
            s.$3
          from @MANAGE_DB.external_stages.aws_stage s)
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files=('OrderDetails.csv');


SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX WHERE ORDER_ID < 15;

DROP TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;
```

## Copy Option: ON_ERROR

### ON_ERROR COPY Option
- Used in Snowflake's COPY command to handle errors during data loading.

### Common Error Scenario
- Example: A column (Profit) is defined as an integer, but CSV files contain text values, causing errors.

### Default Behavior (ABORT_STATEMENT)
- If no ON_ERROR option is specified, the entire COPY operation fails when an error occurs.
- No data is loaded from any file in the COPY command.

### Handling Errors with ON_ERROR
- CONTINUE: Ignores errors and loads all valid rows.
- SKIP_FILE: Skips the entire file where an error occurs but continues loading other files.
- SKIP_FILE = <number>: Skips a file only if errors exceed a specific number.
- SKIP_FILE = <percentage>%: Skips a file if errors exceed a specified percentage of total rows.
### Practical Demonstration
- Verified results by truncating tables and observing the impact of different ON_ERROR settings.
- Showed how error thresholds (absolute number or percentage) influence data loading behavior.

### Conclusion
The ON_ERROR option in Snowflake provides flexible error handling, allowing users to either abort the load, ignore errors, skip files, or set error limits.

```sql

-- Create new stage
 CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage_errorex
    url='s3://bucketsnowflakes4';
 
 -- List files in stage
 LIST @MANAGE_DB.external_stages.aws_stage_errorex;
 
 -- Create example table
 CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
 
-- Demonstrating error message
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
     file_format= (type = csv field_delimiter=',' skip_header=1)
     files = ('OrderDetails_error.csv');
    
-- Validating table is empty    
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX  ;  
    
-- Error handling using the ON_ERROR option
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'CONTINUE';
    
-- Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;

-- Error handling using the ON_ERROR option = ABORT_STATEMENT (default)
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'ABORT_STATEMENT';

-- Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;

-- Error handling using the ON_ERROR option = SKIP_FILE
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE';
    
-- Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;    
    
-- Error handling using the ON_ERROR option = SKIP_FILE_<number>
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_2';    
  
-- Validating results and truncating table 
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;
SELECT COUNT(*) FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

TRUNCATE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX;    
    
-- Error handling using the ON_ERROR option = SKIP_FILE_<number>
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = 'SKIP_FILE_3%'; 
  
SELECT * FROM OUR_FIRST_DB.PUBLIC.ORDERS_EX;

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv','OrderDetails_error2.csv')
    ON_ERROR = SKIP_FILE_3 
    SIZE_LIMIT = 30;
```

##  File format object

1. **File Format in COPY Command**  
   - Traditionally, file formats (e.g., CSV) are defined within the `COPY` command.  
   - This includes properties like field delimiters, header skipping, etc.  

2. **Best Practice: File Format Object**  
   - Instead of defining the format in every `COPY` command, a reusable **file format object** can be created.  
   - This improves organization and reusability.  

3. **Creating a File Format Object**  
   - Use `CREATE OR REPLACE FILE FORMAT` to define file properties.  
   - Example:  
     ```sql
     CREATE OR REPLACE FILE FORMAT my_format
     TYPE = CSV
     FIELD_DELIMITER = ','
     SKIP_HEADER = 1;
     ```
   - The object can be stored in a dedicated schema for organization.  

4. **Using File Format Object in COPY Command**  
   - Instead of specifying file properties manually, refer to the file format object:  
     ```sql
     COPY INTO my_table  
     FROM @my_stage  
     FILE_FORMAT = (FORMAT_NAME = my_format);
     ```

5. **Modifying File Format Object**  
   - Properties can be changed using `ALTER FILE FORMAT`.  
   - Example:  
     ```sql
     ALTER FILE FORMAT my_format SET SKIP_HEADER = 1;
     ```
   - **However, the file type (CSV/JSON) cannot be changed**—a new format object must be created.  

6. **Overriding File Format Properties in COPY Command**  
   - Specific properties can be temporarily overridden in a `COPY` command without altering the format object.  
   - Example:  
     ```sql
     COPY INTO my_table  
     FROM @my_stage  
     FILE_FORMAT = (FORMAT_NAME = my_format, SKIP_HEADER = 1);
     ```

7. **File Format vs. Stage Object**  
   - File format properties can also be defined in a **stage object**.  
   - However, best practice is to keep file formats separate for clarity and flexibility.  
   - If a `FILE_FORMAT` is specified in `COPY`, it overrides the stage file format properties.  

### Conclusion  
Using a **file format object** instead of defining file formats in every `COPY` command enhances organization and reusability. While file format properties can be set in a stage object, keeping them separate is a recommended best practice.

```sql

-- Specifying file_format in Copy command
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format = (type = csv field_delimiter=',' skip_header=1)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'SKIP_FILE_3'; 
    
-- Creating table
CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.ORDERS_EX (
    ORDER_ID VARCHAR(30),
    AMOUNT INT,
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));    
    
-- Creating schema to keep things organized
CREATE OR REPLACE SCHEMA MANAGE_DB.file_formats;

-- Creating file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.my_file_format;

-- See properties of file format object
DESC file format MANAGE_DB.file_formats.my_file_format;

-- Using file format object in Copy command       
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (FORMAT_NAME=MANAGE_DB.file_formats.my_file_format)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'SKIP_FILE_3'; 

-- Altering file format object
ALTER file format MANAGE_DB.file_formats.my_file_format
    SET SKIP_HEADER = 1;
    
-- Defining properties on creation of file format object   
CREATE OR REPLACE file format MANAGE_DB.file_formats.my_file_format
    TYPE=JSON,
    TIME_FORMAT=AUTO;    
    
-- See properties of file format object    
DESC file format MANAGE_DB.file_formats.my_file_format;   
  
-- Using file format object in Copy command       
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM @MANAGE_DB.external_stages.aws_stage_errorex
    file_format= (FORMAT_NAME=MANAGE_DB.file_formats.my_file_format)
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'SKIP_FILE_3'; 

-- Altering the type of a file format is not possible
ALTER file format MANAGE_DB.file_formats.my_file_format
SET TYPE = CSV;

-- Recreate file format (default = CSV)
CREATE OR REPLACE file format MANAGE_DB.file_formats.my_file_format;

-- See properties of file format object    
DESC file format MANAGE_DB.file_formats.my_file_format;   

-- Truncate table
TRUNCATE table OUR_FIRST_DB.PUBLIC.ORDERS_EX;

-- Overwriting properties of file format object      
COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS_EX
    FROM  @MANAGE_DB.external_stages.aws_stage_errorex
    file_format = (FORMAT_NAME= MANAGE_DB.file_formats.my_file_format  field_delimiter = ',' skip_header=1 )
    files = ('OrderDetails_error.csv')
    ON_ERROR = 'SKIP_FILE_3'; 

DESC STAGE MANAGE_DB.external_stages.aws_stage_errorex;

```

## Assignment 4: Create file format object & use copy option

```sql
USE EXERCISE_DB;

CREATE TABLE IF NOT EXISTS customers (
    ID INT,
    first_name VARCHAR,
    last_name VARCHAR,
    email VARCHAR,
    age INT,
    city VARCHAR
);

CREATE OR REPLACE FILE FORMAT exercise_db.public.my_file_format
TYPE = CSV
FIELD_DELIMITER = '|'
SKIP_HEADER = 1;

CREATE OR REPLACE STAGE exercise_db.public.my_stage
URL = 's3://snowflake-assignments-mc/fileformat/'
FILE_FORMAT = exercise_db.public.my_file_format;


LIST @exercise_db.public.my_stage;

COPY INTO exercise_db.public.customers
FROM @exercise_db.public.my_stage
FILE_FORMAT = (FORMAT_NAME = exercise_db.public.my_file_format);

SELECT COUNT(*) FROM exercise_db.public.customers;

```

## COPY Options in Snowflake 

1. **Purpose of COPY Options**  
   - COPY options **modify** the behavior of the `COPY INTO` command.  
   - They help control how data is loaded into tables.  

2. **Syntax of COPY Options**  
   - COPY options are added as **properties** in the `COPY INTO` command.  
   - Example:  
     ```sql
     COPY INTO table_name
     FROM @stage_name
     FILE_FORMAT = (FORMAT_NAME = my_file_format)
     ON_ERROR = 'CONTINUE';
     ```
   - Here, `ON_ERROR = 'CONTINUE'` modifies how errors are handled.  

3. **Examples of COPY Options**  
   - `ON_ERROR`: Defines how to handle errors (e.g., `'CONTINUE'`, `'SKIP_FILE'`, `'ABORT_STATEMENT'`).  
   - `PURGE`: If `TRUE`, deletes the source file after a successful load.  
   - `MATCH_BY_COLUMN_NAME`: Specifies if column names in the file should match table columns.  

4. **Importance of COPY Options**  
   - They allow **fine-tuning** of data loading behavior.  
   - Help manage errors, duplicate data, and transformations.  

### VALIDATION_MODE

1. **VALIDATION_MODE in COPY Command**  
   - Allows validating data before loading.  
   - Ensures errors are identified before inserting data.

2. **RETURN_ERRORS Option**  
   - Displays errors found in data without loading it.  
   - Returns error details such as file, line, character, and type.

3. **RETURN_n_ROWS Option**  
   - Returns a specified number of rows if no errors are found.  
   - Example: RETURN_10_ROWS will display the first 10 rows if they are valid.  

4. **Practical Execution**  
   - A database and an ORDERS table are created.  
   - Data is stored in an S3 bucket and accessed via a stage object.  
   - LIST command helps check available files in the stage.  
   - COPY command is used with VALIDATION_MODE to test data before loading.  

```sql

-- Prepare database & table

CREATE OR REPLACE DATABASE COPY_DB;

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

-- Prepare stage object

CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';
  
LIST @COPY_DB.PUBLIC.aws_stage_copy;
  
-- Load data using copy command

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;
    
SELECT * FROM ORDERS;    
    
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
   VALIDATION_MODE = RETURN_5_ROWS ;

--- Use files with errors ---

create or replace stage copy_db.public.aws_stage_copy
    url ='s3://snowflakebucket-copyoption/returnfailed/';
    
list @copy_db.public.aws_stage_copy;

-- show all errors --
copy into copy_db.public.orders
    from @copy_db.public.aws_stage_copy
    file_format = (type=csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    validation_mode=return_errors;

-- validate first n rows --
copy into copy_db.public.orders
    from @copy_db.public.aws_stage_copy
    file_format = (type=csv field_delimiter=',' skip_header=1)
    pattern='.*error.*'
    validation_mode=return_1_rows;
``` 

5. **Handling Errors**  
   - When errors exist, RETURN_ERRORS displays them.  
   - Errors can include numeric conversion issues, missing values, etc.  
   - The source file, row, and character causing the issue are shown.  

6. **Testing with Different Stages**  
   - A new stage with error-containing files is created and validated.  
   - Errors are displayed instead of loading faulty data.  
   - RETURN_n_ROWS will not return rows if an error exists in the first row.  

7. **Importance of Validation**  
   - Helps prevent bad data from entering tables.  
   - Ensures only clean, accurate data is loaded.

### Assignment 5: Using the copy options

```sql
---- Assignment - Create file format & load data ----
 
-- create table
create or replace table employees(
  customer_id int,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  age int,
  city varchar(50));
 
-- create file format object
CREATE OR REPLACE FILE FORMAT EXERCISE_DB.public.aws_fileformat
TYPE = CSV
FIELD_DELIMITER=','
SKIP_HEADER=1;

-- create stage object
CREATE OR REPLACE STAGE EXERCISE_DB.public.aws_stage
    url='s3://snowflake-assignments-mc/copyoptions/example1';
    
-- List files in stage
LIST @EXERCISE_DB.public.aws_stage;      

-- Use validation mode
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      VALIDATION_MODE = RETURN_ERRORS;
 
-- Use ON_ERROR
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      ON_ERROR = CONTINUE;
```
## Working with rejected records

1. **Using Validation Mode to Identify Errors**  
   - `VALIDATION_MODE = RETURN_ERRORS` helps detect errors without loading data.  
   - The error report includes details like file, row, character, and category.

2. **Fetching Error Results**  
   - Errors from the last COPY command can be retrieved using `RESULT_SCAN(LAST_QUERY_ID())`.  
   - The last query ID can be manually copied or dynamically fetched.

3. **Storing Rejected Records**  
   - Create a `REJECTED` table to store problematic records.  
   - Use `INSERT INTO rejected` to add new rejected records dynamically.

4. **Alternative Method: Using ON_ERROR = CONTINUE**  
   - Loads valid rows while skipping erroneous ones.  
   - Errors can still be retrieved using `VALIDATE` on the last COPY command.

5. **Processing Rejected Records**  
   - The `REJECTED_ERRORS` column is of type `VARIANT` in Snowflake.  
   - Use `SPLIT_PART()` to extract individual error details.  
   - Data can be transformed and stored in a structured format for further processing.

6. **Fixing Errors Before Reloading**  
   - Replace incorrect values (e.g., negative quantities).  
   - Clean and reprocess corrected records.  

7. **Final Steps**  
   - Save processed error data in a `REJECTED_VALUES` table.  
   - Review and refine rejected records for potential reloading.  

These techniques help efficiently handle and fix errors in Snowflake COPY commands.


```sql

---- Use files with errors ----
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/returnfailed/';

LIST @COPY_DB.PUBLIC.aws_stage_copy;    

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_1_rows;
    
-------------- Working with error results -----------

---- 1) Saving rejected files after VALIDATION_MODE ---- 

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    VALIDATION_MODE = RETURN_ERRORS;


-- Storing rejected /failed results in a table

CREATE OR REPLACE TABLE rejected AS 
select rejected_record from table(result_scan(last_query_id()));

-- Adding additional records --

INSERT INTO rejected
select rejected_record from table(result_scan(last_query_id()));

SELECT * FROM rejected;

---- 2) Saving rejected files without VALIDATION_MODE ---- 

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    ON_ERROR=CONTINUE;
  
select * from table(validate(orders, job_id => '_last'));

---- 3) Working with rejected records ---- 

SELECT REJECTED_RECORD FROM rejected;

CREATE OR REPLACE TABLE rejected_values as
SELECT 
SPLIT_PART(rejected_record,',',1) as ORDER_ID, 
SPLIT_PART(rejected_record,',',2) as AMOUNT, 
SPLIT_PART(rejected_record,',',3) as PROFIT, 
SPLIT_PART(rejected_record,',',4) as QUATNTITY, 
SPLIT_PART(rejected_record,',',5) as CATEGORY, 
SPLIT_PART(rejected_record,',',6) as SUBCATEGORY
FROM rejected; 

SELECT * FROM rejected_values;

```
## SIZE_LIMIT Copy Option

1. **What is SIZE_LIMIT?**  
   - `SIZE_LIMIT` sets a maximum file size (in bytes) for a COPY command.  
   - At least one file (the first one) will always be loaded, even if it exceeds the limit.  
   - If the combined file size exceeds the limit, additional files will not be loaded.  

2. **Using SIZE_LIMIT in Practice**  
   - First, reset the database and create a new stage object pointing to an S3 bucket.  
   - Check the file sizes in the stage before applying `SIZE_LIMIT`.

```sql

---- SIZE_LIMIT ----

-- Prepare database & table
CREATE OR REPLACE DATABASE COPY_DB;

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));
    
-- Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';
    
-- List files in stage
LIST @aws_stage_copy;

-- Load data using copy command
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    SIZE_LIMIT=20000;
```

3. **Example Scenarios**  
   - **Setting `SIZE_LIMIT = 20,000`**  
     - The first file is loaded (even if it exceeds the limit).  
     - No additional files are loaded.  
   - **Setting `SIZE_LIMIT = 60,000`**  
     - If the first file is within the limit, additional files are loaded until the limit is reached.  

4. **Key Takeaways**  
   - The limit applies to the total size of loaded files, not individual files.  
   - Useful for controlling data ingestion size and optimizing performance.

### RETURN_FAILED_ONLY Copy Option  

1. **What is RETURN_FAILED_ONLY?**  
   - A COPY option that returns only files that failed to load due to errors.  
   - Default value is `FALSE`, meaning all files (both successful and failed) are shown.  

2. **How It Works**  
   - When set to `TRUE`, only files with errors are displayed, while fully loaded files are hidden.  
   - If used alone, it may not be useful because errors still stop execution.  
   - Best used with `ON_ERROR = CONTINUE` to continue loading despite errors.  

3. **Example Scenarios**  
   - **Without RETURN_FAILED_ONLY (default or `FALSE`)**  
     - Shows all files, including successfully loaded ones.  
   - **With RETURN_FAILED_ONLY = TRUE**  
     - Displays only files that had partial loading due to errors.  

4. **Use Case**  
   - Helpful when working with large datasets, allowing focus only on problematic files.  

```sql
---- RETURN_FAILED_ONLY ----

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

-- Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/returnfailed/';
  
LIST @COPY_DB.PUBLIC.aws_stage_copy;
    
 -- Load data using copy command
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    RETURN_FAILED_ONLY = TRUE;
    
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    ON_ERROR =CONTINUE
    RETURN_FAILED_ONLY = TRUE;

-- Default = FALSE

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    ON_ERROR =CONTINUE;
```

## TRUNCATECOLUMNS Copy Option 

1. **What is TRUNCATECOLUMNS?**  
   - A COPY option that determines whether to truncate values exceeding the target column's length.  
   - **Default:** `FALSE` (causes an error when data exceeds column limits).  

2. **How It Works**  
   - If **set to `FALSE`**, an error occurs when a value exceeds the column’s character limit.  
   - If **set to `TRUE`**, the exceeding characters are automatically truncated to fit within the column's limit.  

3. **Example Scenario**  
   - A table has a **VARCHAR(10)** column.  
   - A source file contains a value, **"Electronics" (11 characters)**.  
   - With `TRUNCATECOLUMNS = TRUE`, the value is truncated to **"Electronic" (10 characters)**, preventing an error.  

4. **Use Case**  
   - Useful when data cannot be modified at the source.  
   - Helps prevent errors without changing column definitions.

```sql
CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(10),
    SUBCATEGORY VARCHAR(30));

-- Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';
  
LIST @COPY_DB.PUBLIC.aws_stage_copy;
    
-- Load data using copy command
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';


COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    TRUNCATECOLUMNS = true;  
    
SELECT * FROM ORDERS;
```

## FORCE Copy Option

1. **What is FORCE?**  
   - A COPY option that allows **reloading files** even if they have **already been loaded** and **haven't changed**.  
   - **Default:** `FALSE` (prevents duplicate loading).  

2. **How It Works**  
   - **Default Behavior (`FALSE`)**:  
     - Snowflake tracks previously loaded files and skips them if they haven't changed.  
   - **With `FORCE = TRUE`**:  
     - The file is loaded again **regardless** of whether it was previously processed, which **can lead to duplicates**.  

3. **Example Scenario**  
   - Load a file into a table → Works as expected.  
   - Try to load the same file again → Snowflake **skips it** (since it remembers it was loaded).  
   - Use `FORCE = TRUE` → Snowflake **reloads the file**, even if unchanged.  

4. **Use Case & Considerations**  
   - **When Needed:** If forced reloading is necessary for **testing, debugging, or special cases**.  
   - **Risk:** Can **cause duplicate records**, so use with caution.

```sql

CREATE OR REPLACE TABLE  COPY_DB.PUBLIC.ORDERS (
    ORDER_ID VARCHAR(30),
    AMOUNT VARCHAR(30),
    PROFIT INT,
    QUANTITY INT,
    CATEGORY VARCHAR(30),
    SUBCATEGORY VARCHAR(30));

-- Prepare stage object
CREATE OR REPLACE STAGE COPY_DB.PUBLIC.aws_stage_copy
    url='s3://snowflakebucket-copyoption/size/';
  
LIST @COPY_DB.PUBLIC.aws_stage_copy;
  
-- Load data using copy command
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';

-- Not possible to load file that have been loaded and data has not been modified
COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*';

SELECT * FROM ORDERS;    

-- Using the FORCE option

COPY INTO COPY_DB.PUBLIC.ORDERS
    FROM @aws_stage_copy
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*Order.*'
    FORCE = TRUE;
```

### Analyzing Load History in Snowflake 

1. **Why Check Load History?**  
   - Helps track **which files** were loaded into tables.  
   - Shows **last load time**, **row count**, **errors**, etc.  
   - Useful for debugging and data validation.  

2. **Viewing Load History in Snowflake**  
   - Each **database** has an `INFORMATION_SCHEMA`.  
   - Inside it, the **LOAD_HISTORY** view stores **table-specific** load history.  
   - Example query:  
     ```sql
     SELECT * FROM INFORMATION_SCHEMA.LOAD_HISTORY;
     ```
   - Shows details like **schema name, table name, load time, rows loaded, and errors**.  

3. **Global Load History**  
   - Found in **SNOWFLAKE database → ACCOUNT_USAGE schema**.  
   - Provides **historical load data**, even for replaced tables.  
   - Contains a **hidden table ID** (unique for each table instance).  
   - Query:  
     ```sql
     SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.LOAD_HISTORY;
     ```
  
4. **Filtering Load History**  
   - **By Table Name & Schema**:  
     ```sql
     SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.LOAD_HISTORY  
     WHERE TABLE_NAME = 'ORDERS' AND SCHEMA_NAME = 'PUBLIC';
     ```
   - **Only Failed Loads**:  
     ```sql
     SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.LOAD_HISTORY  
     WHERE ERROR_COUNT > 0;
     ```
   - **By Date (e.g., before yesterday)**:  
     ```sql
     SELECT * FROM SNOWFLAKE.ACCOUNT_USAGE.LOAD_HISTORY  
     WHERE LAST_LOAD_TIME < CURRENT_DATE - 1;
     ```

5. **Why Use This?**  
   - **Audit and troubleshoot data loads.**  
   - **Identify and fix errors quickly.**  
   - **Track changes over time, even if tables were replaced.**

  ## Assignment 6: Using the copy options

```sql
 -- Create table
create or replace table employees(
  customer_id int,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(50),
  age int,
  department varchar(50));


-- create stage object
CREATE OR REPLACE STAGE EXERCISE_DB.public.aws_stage
    url='s3://snowflake-assignments-mc/copyoptions/example2';
 
-- create file format object
CREATE OR REPLACE FILE FORMAT EXERCISE_DB.public.aws_fileformat
TYPE = CSV
FIELD_DELIMITER=','
SKIP_HEADER=1;

 
-- Use validation mode
COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      VALIDATION_MODE = RETURN_ERRORS;

-- Use TRUNCATECOLUMNS

COPY INTO EXERCISE_DB.PUBLIC.EMPLOYEES
    FROM @aws_stage
      file_format= EXERCISE_DB.public.aws_fileformat
      TRUNCATECOLUMNS = TRUE; 
```

## Loading Unstructured Data

### Handling Semi-Structured Data in Snowflake

#### **Why Work with Semi-Structured Data?**  
- **JSON, XML, or Parquet files** don’t follow strict table structures.  
- Snowflake provides powerful tools to **store, parse, and analyze** such data.  

### **Steps to Load and Process Semi-Structured Data**  

**1️. Create a Stage**  
- A **stage** establishes a connection to where the files are stored (e.g., S3, Azure Blob, GCS).  
- Example of creating an external stage:  
  ```sql
  CREATE OR REPLACE STAGE my_stage  
  URL = 's3://my-bucket/data/'  
  STORAGE_INTEGRATION = my_integration;
  ```
---

**2.. Load Raw Data into a Table**  
- Create a **table with a VARIANT column** (which can store flexible JSON data).  
- Load data from the staged files.  
- Example:  
  ```sql
  CREATE OR REPLACE TABLE raw_json_data (data VARIANT);
  
  COPY INTO raw_json_data  
  FROM @my_stage/json_files  
  FILE_FORMAT = (TYPE = JSON);
  ```
---

**3️. Analyze & Extract Data**  
- Use **Snowflake JSON functions** to query nested fields.  
- Example (extracting `customer_name` from JSON data):  
  ```sql
  SELECT data:customer.name AS customer_name  
  FROM raw_json_data;
  ```
  
---

**4️. Flatten & Transform the Data**  
- **FLATTEN()** helps convert **nested JSON arrays** into rows.  
- Example:  
  ```sql
  SELECT value:order_id AS order_id, value:product AS product_name  
  FROM raw_json_data,  
  LATERAL FLATTEN(input => data:orders);
  ```
  
---

**5️. Load into a Final Structured Table**  
- After extracting necessary fields, load into a **structured table**.  
- Example:  
  ```sql
  CREATE OR REPLACE TABLE final_orders (  
      order_id INT,  
      customer_name STRING,  
      product STRING  
  );

  INSERT INTO final_orders  
  SELECT data:order_id, data:customer.name, data:product  
  FROM raw_json_data;
  ```
### **Summary**  
**Stages** store files for processing.  
**VARIANT data type** allows flexibility.  
**JSON functions** extract necessary fields.  
**FLATTEN()** helps with hierarchical data.  
**Final table** ensures structured storage.  

## Working with JSON Data in Snowflake

1. **JSON Overview**  
   - JSON (JavaScript Object Notation) is a structured text format for storing and transmitting semi-structured data.  
   - It consists of objects (key-value pairs), arrays, and nested structures.  
   - JSON is commonly used for APIs, logs, and unstructured datasets.  

2. **Challenges in Loading JSON into Snowflake**  
   - Nested Objects: JSON attributes can contain objects within objects.  
   - Arrays: Some attributes store multiple values in a list format.  
   - Combination of Nested Objects & Arrays: Complex hierarchical structures must be flattened for proper querying.  

3. **Steps to Load JSON Data in Snowflake**  
   - Step 1: Create a Stage → Connects Snowflake to a storage location (e.g., AWS S3, Azure Blob).  
   - Step 2: Create a Table with a VARIANT Column → The `VARIANT` data type stores JSON without predefined structure.  
   - Step 3: Load JSON Data Using COPY INTO → Imports raw JSON data into the table.  
   - Step 4: Query & Extract Data → Use dot notation (`data:field`) for direct access, and FLATTEN() for arrays.  

4. **Extracting Data from JSON**  
   - Simple Fields: `SELECT data:name, data:age FROM raw_json_data;`  
   - Nested Fields: `SELECT data:job.title FROM raw_json_data;`  
   - Flattening Arrays: `LATERAL FLATTEN(input => data:previous_companies);`  

5. **Key Takeaways**  
   - Snowflake’s `VARIANT` type allows flexible handling of semi-structured data.  
   - The `FLATTEN()` function helps extract values from arrays.  
   - JSON parsing functions enable structured querying of complex, nested data.  
   - Properly structuring and transforming JSON data ensures efficient analysis in Snowflake.  

###  Understanding our data
- JSON files are text files formatted for human and machine readability.  
- They are often created automatically by devices and contain structured data.  
- JSON documents consist of objects enclosed in curly brackets `{}`.  
- Each object can have multiple attributes, separated by commas.  
- Objects can have simple attributes like `name: "John"` and `age: 30`.  
- JSON documents can contain multiple objects separated by commas.  
- Simple JSON structures can be easily converted into structured tables.  
- JSON can have **nested values** (objects within objects).  
- JSON can also include **arrays** (lists of multiple values within brackets `[]`).  
- Arrays store multiple values for a single attribute, e.g., `previous_companies: ["Google", "Amazon"]`.  
- Objects can contain nested structures, such as a `job` attribute with `title` and `salary`.  
- JSON structures can be a **combination of arrays and nested objects**, making them complex.  
- Example: `spoken_languages` can be an array where each language has a `name` and `level`.  
- Snowflake supports loading JSON data into a **variant column** for flexibility.  
- The first step in handling JSON in Snowflake is **creating a stage** to load raw data.  
- The next step is storing JSON data in a table with a **variant column**.  
- Further processing involves extracting and flattening JSON data for structured queries.  
- The upcoming steps will involve handling and querying nested and array-based JSON data.

### Creating stage & raw file

**Step 1:** Establish the connection to the data source (bucket).  
  - Create a **stage object** (`JSONSTAGE`) specifying the **URL** of the data source. 

**Step 2:** Create a **file format object** (`JSONFORMAT`) with the type set to JSON.  
  - Use default properties for the file format configuration.  

**Step 3:** Create a **raw table** (`JSON_RAW`) with a **variant** data type to store JSON data.  
- Each JSON object in the file will be stored as a row in this table. 

**Step 4:** Use the **COPY INTO** command to load the JSON file (`HR_data`) from the stage into the raw table.  
- Use the previously created file format object to parse the JSON correctly.

**Step 5:** Verify the loaded data by selecting records from the table.  
- Data appears structured, and Snowflake correctly interprets the JSON format.  

```sql
-- First step: Load Raw JSON

CREATE OR REPLACE stage MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
     url='s3://bucketsnowflake-jsondemo';

CREATE OR REPLACE file format MANAGE_DB.FILE_FORMATS.JSONFORMAT
    TYPE = JSON;
    
CREATE OR REPLACE table OUR_FIRST_DB.PUBLIC.JSON_RAW (
    raw_file variant);
    
COPY INTO OUR_FIRST_DB.PUBLIC.JSON_RAW
    FROM @MANAGE_DB.EXTERNAL_STAGES.JSONSTAGE
    file_format= MANAGE_DB.FILE_FORMATS.JSONFORMAT
    files = ('HR_data.json');
   
SELECT * FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

```
### Assignment 7: Load raw JSON

```sql
 --  Create database (only if not already created in previous assignment)
create database EXERCISE_DB;
 
USE EXERCISE_DB;

-- First step: Load Raw JSON
CREATE OR REPLACE stage JSONSTAGE
     url='s3://snowflake-assignments-mc/unstructureddata/';

CREATE OR REPLACE file format JSONFORMAT
    TYPE = JSON;
    
CREATE OR REPLACE table JSON_RAW (
    raw_file variant);
    
COPY INTO JSON_RAW
    FROM @JSONSTAGE
    file_format= JSONFORMAT
    
SELECT * FROM JSON_RAW;

```
### Parsing JSON

**Step 1:** Convert raw JSON data into a structured format for SQL queries.  
**Step 2:** Use **dot notation (`column:attribute`)** to extract specific attributes (e.g., `RAW_FILE:CITY`).  
**Step 3:** Use **index notation (`$1`)** as an alternative way to reference columns.  
**Step 4:** Format extracted values for better readability (remove quotes, rename columns using aliases).  
**Step 5:** Convert data types using **double colons (`::`)** (e.g., `::STRING`, `::INTEGER`).  
**Step 6:** Ensure numerical values are correctly stored as integers for structured tables.  
**Step 7:** Combine multiple attributes (ID, first name, last name, gender) into a well-structured table.  
**Step 8:** Handle **nested JSON data** (e.g., extracting `salary` from a nested `job` object).  
**Step 9:** Identify challenges with **nested objects and arrays** and prepare to flatten them.  
**Next Steps:** Learn how to efficiently extract and work with nested JSON data.  

```sql
-- Second step: Parse & Analyse Raw JSON

   -- Selecting attribute/column

SELECT RAW_FILE:city FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT $1:first_name FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

   -- Selecting attribute/column - formattted

SELECT RAW_FILE:first_name::string as first_name  FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT RAW_FILE:id::int as id  FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT 
    RAW_FILE:id::int as id,  
    RAW_FILE:first_name::STRING as first_name,
    RAW_FILE:last_name::STRING as last_name,
    RAW_FILE:gender::STRING as gender

FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

-- Handling nested data
   
SELECT RAW_FILE:job as job  FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

```
## Handling Nested Data

- **Use dot notation (`.`) to access nested attributes** within a JSON hierarchy.  
- **Parent attributes** (e.g., `job`) can be accessed using **colon notation (`:`)**.  
- **Child attributes** can be accessed by adding a dot (`.`) after the parent attribute (e.g., `job.salary`).  
- **Type casting (`::`)** can be applied to child attributes to convert them into structured data types.  
- **Combine multiple extracted attributes** (e.g., `first_name`, `job.salary`, `job.title`) to create a structured table.  
- **Challenges arise with arrays**, which require additional techniques to flatten multiple values.  
- **Next step:** Learn how to handle and extract data from JSON arrays in Snowflake.  


```sql
   -- Handling nested data
   
SELECT RAW_FILE:job as job  FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT 
      RAW_FILE:job.salary::INT as salary
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
    RAW_FILE:first_name::STRING as first_name,
    RAW_FILE:job.salary::INT as salary,
    RAW_FILE:job.title::STRING as title
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

-- Handling arrays

SELECT
    RAW_FILE:prev_company as prev_company
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT
    RAW_FILE:prev_company[1]::STRING as prev_company
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT
    ARRAY_SIZE(RAW_FILE:prev_company) as prev_company
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT 
    RAW_FILE:id::int as id,  
    RAW_FILE:first_name::STRING as first_name,
    RAW_FILE:prev_company[0]::STRING as prev_company
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW
UNION ALL 
SELECT 
    RAW_FILE:id::int as id,  
    RAW_FILE:first_name::STRING as first_name,
    RAW_FILE:prev_company[1]::STRING as prev_company
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW
ORDER BY id;
```

### Assignment 8: Parsing & handling array

```sql
-- Second step: Parse & Analyse Raw JSON 

SELECT * FROM JSON_RAW;

-- Selecting attribute/column
SELECT 
$1:first_name::STRING,
$1:last_name::STRING,
$1:Skills[0]::STRING,
$1:Skills[1]::STRING
FROM JSON_RAW;


-- Copy data in table
CREATE TABLE SKILLS AS
SELECT 
$1:first_name::STRING as first_name,
$1:last_name::STRING as last_name,
$1:Skills[0]::STRING as Skill_1,
$1:Skills[1]::STRING as Skill_2
FROM JSON_RAW;

-- Query from table
SELECT * FROM SKILLS
WHERE FIRST_NAME='Florina';
```

## Flatten Hierarchical Data

- **JSON arrays contain hierarchical data**, making it harder to analyze directly in relational databases.  
- **Access elements using brackets (`[index]`)** to retrieve specific items, but this approach is limited.  
- **Use dot notation (`.`)** to extract nested attributes (e.g., `spoken_languages[0].language`).  
- **Fixed indexing and UNION operations** can break data into rows, but this method is inefficient and rigid.  
- **Issues with UNION approach**:  
  - Generates redundant rows with NULL values.  
  - Doesn't adapt dynamically if more elements exist.  
- **Best practice: Use the `FLATTEN` function** to dynamically extract and transform array elements into structured rows.  
- **FLATTEN function in Snowflake**:  
  - Converts array elements into separate rows dynamically.  
  - Eliminates NULL values and redundant data.  
  - Uses a `TABLE FUNCTION` approach for structured querying.  
- **Querying with `FLATTEN`**:  
  - Apply `FLATTEN` to the JSON array.  
  - Use `VALUE` to extract the nested attributes.  
  - Join the flattened data with the original table for a structured format.  
- **End result**: A clean, structured table optimized for analytical queries.  

```sql

SELECT 
    RAW_FILE:spoken_languages as spoken_languages
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT * FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
     array_size(RAW_FILE:spoken_languages) as spoken_languages
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
     RAW_FILE:first_name::STRING as first_name,
     array_size(RAW_FILE:spoken_languages) as spoken_languages
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
    RAW_FILE:spoken_languages[0] as First_language
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
    RAW_FILE:first_name::STRING as first_name,
    RAW_FILE:spoken_languages[0] as First_language
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;


SELECT 
    RAW_FILE:first_name::STRING as First_name,
    RAW_FILE:spoken_languages[0].language::STRING as First_language,
    RAW_FILE:spoken_languages[0].level::STRING as Level_spoken
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW;

SELECT 
    RAW_FILE:id::int as id,
    RAW_FILE:first_name::STRING as First_name,
    RAW_FILE:spoken_languages[0].language::STRING as First_language,
    RAW_FILE:spoken_languages[0].level::STRING as Level_spoken
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW
UNION ALL 
SELECT 
    RAW_FILE:id::int as id,
    RAW_FILE:first_name::STRING as First_name,
    RAW_FILE:spoken_languages[1].language::STRING as First_language,
    RAW_FILE:spoken_languages[1].level::STRING as Level_spoken
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW
UNION ALL 
SELECT 
    RAW_FILE:id::int as id,
    RAW_FILE:first_name::STRING as First_name,
    RAW_FILE:spoken_languages[2].language::STRING as First_language,
    RAW_FILE:spoken_languages[2].level::STRING as Level_spoken
FROM OUR_FIRST_DB.PUBLIC.JSON_RAW
ORDER BY ID;

select
      RAW_FILE:first_name::STRING as First_name,
    f.value:language::STRING as First_language,
   f.value:level::STRING as Level_spoken
from OUR_FIRST_DB.PUBLIC.JSON_RAW, table(flatten(RAW_FILE:spoken_languages)) f;

```

## Insert final data

- **Variant column in Snowflake is highly flexible** and works well with functions like `FLATTEN`.  
- **Two main ways to insert data into a structured table** from JSON:  
  1. **Create Table As (`CREATE TABLE AS`)**:  
     - Directly creates a table from a `SELECT` statement.  
     - Stores the query result in a new table.  
     - Example:  
       ```sql
       CREATE OR REPLACE TABLE new_table AS
       SELECT * FROM source_table;
       ```
  2. **Separate `INSERT INTO` statement**:  
     - First, create an empty table with the desired structure.  
     - Then, use `INSERT INTO` to populate it from a `SELECT` query.  
     - Example:  
       ```sql
       INSERT INTO new_table
       SELECT * FROM source_table;
       ```
- **Truncating the table (`TRUNCATE TABLE`)** removes all records while keeping the structure.  
- **Query results remain available dynamically** without inserting into a permanent table.  
- **Choosing between the methods** depends on the use case:  
  - If querying is frequent and structured storage is needed → **Use `INSERT INTO` or `CREATE TABLE AS`**.  
  - If queries are dynamic and change often → **Use `FLATTEN` and query JSON data on the fly**.  
- **Snowflake’s flexibility allows on-the-fly querying**, reducing the need for permanent table creation in some cases.

```sql
-- Option 1: CREATE TABLE AS

CREATE OR REPLACE TABLE Languages AS
select
      RAW_FILE:first_name::STRING as First_name,
    f.value:language::STRING as First_language,
   f.value:level::STRING as Level_spoken
from OUR_FIRST_DB.PUBLIC.JSON_RAW, table(flatten(RAW_FILE:spoken_languages)) f;

SELECT * FROM Languages;

truncate table languages;

-- Option 2: INSERT INTO

INSERT INTO Languages
select
      RAW_FILE:first_name::STRING as First_name,
    f.value:language::STRING as First_language,
   f.value:level::STRING as Level_spoken
from OUR_FIRST_DB.PUBLIC.JSON_RAW, table(flatten(RAW_FILE:spoken_languages)) f;


SELECT * FROM Languages;

```

## Querying PARQUET Data  

- **Querying Directly from a Stage**  
  - Data from Parquet files can be queried directly.  
  - Column names are represented as `$1`, `$2`, etc.  
  - Attributes inside a column can be accessed using `:` (similar to JSON).  

- **Extracting and Structuring Data**  
  - Convert raw, nested data into structured columns.  
  - Use double quotes for attributes containing spaces.  
  - Extracting attributes makes data more usable for analysis.  

- **Handling Data Type Issues**  
  - **String values with extra double quotes** → Convert to `VARCHAR`.  
  - **Integer-stored dates** → Convert to actual `DATE` format.  

- **Converting Numeric Date Values**  
  - Parquet files often store dates as seconds since **January 1, 1970** (UNIX epoch).  
  - Use the `DATE` function to transform it:  
    ```sql
    SELECT DATE(Seconds_Since_1970) AS Date_Column FROM table;
    ```
  - Example conversions:  
    - `DATE(1)` → **January 1, 1970**  
    - `DATE(1 * 365)` → **January 1, 1971**  

- **Final Data Transformation**  
  - Convert string-based numbers to `INTEGER`.  
  - Apply `VARCHAR`, `DATE`, or other appropriate types for analysis.  
  - Assign aliases to columns for better readability.  

- **Final Clean Table**  
  - Now, the table has structured **columns and rows** with correctly formatted data.  
  - Ready for further queries, analysis, and integration into an analytical database.  

```sql
    -- Create file format and stage object
    
CREATE OR REPLACE FILE FORMAT MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT
    TYPE = 'parquet';

CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
    url = 's3://snowflakeparquetdemo'   
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT;
    
    -- Preview the data
    
LIST  @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;   
    
SELECT * FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;

-- File format in Queries

CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
    url = 's3://snowflakeparquetdemo'  ;
    
SELECT * 
FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
(file_format => 'MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT');

-- Quotes can be omitted in case of the current namespace
USE MANAGE_DB.FILE_FORMATS;

SELECT * 
FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
(file_format => MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT);


CREATE OR REPLACE STAGE MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE
    url = 's3://snowflakeparquetdemo'   
    FILE_FORMAT = MANAGE_DB.FILE_FORMATS.PARQUET_FORMAT;

    -- Syntax for Querying unstructured data

SELECT 
$1:__index_level_0__,
$1:cat_id,
$1:date,
$1:"__index_level_0__",
$1:"cat_id",
$1:"d",
$1:"date",
$1:"dept_id",
$1:"id",
$1:"item_id",
$1:"state_id",
$1:"store_id",
$1:"value"
FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;

    -- Date conversion
    
SELECT 1;

SELECT DATE(365*60*60*24);

    -- Querying with conversions and aliases
    
SELECT 
$1:__index_level_0__::int as index_level,
$1:cat_id::VARCHAR(50) as category,
DATE($1:date::int ) as Date,
$1:"dept_id"::VARCHAR(50) as Dept_ID,
$1:"id"::VARCHAR(50) as ID,
$1:"item_id"::VARCHAR(50) as Item_ID,
$1:"state_id"::VARCHAR(50) as State_ID,
$1:"store_id"::VARCHAR(50) as Store_ID,
$1:"value"::int as value
FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;

```

## Loading PAQUET Data

- **Querying Parquet Data**  
  - Use `:` to refer to the objects in Parquet files for querying specific data.  
  - You can also transform the data types of the columns directly when querying the data.  

- **Adding Metadata**  
  - **File Name**: Query the file name using `metadata$filename`.  
  - **Row Number**: Query the row number in each file using `metadata$row_number`.  
  - **Timestamp**: Add the load timestamp with the function `SQL_TO_TIMESTAMP_NTZ()` (no time zone).  
    - If you don't use the `SQL_TO_TIMESTAMP_NTZ()` function, the timestamp will include the time zone.  

- **Timestamp Example**  
  - Using `SQL_TO_TIMESTAMP_NTZ()`: Timestamp will not include time zone.  
  - Without `SQL_TO_TIMESTAMP_NTZ()`: Timestamp will include time zone information.  

- **Creating the Destination Table**  
  - After querying and adding necessary metadata (e.g., row number, file name, timestamp), create a destination table.  
  - It's important to include **row number** and **timestamp** as defaults in the destination table to track the data.  

- **Loading Data into the Table**  
  - Use `INSERT INTO` with a **SELECT statement** to copy data into the destination table.  
  - Ensure no errors occurred during the data loading process.  

- **Best Practices**  
  - It’s recommended to load the raw data first into a staging table before transforming and copying it into the final table.  
  - This extra step helps with error tracking and gives more control over the data pipeline. However, it’s optional based on use case.  

- **Summary**  
  - You can efficiently query Parquet data, add metadata (file name, row number, timestamp), and load it into the final analytical table using Snowflake's SQL features.

```sql
    -- Adding metadata
    
SELECT 
$1:__index_level_0__::int as index_level,
$1:cat_id::VARCHAR(50) as category,
DATE($1:date::int ) as Date,
$1:"dept_id"::VARCHAR(50) as Dept_ID,
$1:"id"::VARCHAR(50) as ID,
$1:"item_id"::VARCHAR(50) as Item_ID,
$1:"state_id"::VARCHAR(50) as State_ID,
$1:"store_id"::VARCHAR(50) as Store_ID,
$1:"value"::int as value,
METADATA$FILENAME as FILENAME,
METADATA$FILE_ROW_NUMBER as ROWNUMBER,
TO_TIMESTAMP_NTZ(current_timestamp) as LOAD_DATE
FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE;


SELECT TO_TIMESTAMP_NTZ(current_timestamp);

   -- Create destination table

CREATE OR REPLACE TABLE OUR_FIRST_DB.PUBLIC.PARQUET_DATA (
    ROW_NUMBER int,
    index_level int,
    cat_id VARCHAR(50),
    date date,
    dept_id VARCHAR(50),
    id VARCHAR(50),
    item_id VARCHAR(50),
    state_id VARCHAR(50),
    store_id VARCHAR(50),
    value int,
    Load_date timestamp default TO_TIMESTAMP_NTZ(current_timestamp));

   -- Load the parquet data
   
COPY INTO OUR_FIRST_DB.PUBLIC.PARQUET_DATA
    FROM (SELECT 
            METADATA$FILE_ROW_NUMBER,
            $1:__index_level_0__::int,
            $1:cat_id::VARCHAR(50),
            DATE($1:date::int ),
            $1:"dept_id"::VARCHAR(50),
            $1:"id"::VARCHAR(50),
            $1:"item_id"::VARCHAR(50),
            $1:"state_id"::VARCHAR(50),
            $1:"store_id"::VARCHAR(50),
            $1:"value"::int,
            TO_TIMESTAMP_NTZ(current_timestamp)
        FROM @MANAGE_DB.EXTERNAL_STAGES.PARQUETSTAGE);
    
SELECT * FROM OUR_FIRST_DB.PUBLIC.PARQUET_DATA;

```

# Performance Optimisation

## Performance Considerations in Snowflake

- **Importance of Performance Optimization**  
  - Faster queries lead to cost savings since compute power is billed based on usage.  
  - Optimizing performance reduces the need for extensive compute resources, thus saving costs.

- **Traditional Optimization Techniques**  
  - **Indexes and Primary Keys**: Used to speed up query performance.  
  - **Table Partitions**: Helps in reducing full table scans for larger tables.  
  - **Query Execution Plans**: Analyzing and optimizing the query execution plan.  

- **Snowflake's Automated Optimizations**  
  - **Micro-Partitions**: Snowflake automatically manages partitions to optimize performance.  
  - **No Manual Optimization**: Many traditional tasks like index creation and partitioning are automated.  
  - **Focus on Data Design**: While many optimizations are handled by Snowflake, we can still enhance performance by focusing on data types, file splitting, and warehouse design.

- **Optimization Strategies in Snowflake**  
  - **Dedicated Warehouses**: Create warehouses for specific user groups based on their unique needs and query types.  
  - **Scaling**:  
    - **Scaling Up**: Increase the size of the warehouse for complex queries or heavy workloads.  
    - **Scaling Out (Multi-Cluster Warehouses)**: Add more clusters to handle varying or high concurrency workloads, useful for peak hours or more concurrent users.

- **Cluster Keys for Larger Tables**  
  - **Cluster Keys**: Used to improve query performance by optimizing how data is accessed, especially for large tables.

- **Caching Mechanism**  
  - **Understand Caching**: Maximizing the benefits of Snowflake’s caching mechanism can improve performance further.

- **Automatic Scaling**  
  - **Automatic Scaling**: Managed by Snowflake, but understanding how it works can help you design your usage patterns for maximum efficiency.  

## Create dedicated virtual warehouse for different user groups or work groups

- **Purpose of Dedicated Warehouses**: 
  - Tailored for different teams or applications with varying workloads, such as BI teams, database admins, and data scientists.
  - Ensures the right size and type of warehouse for specific needs, improving performance.

- **Steps for Implementation**:
  1. **Identify User Groups**: Start by identifying different departments or teams (e.g., marketing, BI, data science).
  2. **Create Dedicated Warehouses**: Set up individual warehouses for each team or group with specific requirements.
  3. **Assign Users**: Assign users or groups to the corresponding dedicated warehouse.

- **Considerations**:
  - **Avoid Too Many Warehouses**: Creating too many fine-grained warehouses can lead to inefficient use (starting and suspending frequently, leading to higher costs).
  - **Group Similar Teams**: Instead of creating separate warehouses for very small teams, group similar teams together based on their workload.
  - **Review and Refine**: Regularly review the warehouse setup and refine it based on evolving team needs and workload patterns.

- **Optimizing Cost**: 
  - By avoiding underutilized warehouses and managing scaling efficiently, cost savings can be achieved.

- **Review Process**: Warehouse setup should be refined over time to ensure it matches workload and usage patterns.


## Implement dedicated virtual warehouse

- **Scenario Overview**:
  - Two user groups identified: **Data Scientists** and **Database Administrators (DBAs)**.
  - Data scientists need a **larger warehouse** (size: small), and DBAs need a **smaller warehouse** (size: extra small).

- **Creating Warehouses**:
  - Use `CREATE WAREHOUSE` command to set up the warehouses.
  - Example for Data Science Warehouse:  
    - Warehouse size: **small**  
    - Scaling policy: **standard**  
    - Suspend time: **5 minutes**  
    - Resume time: **True**
  - Example for DBA Warehouse:  
    - Warehouse size: **extra small**  
    - Same settings as the Data Science Warehouse.
  - Alternatively, warehouses can be created using the **Snowflake UI** (Admin section).

- **Assigning Warehouses to Roles**:
  1. Create roles for each group: **Data Scientist** and **DBA**.
  2. Grant **USAGE** permissions on the respective warehouse to the roles using `GRANT USAGE ON WAREHOUSE`.

- **Creating Users**:
  - Use `CREATE USER` to set up users (e.g., Data Scientist 1).
  - Set the **default role** for users and assign them to their respective warehouse.
  - If **auto resume** is set to **True**, the warehouse will automatically start when the user executes a query.

- **Testing Access**:
  - Log in as a user (e.g., **Data Scientist 1**) and confirm access to the assigned warehouse.
  - In Snowflake UI, the warehouse is accessible under the user’s role.

- **Best Practices**:
  - After testing, **drop** all created objects (roles, users, warehouses) to avoid unnecessary resource consumption.
  - Follow this method to ensure that the users in different roles have access to the appropriate warehouse.

This setup allows for efficient resource allocation and ensures each group gets the correct performance capabilities.

```sql
//  Create virtual warehouse for data scientist & DBA

// Data Scientists
CREATE WAREHOUSE DS_WH 
WITH WAREHOUSE_SIZE = 'SMALL'
WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 300 
AUTO_RESUME = TRUE 
MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 1 
SCALING_POLICY = 'STANDARD';

// DBA
CREATE WAREHOUSE DBA_WH 
WITH WAREHOUSE_SIZE = 'XSMALL'
WAREHOUSE_TYPE = 'STANDARD' 
AUTO_SUSPEND = 300 
AUTO_RESUME = TRUE 
MIN_CLUSTER_COUNT = 1 
MAX_CLUSTER_COUNT = 1 
SCALING_POLICY = 'STANDARD';


// Create role for Data Scientists & DBAs

CREATE ROLE DATA_SCIENTIST;
GRANT USAGE ON WAREHOUSE DS_WH TO ROLE DATA_SCIENTIST;

CREATE ROLE DBA;
GRANT USAGE ON WAREHOUSE DBA_WH TO ROLE DBA;


// Setting up users with roles

// Data Scientists
CREATE USER DS1 PASSWORD = 'DS1' LOGIN_NAME = 'DS1' DEFAULT_ROLE='DATA_SCIENTIST' DEFAULT_WAREHOUSE = 'DS_WH'  MUST_CHANGE_PASSWORD = FALSE;
CREATE USER DS2 PASSWORD = 'DS2' LOGIN_NAME = 'DS2' DEFAULT_ROLE='DATA_SCIENTIST' DEFAULT_WAREHOUSE = 'DS_WH'  MUST_CHANGE_PASSWORD = FALSE;
CREATE USER DS3 PASSWORD = 'DS3' LOGIN_NAME = 'DS3' DEFAULT_ROLE='DATA_SCIENTIST' DEFAULT_WAREHOUSE = 'DS_WH'  MUST_CHANGE_PASSWORD = FALSE;

GRANT ROLE DATA_SCIENTIST TO USER DS1;
GRANT ROLE DATA_SCIENTIST TO USER DS2;
GRANT ROLE DATA_SCIENTIST TO USER DS3;

// DBAs
CREATE USER DBA1 PASSWORD = 'DBA1' LOGIN_NAME = 'DBA1' DEFAULT_ROLE='DBA' DEFAULT_WAREHOUSE = 'DBA_WH'  MUST_CHANGE_PASSWORD = FALSE;
CREATE USER DBA2 PASSWORD = 'DBA2' LOGIN_NAME = 'DBA2' DEFAULT_ROLE='DBA' DEFAULT_WAREHOUSE = 'DBA_WH'  MUST_CHANGE_PASSWORD = FALSE;

GRANT ROLE DBA TO USER DBA1;
GRANT ROLE DBA TO USER DBA2;

// Drop objects again

DROP USER DBA1;
DROP USER DBA2;

DROP USER DS1;
DROP USER DS2;
DROP USER DS3;

DROP ROLE DATA_SCIENTIST;
DROP ROLE DBA;

DROP WAREHOUSE DS_WH;
DROP WAREHOUSE DBA_WH;
```

## Scaling Up/Down

- **Scaling Up vs. Scaling Down**:
  - **Scaling Up**: Increasing the size of the warehouse to handle more **complex queries**.
  - **Scaling Down**: Decreasing the size of the warehouse when the workload becomes less complex.

- **Choosing the Appropriate Size**:
  - It is important to choose the right warehouse size based on workload complexity to avoid wasting resources or slowing down performance.
  - **ETL Processes**: Adjust warehouse size based on the complexity of the ETL workload.
  - **Workload Changes**: Scale the warehouse up or down depending on workload fluctuations at different times.

- **Scaling Up for Query Complexity**:
  - Scaling up is mostly about **increasing capacity to handle more complex queries** (not necessarily more users).
  - **Not about more users**: Scaling up deals with the complexity of the queries; scaling out (adding clusters) is for more concurrent users.

- **Practical Demonstration**:
  - To **scale up** a warehouse:
    1. Use the `ALTER WAREHOUSE` command and set the warehouse size.
    2. Example: From "extra small" to "small" using:
       ```sql
       ALTER WAREHOUSE compute_warehouse SET WAREHOUSE_SIZE = 'SMALL';
       ```
    3. This change will be reflected immediately.

  - **Scaling Down**: Same approach, just set the size to a smaller one.

- **Scaling in Snowflake UI**:
  - Navigate to the **Admin section** and click on **Warehouses**.
  - Select the warehouse and click **edit** to change the size via the UI (e.g., from "small" to "extra small").

- **Important Note**:
  - **Scaling Up** improves performance by handling complex queries faster, while **scaling down** helps save resources when the workload is less complex.

## Scaling Out

- **Scaling Up vs. Scaling Out:**
  - **Scaling Up**: Increases the size of the warehouse (CPU, memory, etc.) to handle more complex queries.
  - **Scaling Out**: Adds more clusters to a multi-cluster warehouse to handle high volumes of concurrent queries and improve performance during periods of high user activity.

- **Multi-cluster Warehouse:**
  - Dynamically adds clusters to manage increased resource demand during high query volumes.
  - **Auto-scaling**: Automatically adjusts the number of active clusters based on the workload, removing the need for manual scaling.

- **Scaling Policies:**
  - **Standard Scaling Policy**: Adds clusters more quickly when the workload exceeds current capacity.
  - **Economy Scaling Policy**: Adds clusters more slowly to conserve resources and reduce costs.

- **Best Practices:**
  - Use **multi-cluster warehouses** by default if you have access to the **Enterprise Edition** or higher for dynamic scaling without managing multiple smaller warehouses.
  - Set the **maximum number of clusters** high enough to handle peak workloads, but avoid limiting it unnecessarily to ensure faster query processing.

- **Practical Demonstration:**
  - A multi-cluster warehouse was created with **three clusters** and set to **Standard Scaling Policy**.
  - **Computationally intensive queries** were executed to simulate high concurrency, triggering **auto-scaling** as the number of active queries increased.

- **Code to Scale Out a Warehouse:**
  - Example SQL to create a multi-cluster warehouse:
  ```sql
  CREATE WAREHOUSE my_multi_cluster_warehouse
    WITH WAREHOUSE_SIZE = 'SMALL'
    WAREHOUSE_TYPE = 'STANDARD'
    MIN_CLUSTER_COUNT = 1
    MAX_CLUSTER_COUNT = 3
    SCALING_POLICY = 'STANDARD';
  ```
  - This creates a warehouse with:
    - Starting size: **SMALL**
    - Minimum clusters: **1**
    - Maximum clusters: **3**
    - **Standard scaling policy** for auto-scaling.

- **Admin Interface for Scaling Out:**
  - Navigate to **Admin** > **Warehouses** in Snowflake.
  - Set the **Number of Clusters** to **3** and choose the **Scaling Policy** (Standard or Economy).
  - Save the settings.

- **Monitoring Scaling Out:**
  - Monitor scaling by checking the **Warehouses** section. Snowflake automatically adds clusters as needed, reducing query queuing.

- **Cost Considerations:**
  - **Scaling out** balances performance and cost by distributing the load across multiple clusters, preventing unnecessary overhead.
  - Set warehouses to auto-scale for periods of high user activity to reduce manual intervention and optimize resources.

This demonstrates how Snowflake dynamically scales out by adding clusters to manage increasing workloads, improving both performance and cost efficiency.

```sql
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_SITE T1
CROSS JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_SITE T2
CROSS JOIN SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_SITE T3
CROSS JOIN (SELECT TOP 57 * FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.WEB_SITE)  T4;
```

## Caching

- **Caching Overview**:
  - Caching in Snowflake is an **automated process** that stores query results to speed up execution.
  - Once a query is executed, its result is **cached** and can be reused without reprocessing, improving performance.

- **Caching Duration**:
  - Cached results are stored for **24 hours** or until the **underlying data changes**.
  - If data in the table changes, Snowflake will execute the query again instead of using outdated cached results.

- **Cache Validity**:
  - Snowflake automatically ensures that cached results are **valid**, meaning they are only reused if the underlying data hasn't changed.
  - If data changes, Snowflake will re-execute the query to ensure accurate results.

- **User Interaction with Caching**:
  - Users **cannot directly control** the cache but can optimize caching by ensuring **similar queries are run on the same warehouse**.
  - Caching benefits are maximized when **similar queries** are executed in the same warehouse, especially in cases where the same set of data is queried repeatedly (e.g., by a team of data scientists).

- **Warehouse Usage for Caching**:
  - To **maximize caching efficiency**, ensure that similar queries are directed to the **same warehouse**.
  - **Dedicated warehouses** for specific teams or workloads can help leverage caching by running similar queries together.

- **Benefits of Caching**:
  - **Improves performance** by reducing the need to re-execute identical or similar queries.
  - **Automatic management** of caching simplifies performance optimization for users.

- **Practical Use**:
  - While caching is automatic, users should consider directing similar queries to the same warehouse for optimal use of cached results.

### Summary:
Snowflake's automatic caching process can significantly improve query performance by reusing results for identical or similar queries. To optimize this, ensure similar queries run on the same warehouse, especially when dealing with recurring workloads or similar datasets.

## Maximize Caching

- **Initial Query Execution**:
  - When a query is run for the first time, it may take longer to execute, especially for more complex queries (e.g., scanning large tables).
  - Example: A query on a large table (100 million rows) took **1.4 seconds** to run for the first time.

- **Query Profile Analysis**:
  - After executing the query, we can view the **query profile** to see where most time was spent.
  - In the example, **97% of the time was spent on scanning the table** (120MB), and the rest was spent on aggregation.

- **Subsequent Query Execution**:
  - Re-running the same query with the **same warehouse** results in **faster execution**, as Snowflake utilizes **cached results**.
  - Example: The second execution took only **110 milliseconds**, demonstrating the benefit of cached results.

- **Using Different Users**:
  - Even if a **different user** executes the same query, as long as they use the **same warehouse**, they can also benefit from cached results.
  - Example: After setting up a new user and role, the query executed by this new user took **115 milliseconds**, benefiting from query result reuse.

- **Maximizing Caching Efficiency**:
  - To maximize the benefit of caching, ensure that **similar queries** are executed on **the same warehouse**. This enables the cache to be reused and improves performance.
  
- **Clean-up**:
  - It's important to **drop roles** and **users** after they are no longer needed to maintain a clean environment.

### Summary:
Caching in Snowflake can significantly speed up query execution by reusing results from previous queries. By running similar queries on the same warehouse, you maximize the benefit of caching. Additionally, cached results can be shared across different users as long as they use the same warehouse and the data hasn’t changed within 24 hours.

```sql

SELECT AVG(C_BIRTH_YEAR) FROM SNOWFLAKE_SAMPLE_DATA.TPCDS_SF100TCL.CUSTOMER

// Setting up an additional user
CREATE ROLE DATA_SCIENTIST;
GRANT USAGE ON WAREHOUSE COMPUTE_WH TO ROLE DATA_SCIENTIST;

CREATE USER DS1 PASSWORD = 'DS1' LOGIN_NAME = 'DS1' DEFAULT_ROLE='DATA_SCIENTIST' DEFAULT_WAREHOUSE = 'DS_WH'  MUST_CHANGE_PASSWORD = FALSE;
GRANT ROLE DATA_SCIENTIST TO USER DS1;

```

## Clustering

- **Cluster Keys Overview**:
  - Cluster keys are a technique in Snowflake used to optimize query performance by organizing data into **micro-partitions**.
  - They help **avoid full table scans**, reducing the time spent searching through large datasets to find relevant data.
  - Snowflake **automatically manages** clustering, ensuring optimal performance without user intervention.

- **How Cluster Keys Work**:
  - Based on the chosen cluster key column(s), data is grouped into partitions (micro-partitions).
  - When querying, Snowflake can focus only on relevant micro-partitions, rather than scanning the entire table.
  
- **Benefits**:
  - This is particularly beneficial for **large tables**, especially when the data size spans terabytes.
  - **Cluster keys** improve performance by reducing the time spent searching data.

- **Customizing Cluster Keys**:
  - Snowflake provides control to manually define **custom cluster keys** for specific use cases, especially when automatic clustering might not be optimal.
  - For example, if querying frequently by **event date**, clustering by **event date** instead of **event ID** may improve query speed.

- **Choosing the Right Cluster Key**:
  - Select columns frequently used in **WHERE clauses** (e.g., **date columns** if you're often filtering by date).
  - Columns frequently used in **joins** are also good candidates.
  - Avoid columns with too many distinct values (e.g., unique IDs) or too few distinct values (e.g., boolean values).

- **Cluster Key Implementation**:
  - Cluster keys are specified during table creation using the **CLUSTER BY** statement.
  - **Multiple columns** can be clustered together, and **expressions** can also be used (e.g., clustering by month instead of date).
  - Cluster keys can also be **modified** later using **ALTER TABLE** and can be **dropped** if needed.

- **Key Considerations**:
  - **Clustering** works best for **large datasets**, particularly those where **data scanning** is a significant performance bottleneck.
  - It is important to choose **appropriate clustering columns** based on the data’s usage patterns.

- **Summary**:
  - **Clustering** in Snowflake is an important technique for **optimizing performance**, especially with large tables.
  - Snowflake **automatically handles clustering** but offers flexibility for users to **customize** the cluster keys based on query needs.

## Clustering in practice

- **Cluster Key Setup**:
  - Begin by creating a table (e.g., `ORDERS_CACHING`) with sample data, including a date column.
  - You may also use `CROSS JOINS` to expand the data size for testing.

- **Performance Without Cluster Key**:
  - Initially, test the performance without any cluster key, which may involve scanning the entire table.
  - For example, a query might take around **half a second**, with **59 partitions** scanned in the query profile, indicating that no cluster key is set up for optimal performance.

- **Changing Cluster Key**:
  - After identifying the cluster key, alter the table to apply a new cluster key.
  - This operation is **metadata-based** and may take some time to reflect in the micro-partitions (usually **30 to 60 minutes**).

- **Performance After Cluster Key Change**:
  - After waiting for the cluster key to take effect, running the query again may show an **improvement in scan time**.
  - For instance, if the table now only scans **one partition**, this is called **partition pruning**, significantly speeding up the query.

- **Partition Pruning**:
  - With the correct cluster key, only relevant micro-partitions are scanned, reducing query time.
  - This is especially useful for large tables, where scanning entire tables could be slow.

- **Expression-Based Cluster Keys**:
  - Snowflake allows clustering not only by single columns but also by **expressions** (e.g., using `MONTH(DATE)`).
  - If certain expressions are commonly used in **WHERE clauses** or **joins**, clustering by those expressions can provide further optimization.
  
- **Query-Specific Cluster Keys**:
  - Cluster keys should be chosen based on the **queries** that are run most frequently.
  - Different types of queries may benefit from different cluster keys.
  - Experimenting and understanding the queries in use may require **trial and error** to find the best cluster key.

- **Conclusion**:
  - While clustering can improve performance significantly by reducing table scans, the optimal cluster key varies based on the query patterns.
  - Choosing the right cluster key requires understanding both the structure of the data and the common queries run on it.
  
```sql
  // Publicly accessible staging area    

CREATE OR REPLACE STAGE MANAGE_DB.external_stages.aws_stage
    url='s3://bucketsnowflakes3';

// List files in stage

LIST @MANAGE_DB.external_stages.aws_stage;

//Load data using copy command

COPY INTO OUR_FIRST_DB.PUBLIC.ORDERS
    FROM @MANAGE_DB.external_stages.aws_stage
    file_format= (type = csv field_delimiter=',' skip_header=1)
    pattern='.*OrderDetails.*';
    

// Create table

CREATE OR REPLACE TABLE ORDERS_CACHING (
ORDER_ID	VARCHAR(30)
,AMOUNT	NUMBER(38,0)
,PROFIT	NUMBER(38,0)
,QUANTITY	NUMBER(38,0)
,CATEGORY	VARCHAR(30)
,SUBCATEGORY	VARCHAR(30)
,DATE DATE)   ; 


INSERT INTO ORDERS_CACHING 
SELECT
t1.ORDER_ID
,t1.AMOUNT	
,t1.PROFIT	
,t1.QUANTITY	
,t1.CATEGORY	
,t1.SUBCATEGORY	
,DATE(UNIFORM(1500000000,1700000000,(RANDOM())))
FROM ORDERS t1
CROSS JOIN (SELECT * FROM ORDERS) t2
CROSS JOIN (SELECT TOP 100 * FROM ORDERS) t3;

// Query Performance before Cluster Key

SELECT * FROM ORDERS_CACHING  WHERE DATE = '2020-06-09';

// Adding Cluster Key & Compare the result

ALTER TABLE ORDERS_CACHING CLUSTER BY ( DATE ) ;

SELECT * FROM ORDERS_CACHING  WHERE DATE = '2020-01-05';


// Not ideal clustering & adding a different Cluster Key using function

SELECT * FROM ORDERS_CACHING  WHERE MONTH(DATE)=11;

ALTER TABLE ORDERS_CACHING CLUSTER BY ( MONTH(DATE) );
```

### Loading Data from GCP

- **Creating a Bucket in GCP**  
  - Navigate to the home ribbon; if not visible, open the menu.  
  - Search for "Cloud Storage" and select it.  
  - Click on "Create a bucket."  
  - Assign a globally unique name (e.g., "Snowflake bucket GCP").  
  - Leave default settings (region, access control).  
  - Click to create the bucket.  

- **Creating Additional Buckets**  
  - Navigate back and create another bucket.  
  - Example: One bucket for CSV files, another for JSON files.  
  - Name the second bucket accordingly (e.g., "Snowflake bucket GCP JSON").  
  - Keep default settings and complete the creation.  

- **Uploading Files to Buckets**  
  - Select a bucket and choose "Upload files."  
  - Upload the *World Happiness Report* to the first bucket.  
  - Upload a JSON file to the second bucket.  

- **Next Steps**  
  - Set up a connection between GCP and Snowflake using an integration object (covered in the next lecture).

  ### Create integration object

- **Create a Storage Integration in Snowflake**  
  - Use the name `gcp_integration`.  
  - Set the cloud provider to Google Cloud (`GCS`).  
  - Ensure the integration is enabled by default.  
  - Provide the path: specify either a direct path or full access to the entire bucket.  
  - Add both bucket names to the allowed locations.  

- **Retrieve Bucket Names from GCP**  
  - Navigate to **Cloud Storage** in GCP.  
  - Locate the storage account and copy the names of the two buckets.  
  - Paste the bucket names into the Snowflake storage integration settings.  

- **Describe the Storage Integration Object in Snowflake**  
  - View properties like **allowed locations** and **blocked locations**.  
  - Identify the **GCP service account** that Snowflake creates.  
  - Copy the service account ID for permission assignment.  

- **Grant Permissions in GCP**  
  - Go to the **GCP Storage Account**.  
  - Select both buckets and navigate to **Permissions**.  
  - Add a **new principal** (the Snowflake service account).  
  - Assign the **Storage Admin** role (needed for data unloading later).  
  - Save the changes.  

- **Next Steps**  
  - Test the integration to ensure access.  
  - Load data from GCP into Snowflake.  
  - Try unloading data from Snowflake back to GCP (covered in the next lecture).

```sql
-- create integration object that contains the access information
CREATE STORAGE INTEGRATION gcp_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = GCS
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('gcs://snow_csv_files', 'gcs://snow_json_files');

  
-- Describe integration object to provide access
DESC STORAGE integration gcp_integration;

```

### Create Stage

- **Set Up File Format Object**  
  - Create a **CSV file format object** in Snowflake.  
  - Set the **header to be skipped (set to 1)** since the file has a header.  

- **Create a Stage in Snowflake**  
  - Use the **storage integration** created earlier.  
  - Point to the correct **GCP bucket** (e.g., `snowflakebucketgcp`).  
  - Ensure the bucket URL is correctly replaced for your environment.  

- **Test the Integration**  
  - List the files in the GCP bucket from Snowflake.  
  - Verify that the files appear as expected.  

- **Next Steps**  
  - Query the file data in Snowflake.  
  - Copy data from the file into Snowflake tables.  
  - Unload data from Snowflake tables back into GCP.  
  - Explore bidirectional data movement in the upcoming lectures.

```sql
-- create file format
create or replace file format exercise_db.public.fileformat_gcp
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1;

-- create stage object
create or replace stage exercise_db.public.stage_gcp
    STORAGE_INTEGRATION = gcp_integration
    URL = 'gcs://snow_csv_files'
    FILE_FORMAT = fileformat_gcp;

LIST @exercise_db.public.stage_gcp;
```

### Query & load data

- **Query the File in GCP**  
  - Ensure the file is available in the bucket.  
  - Modify the **file format object** to **not skip the header (set to 0)**.  
  - Query the file to inspect column names.  

- **Create and Populate the Table in Snowflake**  
  - Define a **happiness table** with appropriate columns and data types.  
  - Use the **COPY command** to load data from the staged file into the table.  

- **Debug Data Load Issues**  
  - If errors occur (e.g., unrecognized column values), adjust the **file format object**.  
  - Replace the file format object and reattempt the data copy.  

- **Verify Data Load**  
  - Select data from the newly created table to ensure proper loading.  

- **Unload Data from Snowflake to GCP**  
  - Leverage the **storage integration object** with its **admin role**.  
  - Prepare for unloading data from Snowflake tables into files stored in GCP.  
  - Further details on unloading will be covered in the next lecture.

```sql
---- Query files & Load data ----

--query files
SELECT 
$1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,
$12,$13,$14,$15,$16,$17,$18,$19,$20
FROM @exercise_db.public.stage_gcp;


create or replace table happiness (
    country_name varchar,
    regional_indicator varchar,
    ladder_score number(4,3),
    standard_error number(4,3),
    upperwhisker number(4,3),
    lowerwhisker number(4,3),
    logged_gdp number(5,3),
    social_support number(4,3),
    healthy_life_expectancy number(5,3),
    freedom_to_make_life_choices number(4,3),
    generosity number(4,3),
    perceptions_of_corruption number(4,3),
    ladder_score_in_dystopia number(4,3),
    explained_by_log_gpd_per_capita number(4,3),
    explained_by_social_support number(4,3),
    explained_by_healthy_life_expectancy number(4,3),
    explained_by_freedom_to_make_life_choices number(4,3),
    explained_by_generosity number(4,3),
    explained_by_perceptions_of_corruption number(4,3),
    dystopia_residual number (4,3));
    
    
COPY INTO HAPPINESS
FROM @exercise_db.public.stage_gcp;

SELECT * FROM HAPPINESS;
```

### Unload data

- **Understand Data Unloading in Snowflake**  
  - Unloading moves data from a **Snowflake table** to an **external cloud provider (GCP bucket)**.  
  - Data is saved as a **CSV file** in a specified storage location.  

- **Verify Required Permissions & Setup**  
  - Ensure **ACCOUNTADMIN role** is in use.  
  - Confirm usage of **DEMO_DB** (or appropriate database).  
  - The **STORAGE_INTEGRATION** object and **FILE_FORMAT object** should already be created.  
  - Set up the **stage** pointing to the GCP bucket, including a new subfolder for data storage.  

- **Modify Storage Integration if Needed**  
  - Use `ALTER STORAGE_INTEGRATION` to update properties like `allowed_locations`.  

- **Unload Data Using COPY INTO Command**  
  - Preview the data to be unloaded.  
  - Use `COPY INTO` to transfer data from the **table** to the **stage** (GCP bucket).  
  - Verify successful execution via output details (e.g., `rows_unloaded`, `input_bytes`, `output_bytes`).  

- **Compression & Storage Verification**  
  - By default, data is **automatically compressed**.  
  - Compression type can be manually specified (e.g., `GZIP`).  
  - Refresh the **GCP bucket** to confirm data is stored correctly.  

- **Access & Download the Data**  
  - Locate the new folder in the GCP bucket.  
  - Verify the unloaded file and its compression format.  
  - Download the file if needed.  

- **Summary**  
  - The **COPY INTO** command is used for both **loading and unloading** data.  
  - Reversing source/destination switches between **importing to Snowflake** and **exporting to GCP**.  
  - Ensure proper permissions and compression settings for optimal data handling.  

```sql
------- Unload data -----
USE ROLE ACCOUNTADMIN;
USE DATABASE EXERCISE_DB;


-- create integration object that contains the access information
CREATE STORAGE INTEGRATION gcp_integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = GCS
  ENABLED = TRUE
  STORAGE_ALLOWED_LOCATIONS = ('gcs://snow_csv_files', 'gcs://snow_json_files');
  
  
-- create file format
create or replace file format exercise_db.public.fileformat_gcp
    TYPE = CSV
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1;

-- create stage object
create or replace stage exercise_db.public.stage_gcp
    STORAGE_INTEGRATION = gcp_integration
    URL = 'gcs://snow_csv_files/csv_happiness'
    FILE_FORMAT = fileformat_gcp;


ALTER STORAGE INTEGRATION gcp_integration
SET  storage_allowed_locations=('gcs://snow_csv_files', 'gcs://snow_json_files');

SELECT * FROM HAPPINESS;

COPY INTO @stage_gcp
FROM
HAPPINESS;
```