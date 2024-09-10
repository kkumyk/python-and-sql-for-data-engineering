-- 29. Employee/Order detail report (join four tables)

-- MS SQL Server
SELECT
    Employees.EmployeeID, 
    Employees.LastName,
    Orders.OrderID,
    Products.ProductName,
    OrderDetails.Quantity
FROM Employees
    JOIN Orders
        ON Orders.EmployeeID = Employees.EmployeeID
    JOIN OrderDetails
        ON Order.OrderID = OrderDetails.OrderID
    JOIN Products
        ON Products.ProductID = OrderDetails.ProductID
ORDER BY
    Orders.OrderID, Products.ProductID