-- 024. Customer list by region

-- MS SQL Server

Select CustomerID, CompanyName, Region
From Customers
Order by
    Case
        when Region is null then 1
        else 0
    End
    , Region, CustomerID

/*
Learnings:
Include Case expression in the Order By clause and add the additional fields for sorting such as Region and CustomerID.

If we need to see the sorting field in the output, you would not need to repeat the case statement in the Order by,
you can just refer to the alias - RegionOrder:
*/
Select CustomerID, CompanyName, Region, RegionOrder = 
                                            Case
                                            when Region is null then 1
                                            else 0
                                            End
From Customers
Order By RegionOrder, Region, CustomerID

-- PostgreSQL

SELECT CustomerID, CompanyName, Region
FROM Customers
ORDER BY
    CASE
        WHEN Region iS NULL THEN 1
        ELSE 0
    END,
    Region, CustomerID;

-- the same with the sorting field included in the output:

SELECT CustomerID, CompanyName, Region,
    CASE
        WHEN Region IS NULL THEN 1
        ELSE 0
        END AS RegionOrder
FROM Customers
ORDER BY
    RegionOrder, Region, CustomerID;