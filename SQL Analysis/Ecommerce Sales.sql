-- Q1. From Customers, display customers whose Score is greater than 500. Show CustomerID, FirstName, Country and Score.
SELECT 
    CustomerID, FirstName, Country, Score
FROM
    customers
WHERE
    Score > 500;

-- Q2. Find employees whose Salary is greater than 50,000 and whose Department is Marketing. Display their names, department and salary.
SELECT 
    FirstName, department, salary
FROM
    employees
WHERE
    salary > 50000
        AND department = 'Marketing';

-- Q3. Find orders whose OrderStatus is Shipped or Delivered. Display OrderID, OrderStatus and Sales.
SELECT 
    OrderID, OrderStatus, Sales
FROM
    Orders
WHERE
    OrderStatus IN ('Shipped' , 'Delivered');

-- Q4. Display products whose Category is either Accessories or Clothing.
SELECT 
    Product
FROM
    salesdb.Products
WHERE
    Category IN ('Accessories' , 'Clothing');

-- Q5. Find employees whose salary is between 55,000 and 80,000, inclusive.
SELECT 
    *
FROM
    Employees
WHERE
    Salary BETWEEN 55000 AND 80000;

-- Q6. Find customers whose FirstName starts with the letter M.
SELECT 
    FirstName
FROM
    customers
WHERE
    FirstName LIKE 'M%';

-- Q7. Find records where LastName is missing. Display the customer ID and first name.
SELECT 
    customers.customerid, FirstName
FROM
    customers
WHERE
    lastname IS NULL;

-- Q8. Count the number of orders for each OrderStatus. Display the status and order count.
SELECT 
    OrderStatus, COUNT(Orderid) Total_Orders
FROM
    orders
GROUP BY OrderStatus;

-- Q9. calculate total sales and average sales for each ProductID.
SELECT 
    ProductID,
    SUM(sales) Total_Sales,
    ROUND(AVG(Sales), 0) Avg_Sales
FROM
    orders
GROUP BY ProductID;

-- Q10. Find CustomerID values whose total Sales is greater than 30. Display the customer ID and total sales.
SELECT 
    CustomerID, SUM(Sales) Total_Sales
FROM
    orders
GROUP BY CustomerID
HAVING Total_Sales > 30;

-- Q11. Display OrderID, CustomerID, customer FirstName and Sales for orders with matching customer records.
SELECT 
    o.OrderID, o.CustomerID, c.FirstName, o.Sales
FROM
    salesdb.orders AS o
        INNER JOIN
    salesdb.customers AS c ON o.CustomerID = c.CustomerID;

-- Q12. Display OrderID, product name, category, quantity and sales.
SELECT 
    o.OrderID, p.Product, p.Category, o.Quantity, o.Sales
FROM
    salesdb.orders AS o
        LEFT JOIN
    salesdb.products AS p ON o.productid = p.productid;

-- Q13. Use Orders.SalesPersonID and Employees.EmployeeID to display each order's ID, sales amount and salesperson's name.
SELECT 
    o.OrderID, o.Sales, e.firstname
FROM
    salesdb.orders AS o
        LEFT JOIN
    salesdb.employees AS e ON o.salespersonid = e.employeeid;

-- Q14. Display customer names and their order IDs, showing only customers who have matching orders.
SELECT 
    c.FirstName, o.OrderID
FROM
    Orders AS o
        JOIN
    customers AS c ON o.CustomerID = c.CustomerID;

-- Q15. Display each product name and its associated order IDs. Include the product category.
SELECT 
    p.Product, o.OrderId, p.category
FROM
    products AS p
        LEFT JOIN
    orders o ON p.productid = o.productid;

-- Q16. Display all customers and their order IDs. Customers without orders must also appear.
SELECT 
    c.FirstName, o.OrderID
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customerid = o.customerid;

-- Q17. Find customers who have no matching records in Orders.
SELECT 
    c.FirstName, o.OrderID
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customerid = o.customerid
WHERE
    o.OrderID IS NULL;

-- Q18. Display all products that have no matching order records. Return the product ID, product name and category.
SELECT 
    p.Productid, p.Product, p.Category
FROM
    salesdb.products AS p
        LEFT JOIN
    orders AS o ON p.productid = o.productid
WHERE
    o.productid IS NULL;

-- Q19. Write a query using RIGHT JOIN to show all products and their matching order IDs, including products without orders.
SELECT 
    p.Product, o.OrderID
FROM
    orders AS o
        RIGHT JOIN
    salesdb.products AS p ON p.productid = o.productid;

-- Q20. Join Orders, Customers and Products. Display OrderID, customer first name, product name, quantity and sales.
SELECT 
    o.OrderID, c.FirstName, p.Product, o.Quantity, o.Sales
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON o.customerid = c.customerid
        LEFT JOIN
    salesdb.products AS p ON o.productid = p.productid;

-- Q21. Display orders for customers from the USA. Show customer name, country, order ID and sales.
SELECT 
    c.FirstName, c.Country, o.OrderID, o.Sales
FROM
    orders AS o
        LEFT JOIN
    salesdb.customers AS c ON o.customerid = c.customerid
WHERE
    Country = 'USA';

-- Q22. Calculate total sales for each customer. Display CustomerID, customer first name and total sales.
SELECT 
    c.CustomerID, c.FirstName, SUM(o.Sales) Total_Sales
FROM
    orders AS o
        LEFT JOIN
    salesdb.customers AS c ON o.customerid = c.customerid
GROUP BY c.CustomerID , c.FirstName;

-- Q23. Display orders with OrderStatus = 'Delivered', including the customer name and product name.
SELECT 
    o.OrderID, c.FirstName, p.product, o.OrderStatus
FROM
    orders AS o
        LEFT JOIN
    customers AS c ON o.customerid = c.customerid
        LEFT JOIN
    salesdb.products AS p ON o.productid = p.productid
WHERE
    OrderStatus = 'Delivred';

-- Q24. Count the number of orders handled by each employee. Display employee ID, employee name and order count.
SELECT 
    e.Employeeid, e.FirstName, COUNT(o.OrderID) Total_Orders
FROM
    salesdb.employees AS e
        LEFT JOIN
    salesdb.orders AS o ON e.employeeid = o.salespersonid
GROUP BY Employeeid , e.FirstName;

-- Q25. Use Employees.ManagerID and Employees.EmployeeID to display each employee's name alongside their manager's name. Keep employees without a manager in the result.
SELECT 
    e.EmployeeID,
    e.FirstName AS Employee_Name,
    m.FirstName AS Manager_Name
FROM
    salesdb.Employees AS e
        LEFT JOIN
    salesdb.Employees AS m ON e.ManagerID = m.EmployeeID;

-- Q26. For each product category, calculate total quantity sold and total sales. Join Orders with Products.
SELECT 
    p.Category, SUM(o.Quantity) T_Quantity, SUM(o.Sales) T_Sales
FROM
    orders AS o
        LEFT JOIN
    salesdb.products AS p ON o.productid = p.productid
GROUP BY Category;

-- Q27. Find customers whose total sales across their orders exceed 30. Display customer name and total sales.
SELECT 
    c.FirstName, SUM(o.Sales) Total_Sales
FROM
    orders AS o
        LEFT JOIN
    salesdb.customers AS c ON o.customerid = c.customerid
GROUP BY c.Customerid , c.FirstName
HAVING SUM(o.Sales) > 30;

-- Q28. Compare Orders and OrdersArchive using OrderID. Show all IDs, including records that exist in only one table. Use FULL OUTER JOIN if your database supports it.
SELECT 
    o.OrderID AS Current_OrderID, oa.OrderID AS Archive_OrderID
FROM
    salesdb.Orders AS o
        LEFT JOIN
    salesdb.orders_archive AS oa ON o.OrderID = oa.OrderID 
UNION SELECT 
    o.OrderID AS Current_OrderID, oa.OrderID AS Archive_OrderID
FROM
    salesdb.Orders AS o
        RIGHT JOIN
    salesdb.orders_archive AS oa ON o.OrderID = oa.OrderID
WHERE
    o.OrderID IS NULL;

-- Q29. Join Orders and OrdersArchive on OrderID. Display IDs where the current OrderDate differs from the archived OrderDate. Return both dates so you can compare them.
SELECT 
    o.OrderID,
    o.OrderDate AS Current_OrderDate,
    oa.OrderDate AS Archive_OrderDate
FROM
    salesdb.orders AS o
        INNER JOIN
    salesdb.orders_archive AS oa ON o.orderid = oa.orderid
WHERE
    o.OrderDate <> oa.OrderDate;

-- Q30. Count orders for every customer, including customers with zero orders. Display the customer name and order count.
SELECT 
    c.CustomerID, c.Firstname, COUNT(o.OrderID) Total_Orders
FROM
    customers AS c
        LEFT JOIN
    orders AS o ON c.customerid = o.customerid
GROUP BY c.Firstname , c.CustomerID;

-- Q31. Join Products and Orders. For each product, calculate total quantity sold, total sales and average sales per order. Show only products whose total quantity sold is greater than 1.
SELECT 
    p.ProductID,
    p.Product,
    SUM(o.quantity) T_Quantity,
    SUM(o.sales) T_Sales,
    ROUND(AVG(o.sales), 0) Avg_Sales
FROM
    salesdb.products AS p
        LEFT JOIN
    salesdb.orders AS o ON p.productid = o.productid
GROUP BY p.ProductID , p.Product
HAVING SUM(o.quantity) > 1;

-- Q32. Join Employees and Orders. Calculate total sales for each salesperson, considering only orders with status Delivered. Show salespeople whose delivered sales exceed 20.
SELECT 
    e.EmployeeID, e.FirstName, SUM(o.sales) Total_Sales
FROM
    salesdb.employees AS e
        INNER JOIN
    salesdb.orders AS o ON o.salespersonid = e.employeeid
WHERE
    o.orderstatus = 'Delivered'
GROUP BY e.FirstName , e.EmployeeID
HAVING SUM(o.sales) > 20;

-- Q33. Join Customers and Orders. Display each customer's name, country, total sales and total number of orders. Include only customers whose total sales exceed 20. Sort from highest to lowest total sales.
SELECT 
    c.CustomerID,
    c.FirstName,
    c.Country,
    SUM(o.Sales) Total_Sales,
    COUNT(o.OrderID) Total_Orders
FROM
    salesdb.customers AS c
        INNER JOIN
    salesdb.orders AS o ON c.customerid = o.customerid
GROUP BY c.FirstName , c.Country , c.CustomerID
HAVING SUM(o.Sales) > 20
ORDER BY Total_Sales DESC;

-- Q34. Join Orders and OrdersArchive on OrderID. Find records where the Sales value differs between the two tables. Display the order ID, current sales and archived sales.
SELECT 
    o.OrderID, o.Sales Current_Sales, oa.Sales Archive_Sales
FROM
    salesdb.orders AS o
        INNER JOIN
    salesdb.orders_archive AS oa ON o.orderid = oa.orderid
WHERE
    o.Sales != oa.Sales OR oa.Sales IS NULL;

-- Q35. Join Customers and Orders. Display each customer's name, score and total sales. Filter for customers whose score is at least 500 and whose total sales exceed 20.
SELECT 
    c.CustomerID, c.FirstName, c.Score, SUM(o.Sales) Total_Sales
FROM
    salesdb.orders AS o
        INNER JOIN
    salesdb.customers AS c ON o.customerid = c.customerid
WHERE
    c.Score >= 500
GROUP BY c.CustomerID , c.FirstName , c.Score
HAVING SUM(o.sales) > 20;

-- Q36. Join Orders, Customers and Products. Find orders where Quantity is at least 2 and Sales is greater than 15. Display customer name, product name, quantity and sales.
SELECT 
    c.FirstName, p.Product, o.Quantity, o.Sales
FROM
    salesdb.orders AS o
        LEFT JOIN
    salesdb.customers AS c ON o.customerid = c.customerid
        LEFT JOIN
    salesdb.products AS p ON o.productid = p.productid
WHERE
    Quantity >= 2 AND Sales > 15;

-- Q38. From Employees, calculate the number of employees and average salary for each department. Show only departments with an average salary greater than 60,000. Sort by average salary, highest first.
SELECT 
    e.Department,
    COUNT(e.employeeid) Num_Employees,
    ROUND(AVG(e.salary), 2) Avg_Salary
FROM
    salesdb.employees AS e
GROUP BY e.Department
HAVING AVG(e.salary) > 60000
ORDER BY Avg_Salary DESC;

-- Q39. Use a LEFT JOIN between Products and Orders. For each category, display the number of products and total sales generated by orders. Include categories even if they have no orders.
SELECT 
    p.Category,
    COUNT(DISTINCT p.productid) Total_Products,
    SUM(o.Sales) Total_Sales
FROM
    salesdb.products AS p
        LEFT JOIN
    salesdb.orders AS o ON p.productid = o.productid
GROUP BY Category;

-- Q37. From Orders, find orders placed between 2025-01-01 and 2025-02-28, inclusive. Display the order ID, order date, status and sales. Sort by order date.
SELECT 
    o.OrderID, o.OrderDate, o.orderstatus, o.Sales
FROM
    salesdb.orders AS o
WHERE
    OrderDate >= '2025-01-01'
        AND OrderDate < '2025-02-28'
ORDER BY OrderDate;

-- Q40. Use Customers and Orders to find customers who have no delivered orders. Include customers who have no orders at all. Display their customer ID and name.
SELECT 
    o.Customerid, c.FirstName
FROM
    salesdb.customers AS c
        LEFT JOIN
    salesdb.orders AS o ON c.customerid = o.customerid
WHERE
    o.orderid IS NULL;