--1

Select CategoryName ,Description
From Categories
order by CategoryName;
---2

Select  ContactName ,CompanyName ,ContactTitle ,Phone
From Customers
Order By Phone;

---3

Select UPPER (FirstName) As First_Name ,
		UPPER (LastName) AS Last_Name ,
		HireDate 
From Employees
Order By HireDate DESC; 

---4

Select OrderID ,OrderDate ,ShippedDate,	CustomerID ,Freight
From Orders
Order By Freight Desc
OFFSET 0 Rows FETCH first 10 rows only ;

---5
Select	lower (CustomerID) As ID
From Customers ;

---6

Select CompanyName ,Fax ,Phone ,Country ,HomePage
From Suppliers
order by Country Desc ,CompanyName Asc;

---7
Select CompanyName ,ContactName,City
From Customers
Where City = 'Buenos Aires';

--8
Select ProductName ,UnitPrice ,QuantityPerUnit ,Discontinued
From Products
Where Discontinued = '1';

--9
Select ContactName ,Address ,City
From Customers
Where City NOT IN ('Germany','Mexico' ,'Spain');

---10
Select OrderDate , ShippedDate ,CustomerID ,Freight
From Orders
Where OrderDate ='1996-05-21';

---11

Select FirstName , LastName ,Country
From Employees
Where Country <> 'USA';

---12

Select OrderID,CustomerID ,EmployeeID ,ShippedDate,RequiredDate
From Orders
Where  ShippedDate > RequiredDate

---13

Select City , CompanyName,ContactName
From Customers
Where City LIKE '[AB]%' 
Order BY City ;

---14

Select*
From Orders
Where OrderId % 2 = 0;

---15

Select*
From Orders
Where Freight > 500;

---16

Select ProductName ,UnitsInStock ,UnitsOnOrder ,ReorderLevel
From Products
Where ReorderLevel =0 ;

---17 

Select CompanyName ,ContactName, Phone,Fax
From Customers
Where Fax <> 'NULL' ;

---18

Select FirstName ,LastName ,ReportsTo
From Employees
Where ReportsTo  is NULL;

--19	

Select*
From Orders
Where OrderID % 2 != 0 ;

---20

Select CompanyName ,ContactName, Fax
From Customers
Where Fax  IS  NULL
Order By ContactName ;

---21

Select City ,CompanyName, ContactName 
From Customers
Where City Like '%L%'
Order By ContactName;

---22

Select FirstName, LastName,BirthDate
From Employees
Where BirthDate Between '1950-01-01' AND '1959-12-31';

---23

Select FirstName, LastName,BirthDate AS BirthYear
From Employees;

---24

Select OrderID ,Sum(OrderID) As NumberOfOrder
From dbo.[Order Details] 
Group By OrderID
 Order By NumberOfOrder DESC;

---25

Select Suppliers.SupplierID , Products.ProductName , Suppliers.CompanyName
From Suppliers Join Products  On 
Suppliers.SupplierID = Products.SupplierID
Where CompanyName  IN ('Exotic Liquids ','Specialty Biscuits, Ltd.','Escargots Nouveaux')
Order by SupplierID;

---26

Select ShipPostalCode ,OrderID ,OrderDate ,RequiredDate ,ShippedDate ,ShipAddress
From Orders
Where ShipPostalCode Like '98124%' ;

----27

Select  ContactName , ContactTitle ,CompanyName
From Customers
Where ContactTitle NOT Like '%Sales%'

---28

Select LastName ,FirstName ,City
From Employees
Where City  != 'Seattle';

---29

Select CompanyName, ContactTitle, City,Country
From Customers
Where Country IN ('Mexico' , 'Spain') AND City <> 'Madrid';

---30

Select Concat (FirstName ,' ',LastName , ' can be reached at',' ',' x',Extension) As Contactinfo
From Employees;

---31

Select ContactName
From Customers
Where ContactName NOT LIKE '_A%';

---32

Select Round (AVG(UnitPrice),0) As AveragePrice,
		SUM(UnitsInStock) As TotalStock,
		MAX(UnitsOnOrder) As MaxOrder
From Products	

---33

Select Suppliers.SupplierID, CompanyName, CategoryName , Products.ProductName , UnitPrice 
FROM Products 
Join Suppliers
ON Products.SupplierID = Suppliers.SupplierID 
Join  Categories 
ON Products.CategoryID = Categories.CategoryID ;

---34

Select CustomerID ,SUM(Freight) As SumofFreight
From Orders
Group By CustomerID
Having Sum(Freight) >'200';

---35

Select Orders.OrderID ,Customers.ContactName,UnitPrice ,Quantity ,Discount
From Orders
Join [Order Details]
ON Orders.OrderID =[Order Details].OrderID
Join Customers
ON Orders.CustomerID = Customers.CustomerID
Where Discount != '0';

---36

Select e.EmployeeID , (e.LastName + '' + e.FirstName) As Employee,
		(m.LastName + '' + m.FirstName) As Manger 
From Employees e Inner Join Employees m 
On m.EmployeeID  = e.ReportsTo
Order By Employee;

---37

Select AVG(UnitPrice) as AveragePrice,
	  Min(UnitPrice) as MininumPrice,
	  Max(UnitPrice) as MaximumPrice 
From Products

---38

Create View CustomerInfo AS
Select Customers.CustomerId ,CompanyName ,ContactName ,ContactTitle ,Address ,City ,Country, Phone, 
      OrderDate ,RequiredDate ,ShippedDate
From Customers Join Orders
ON  Customers.CustomerID = Orders.CustomerID ;

Select*
From CustomerInfo 

---39

RENAME TABLE CustomerInfo TO CustomerDetails ; 

 ---40

 Create View ProductDetails As 
 Select ProductID ,CompanyName,ProductName, CategoryName ,Description, 
		QuantityPerUnit , UnitPrice, UnitsInStock, UnitsOnOrder, Discontinued
From Products 
Join Suppliers 
ON Products.SupplierID =Suppliers.SupplierID
Join Categories
ON Products.CategoryID = Categories.CategoryID;

 Select*
 From ProductDetails;


---41

DROP VIEW CustomerDetails ;

--42

Select SUBSTRING (CategoryName, 1 ,5) As ShortInfo
From Categories ;

---43

USE [Northwind]
GO
Set ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_PADDING ON
GO 
CREATE TABLE [dbo].[shipper_duplicate]
  ([ShipperID][int] Not Null ,
	[CompanyName][nvarchar](40) Not Null,
	[Phone][nvarchar](24) Null,
	) ON [PRIMARY]
	GO
SET ANSI_PADDING OFF
GO

SELECT*
INTO [shipper_duplicate]
FROM [Shippers]
where 1 = 2 

Insert into shipper_duplicate (ShipperID,CompanyName ,Phone)
Values (1,'Speedy Express', '(503)555-9831')

Insert into shipper_duplicate (ShipperID,CompanyName ,Phone)
Values (2,'United Package' ,'(503)555-3199')

Insert into shipper_duplicate (ShipperID,CompanyName ,Phone)
Values (3, 'Fedral Shipping', '(503)555-9931')

Select*
From shipper_duplicate

----44

Alter Table shipper_duplicate
ADD  Email varchar (255) ;

Update shipper_duplicate
Set Email = 'speedyexpress@gmail.com'
Where ShipperID =1 ;

Update shipper_duplicate
Set Email = 'unitedpackage@gmail.com'
Where ShipperID =2;

Update shipper_duplicate
Set Email = 'fedralshipping@gmail.com'
Where ShipperID =3 ;

Select *
From shipper_duplicate

----45

Select Products.ProductName ,Suppliers.CompanyName
From Products
Join Suppliers ON Products.SupplierID =Suppliers.SupplierID
Join Categories ON Products.CategoryID = Categories.CategoryID
Where CategoryName = 'Seafood';

---46

Select Categories.CategoryID, Products.ProductName ,Suppliers.CompanyName
From Products
Join Suppliers ON Products.SupplierID =Suppliers.SupplierID
Join Categories ON Products.CategoryID = Categories.CategoryID
Where Categories.CategoryID = '5';

---47
Drop Table shipper_duplicate ;

---48

Select LastName , FirstName ,Title , DATEDIFF (YY ,BirthDate ,getdate()) As Age
From Employees

---49

Select  (Customers.CompanyName) , Count(Customers.CustomerID)  As TotalOrders 
		From Customers Join Orders
On Customers.CustomerID = Orders.CustomerID
WHERE Orders.OrderDate >= '1994 -12-31'
Group By Customers.CustomerID
Having Count(Customers.CustomerID) >10 ;



---50
Select CONCAT (ProductName ,' ','weight is' , QuantityPerUnit ,'and cost is $',ROUND(UnitPrice,0))
From Products
