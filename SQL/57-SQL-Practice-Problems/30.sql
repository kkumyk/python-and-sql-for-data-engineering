-- 30. Customers with no orders

-- MS SQL Server

Select
    Customers_CustomerID = Customers.CustomerID,
    Orders_CustomerID = Orders.CustomerID
From Customers
    left join Orders
        on Orders.CustomerID = Customers.CustomerID
Where
    Orders.CustomerID is null


/*Learnings:

This query is called a left outer join because the table mentioned on the left of the join operator will have each of its rows in the output at least once,
whereas the table on the right will only have those rows output that match some row of the left table.
When outputting a left-table row for which there is no right-table match, empty (null) values are substituted for the right-table columns.

*/