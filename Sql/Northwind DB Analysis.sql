----- checking for missing values ---- 
SELECT *
FROM Categories

SELECT *
FROM Customers
where CustomerID is null or CustomerName is null or ContactName is null or Address is null or city is null or PostalCode is null or Country is null ;
 
 SELECT *
FROM Employees

select * from OrderDetails 
where OrderDetailID is null or OrderID is null or ProductID is null or Quantity is null ;

select * from Orders
where OrderID is null or CustomerID is null or EmployeeID is null or OrderDate is null or ShipperID is null 

select * from Products
where ProductID is null or ProductID is null or SupplierID is null or CategoryID is null or Unit is null or Price is null 

select * from shippers

select * from Suppliers
where SupplierID is null or SupplierName is null or ContactName is null or Address is null or city is null or PostalCode is null 
or Country is null or Phone is null 

----- checking for Duplicates values Rows ---- 
SELECT count (*)
FROM Categories
SELECT distinct count (*)
FROM Categories
------------------
SELECT count(*)
FROM Customers
SELECT distinct count(*)
FROM Customers
----------------
 SELECT count (*)
FROM Employees
 SELECT distinct count (*)
FROM Employees
--------------------
select count (*) from OrderDetails 
select distinct count (*) from OrderDetails 
--------------------------------
select count(*) from Orders
select distinct count(*) from Orders
--------------------------
select count (*) from Products
select distinct count (*) from Products
--------------------------
select count (*) from shippers
select distinct count (*) from shippers
------------------------------
select count (*) from Suppliers
select distinct count (*) from Suppliers
----- checking for Duplicates values columns ---- 
-- Categories--
SELECT *
FROM Categories
-- checking categories columns--
select CategoryName ,count(categoryname) from Categories group by CategoryName having COUNT(CategoryName) >1

select Description ,count(Description) from Categories group by Description having COUNT(Description) >1

-- customers--

SELECT *
FROM Customers
-- checking customers columns--
select CustomerName ,count(CustomerName) from Customers group by CustomerName having COUNT(CustomerName) >1

select ContactName ,count(ContactName) from Customers group by ContactName having COUNT(ContactName) >1

select Address ,count(Address) from Customers group by Address having COUNT(Address) >1

-- employess--
 SELECT *
FROM Employees
-- checking employess columns--

select FirstName ,count(FirstName) from Employees group by FirstName having COUNT(FirstName) >1

select LastName ,count(LastName) from Employees group by LastName having COUNT(LastName) >1

select Photo ,count(Photo) from Employees group by photo having COUNT(photo) >1

select Notes ,count(Notes) from Employees group by Notes having COUNT(Notes) >1

-- order details--

select * from OrderDetails

-- checking order details columns--

select OrderDetailID ,count(OrderDetailID) from OrderDetails group by OrderDetailID having COUNT(OrderDetailID) >1

/* order id on his own repeats and product id on his owm repeats , but order id and product id together do not repeat -- both are  composite primary key*/

select OrderID ,ProductID,count(OrderID) from OrderDetails group by ProductID,OrderID having COUNT(OrderID) >1

-- order --

select * from Orders 

-- checking order  columns--

select OrderID ,count(OrderID) from Orders group by Orderid having COUNT(OrderID) >1

-- products --

select * from Products 

-- checking products columns--

select ProductID ,count(ProductID) from Products group by ProductID having COUNT(ProductID) >1

select ProductName ,count(ProductName) from Products group by ProductName having COUNT(ProductName) >1

-- shippers --

select * from Shippers 

-- suppliers --

select * from Suppliers 

-- checking suppliers columns--

select SupplierID ,count(SupplierID) from Suppliers group by SupplierID having COUNT(SupplierID) >1

select SupplierName ,count(SupplierName) from Suppliers group by SupplierName having COUNT(SupplierName) >1

select ContactName ,count(ContactName) from Suppliers group by ContactName having COUNT(ContactName) >1

select Address ,count(Address) from Suppliers group by Address having COUNT(Address) >1

select City ,count(City) from Suppliers group by City having COUNT(City) >1

select PostalCode ,count(PostalCode) from Suppliers group by PostalCode having COUNT(PostalCode) >1

select Phone ,count(Phone) from Suppliers group by Phone having COUNT(Phone) >1
---- changing data type ----

alter table employees alter column BirthDate Date;

alter table orders alter column orderdate Date;

select * from Categories
select * from Customers
select * from Employees
select * from Products
select * from OrderDetails
select * from Orders
select * from Shippers
select * from Suppliers

/* 1. Total Revenue
Insight: Show total revenue generated from all orders.(price * quantity)*/ 

select sum(price * Quantity) as Total_Revenue from Products p  join OrderDetails od on p.ProductID = od.ProductID

/*2. Total Number of Orders
Insight: Display the total number of orders placed*/

SELECT COUNT(*) AS Total_Orders
FROM Orders;

/*3. Number of Unique Customers
Insight: Count the number of unique customers who placed orders.*/

SELECT  COUNT( distinct CustomerID) AS Unique_Customers
FROM Orders;

/*4. Best-Selling 5 Products
Insight: Identify 5 Products with the highest sales volume.(price * quantity)*/ 
 
select Top 5 ProductName ,sum(price * Quantity)  as Total_Revenue from Products p  join OrderDetails od on p.ProductID = od.ProductID 
group by ProductName order by sum(Price* Quantity) desc

/*5. Total Revenue by Category
Insight: Identify The Total Revenue For Each Category*/ 

select CategoryName ,sum(price * Quantity) as Total_Revenue 
from Products p  join OrderDetails od on p.ProductID = od.ProductID join Categories c on c.CategoryID = p.CategoryID group by CategoryName 
order by Total_Revenue

/*6. Customer Distribution by Country
Insight: Show how customers are distributed across different countries*/ 

SELECT Country, COUNT(*) AS Customer_Count
FROM Customers 
GROUP BY Country
order by Customer_Count;

/*7. Total sales(Price*Quantity) by Country
Insight: Show The Sales Across Different Countries*/

select  Country ,sum(price * Quantity) as Total_Revenue from Products p  join OrderDetails od on p.ProductID = od.ProductID 
join Orders o on o.OrderID = od.OrderID join Customers c on c.CustomerID = o.CustomerID group by Country order by Total_Revenue desc

/*8. Total Suppliers
Insight: Show the total number of suppliers providing products*/

SELECT COUNT(DISTINCT SupplierID) AS Total_Suppliers
FROM Products;

/*9. Top 5 Employees by Sales
Insight : Show The Best 3 Emplyees In Sales*/

SELECT Top 5
       FirstName + ' '+ LastName AS EmployeeName, 
       SUM(Quantity * Price) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY  FirstName, LastName
ORDER BY TotalSales DESC

/* 10.How many customers have placed more than one order
Insight: Show the Loyal Customers*/ 

select customername ,count(OrderID) as number_of_orders 
from Orders o join Customers c 
on o.CustomerID =c.CustomerID 
group by CustomerName 
having COUNT(OrderID)>1 
order by number_of_orders

/*11.Total Quantity Sold by Category
Insight: Show The Total Amount Sold For Each Category*/

select categoryname,sum(quantity) as total_quanitiy
from Products p join OrderDetails od on p.ProductID = od.ProductID
join Categories c on p.CategoryID = c.CategoryID
group by CategoryName
order by total_quanitiy

/*12. How many orders were shipped by each shipper?
Insight:Show The Count Of Orders For Each Shipper*/ 

select shippername , count(orderid) as total_orders
from Shippers s join Orders o on s.ShipperID= o.ShipperID
group by ShipperName 
order by total_orders

