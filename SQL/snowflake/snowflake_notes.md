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