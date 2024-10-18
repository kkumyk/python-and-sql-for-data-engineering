/* 024. Customer list by region
- list all customers from all regions alphabetically
- move customers with no region to the end
- sort companies within the same region by customer ID.  

Customers:
 customerid |            companyname             |  contactname   |     contacttitle     |            address            |    city     | region | postalcode | country |    phone     |     fax      
------------+------------------------------------+----------------+----------------------+-------------------------------+-------------+--------+------------+---------+--------------+--------------
 ALFKI      | Alfreds Futterkiste                | Maria Anders   | Sales Representative | Obere Str. 57                 | Berlin      |        | 12209      | Germany | 030-0074321  | 030-0076545
 ANATR      | Ana Trujillo Emparedados y helados | Ana Trujillo   | Owner                | Avda. de la Constitución 2222 | México D.F. |        | 05021      | Mexico  | (5) 555-4729 | (5) 555-3745
 ANTON      | Antonio Moreno Taquería            | Antonio Moreno | Owner                | Mataderos  2312               | México D.F. |        | 05023      | Mexico  | (5) 555-3932 | 
(3 rows)

Expected Result:
 customerid |             companyname              |    region     
------------+--------------------------------------+---------------
 OLDWO      | Old World Delicatessen               | AK
 BOTTM      | Bottom-Dollar Markets                | BC
 LAUGB      | Laughing Bacchus Wine Cellars        | BC 
 ...
 WARTH      | Wartian Herkku                       | 
 WILMK      | Wilman Kala                          | 
 WOLZA      | Wolski  Zajazd                       | 
(91 rows)
*/

SELECT CustomerID, CompanyName, Region
FROM Customers
ORDER BY
    CASE
        WHEN Region iS NULL THEN 1
        ELSE 0
    END,
    Region, CustomerID;

/*
The same with the sorting field included in the output:

 customerid |             companyname              |    region     | regionorder 
------------+--------------------------------------+---------------+-------------
 OLDWO      | Old World Delicatessen               | AK            |           0
 BOTTM      | Bottom-Dollar Markets                | BC            |           0
 LAUGB      | Laughing Bacchus Wine Cellars        | BC            |           0
...
 WARTH      | Wartian Herkku                       |               |           1
 WILMK      | Wilman Kala                          |               |           1
 WOLZA      | Wolski  Zajazd                       |               |           1
(91 rows)
*/

SELECT CustomerID, CompanyName, Region
    CASE
        WHEN Region IS NULL THEN 1
        ELSE 0
        END AS RegionOrder
FROM Customers
ORDER BY
    RegionOrder, Region, CustomerID;


/* Learnings:

I. Include Case expression in the Order By clause and add the additional fields for sorting such as Region and CustomerID.

If we need to see the sorting field in the output, you would not need to repeat the case statement in the Order by,
you can just refer to the alias - RegionOrder:


II. Zero-Null Case Trick in SQL

- handles NULL values when summing, counting, or aggregating data;
- replaces missing data with 0 instead of showing that this data is ignored;

SQL Query for Coffee Shop Sales Example

We have a table called sales_data that tracks daily sales. It contains columns for:
    - year,
    - month,
    - coffee_type (where 1 represents specialty coffee and 0 represents regular coffee), and 
    - sales (the total sales amount for the day).

year	month	day	coffee_type	sales
2023	01	01	1	150
2023	01	01	0	100
2023	01	02	1	200...

Group the data by year and month to show the sales breakdown for each month starting from the year 2020.

SELECT year, month,
SUM(CASE WHEN coffee_type = 1 THEN sales ELSE 0 END) as specialty_coffee_sales, # calculates the total sales for specialty coffee
SUM(CASE WHEN coffee_type = 0 THEN sales ELSE 0 END) as regular_coffee_sales    # calculates the total sales for regular coffee
FROM sales_data
WHERE year >= 2020
GROUP BY year, month;

Output result:
year	month	specialty_coffee_sales	regular_coffee_sales
2023	01	    350	                    220
2023	02	    180	                    90
2022	12	    220 	                130                 

Focus: CASE expression
*/
