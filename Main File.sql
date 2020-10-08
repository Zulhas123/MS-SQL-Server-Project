GO
USE master;
GO
IF DB_ID ('SalesInvoices') IS NOT NULL
DROP DATABASE SalesInvoices;

GO
CREATE DATABASE SalesInvoices

ON (
	NAME		= Sales_data,
	FILENAME	= 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Sales_data.mdf',
	SIZE		= 10MB,
	MAXSIZE		= 50MB,
	FILEGROWTH	= 5MB	
)
LOG ON (
	NAME		=Sales_log,
	FILENAME	= 'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Sales_log.ldf',
	SIZE		= 5MB,
	MAXSIZE		= 25MB,
	FILEGROWTH	= 5MB
);
GO


use SalesInvoices;

Go
---==================================================CREATE VEHICLES TABLES---0000000000000000000000000000000000000
CREATE TABLE Vehicles
  (
    VehicleId INT  IDENTITY PRIMARY KEY,
	VehicleName		VARCHAR(100),
	UnitPrice		MONEY
  );

GO
--------------=================================*******************************************************
  INSERT INTO Vehicles VALUES
  ( 'BMW',13000000),
  ('CORALLA',1200000),
  ('TOYATA',500000),
  ('MARCHANDISE',20000000);

 GO

 ------------------============================CREATE UserCategories=========================================
 CREATE TABLE UserCategories
  (
    UserCategoryID		INT IDENTITY PRIMARY KEY,
	UserCatergoryName	VARCHAR(50)
  );

------------=====================================CREATE Users TABLE ===============================================

 INSERT INTO  UserCategories VALUES ('Customer'),('Employer');


Go
    CREATE TABLE Users
  (
  UserID	INT IDENTITY PRIMARY KEY,
  UserCategoryID		INT REFERENCES  UserCategories(UserCategoryID),
  UserName		VARCHAR (50)
  );

  GO
  INSERT INTO Users VALUES
  ( 1,'ARIF'),
  (2,'IMRAN'),
  (2,'Mohibullah'),
  (1,'Alauddin'),
  (1,'Robiul'),
  (2,'joy');

GO

-----------------=============================CREATE Customers-----------------====================================
  CREATE TABLE Customers
  (
    CustomerID		INT		IDENTITY PRIMARY KEY,
	UserID			INT		REFERENCES Users (UserID),
	CustomerName	VARCHAR(50),
	CustomerBIN		VARCHAR(50)
  );

  GO
    INSERT INTO Customers VALUES

	( 1,'Anders','23454365'),
	(2, 'Maria','65756432'),
	(2,'Trujillo','87965498'),
	(3,'Ana', '45327612'),
	(5, 'Moreno','65789043'),
	(1,'Momen','43215645'),
	(6, 'Antonio','76898765'),
	(4, 'Hardy','54565654'),
	(3,'Thomas','78767656'),
	(1,'Berglund','99887655'),
	(1,'Christina','88776699'),
	(2, 'Moos','23232455'),
	(1,'Han','55445467'),
	(1,'Citeaux','89878770'),
	(2,'Fred','99877654'),
	(4, 'Summer','88790987'),
	(5,'Martin','87899007'),
	(2,'Lebihan','44325654'),
	(6,'Laurence','45453261'),
	(5,'Lincoln','23236787'),
	(2,'Elizabeth','43456789'),
	(6,'JHON','45453261'),
	(5,'ROY','23236787'),
	(2,'MILLER','43456789');

GO

-------=========================================CREATE Orders TABLE -========================================

  CREATE TABLE Orders
  (
  
  OrderID          INT IDENTITY PRIMARY KEY,
  CustomerID       INT REFERENCES Customers(CustomerID),
  OrderDate		    Date,
  InvoiceNo		    VARCHAR (50),
  IssueAddress	    VARCHAR(50),
  DeliveryDate	     Date
  
  );

  GO
  INSERT INTO Orders VALUES 
  (1, '2019-01-01', '189319-457', 'House 195 ,Road 29,Mipur', '2019-01-05' ),
  (3, '2019-02-01', '289319-457', 'House 295 ,Road 19,Mohakhali', '2019-02-06' ),
 (12, '2019-01-03', '389319-457', 'House 395 ,Road 39,Dhanmondi', '2019-02-05' ),
 (8, '2019-02-01', '489319-457', 'House 495 ,Road 49,Gagipur', '2019-02-07' ),
 (4, '2019-03-03', '589319-457', 'House 595 ,Road 59,Shahbag', '2019-03-05' ),
 (17, '2019-04-01', '689319-457', 'House 399 ,Road 20,Mogbazar', '2019-04-05' ),
 (5, '2019-05-01', '789319-457', 'House 398 ,Road 21,palton', '2019-05-05' ),
 (13, '2019-03-07', '889319-457', 'House 397 ,Road 22,Newmarket', '2019-01-02' ),
 (6, '2019-02-06', '989319-457', 'House 895 ,Road 23,Jatrabari', '2019-01-03' ),
 (19, '2019-02-09', '779319-457', 'House 995 ,Road 24,Keranigong', '2019-01-02' ),
 (10, '2019-02-11', '889319-457', 'House 355 ,Road 55,Mohakhali', '2019-03-05' );


GO

---==========================CREATE OrderActions TABLE =========================================
 
  CREATE TABLE OrderActions
  (
    OrderActionsID INT IDENTITY PRIMARY KEY,
   OrderID		INT  REFERENCES Orders(OrderID),	
  
   PrepareBy	VARCHAR(50),
   ApprovedBy	VARCHAR(50),
   postedBy		VARCHAR(50)
  );

  
  Go
  ---------========================CREATE  OrderDetails

  CREATE TABLE OrderDetails
  (
   --OrderDetailsID INT IDENTITY PRIMARY KEY,
   OrderID INT REFERENCES Orders (OrderID),
   VehicleID INT REFERENCES Vehicles(VehicleID),
   CustomerID INT REFERENCES Customers(CustomerID),
   QTY		INT,
   VAT		MONEY,
   primary key (OrderID, VehicleID ,CustomerID)
  );

  Go

  INSERT INTO  OrderDetails VALUES 
  (1,3,3, 4,45678), (9,3,3,2,45678),
  (2,1,2,7,34576), (11,3,7,5,65678),
  (3,1,5,9,94576), (10,2,4,11,75678),
  (8,2,1,12,84576), (2,4,5,15,22576);

  GO
  ----===============CREATE TABLE COMPANY-=====================================

  CREATE TABLE Company
  (
  CompanyID		INT IDENTITY PRIMARY KEY,
  UserID		INT REFERENCES  Users( UserID),
  CompanyName	VARCHAR(50),
  CompanyBIN	VARCHAR (50)
  );
 

  INSERT INTO Company VALUES (1,'Kichai IT Service LIT','45326754897');

  GO
  
  ------=============A Statement that create an index on the table=============================----

CREATE INDEX IX_Vehicles_VehicleID ON Vehicles (VehicleID);		 
		
 GO
---========================Customer VIEW-==================================================================
GO
CREATE VIEW VW_CUSTOMERS
AS
SELECT CustomerName,CustomerBIN
from Customers;


GO
---=======================================CREATE VIEW  WITH SCHEMABINDING ==================================

CREATE VIEW VW_ORDERS
WITH SCHEMABINDING
AS
SELECT CustomerName,CustomerBIN,INvoiceNO,IssueAddress 
FROM
dbo.Orders join dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID
WHERE Customers.CustomerID < 4 ;


-------------------==================CREATTE VIEW  WITH ENCRYPTION  =====================================
GO
CREATE VIEW VW_ORDERS2
WITH ENCRYPTION
AS
SELECT CustomerName,CustomerBIN,INvoiceNO,IssueAddress 
FROM
dbo.Orders join dbo.Customers ON dbo.Orders.CustomerID = dbo.Customers.CustomerID
WHERE Customers.CustomerID < 4 ;


----====STORED PROCEDURE ==============================================
GO
CREATE PROC SP_CustomerOrder
AS
SELECT CustomerName,CustomerBIN,OrderDate,IssueAddress FROM Orders
JOIN Customers ON Orders.CustomerID= Customers.CustomerID
WHERE OrderID >6
ORDER BY CustomerName;



--------================================RETURN STATEMENT FOR A STORED PROCEDURE--=======================================
GO
CREATE PROC SP_ORDERCOUNT
@DateVar smalldatetime = null,
@customerVar VARCHAR(40) = '%'
AS IF
@DateVar is null
select @DateVar = MIN(OrderDate) FROM Orders

DECLARE @OrderCount INT;

SELECT @OrderCount = Count(OrderID)
 
 FROM Customers JOIN Orders
           
		   ON Customers.CustomerID = Orders.OrderID

WHERE(OrderDate>= @DateVar)AND
     (CustomerName like @customerVar);
	 RETURN  @OrderCount ;

GO

---===============================SCALARE VALUES FUNCTION =============================================

CREATE FUNCTION fn_GetCustomers2()

RETURNS INT
AS 
BEGIN 
	RETURN (SELECT COUNT(*) FROM Customers where CustomerID = 5);
END;

GO
--===========================TABLE VALUES FUNCTION================================================
CREATE FUNCTION fn_GETCustomers(@CustomeerID INT)
RETURNS TABLE
AS
RETURN SELECT * FROM Customers WHERE CustomerId = @CustomeerID;


GO
--================================create TRIGGER ==================================================================
CREATE TRIGGER Tr_Customer_Insert_Update
ON Customers
AFTER INSERT, UPDATE
AS
UPDATE Customers SET CustomerName = UPPER(CustomerName) WHERE CustomerID IN (SELECT CustomerID FROM inserted);


---===============================0000000000000000000000000000000========================================================
GO

CREATE PROC SP_IndexDetails
AS
SELECT 
     TableName = t.name,
     IndexName = ind.name,
     IndexId = ind.index_id,
     ColumnId = ic.index_column_id,
     ColumnName = col.name,
     ind.*,
     ic.*,
     col.* 
FROM 
     sys.indexes ind 
INNER JOIN 
     sys.index_columns ic ON  ind.object_id = ic.object_id and ind.index_id = ic.index_id 
INNER JOIN 
     sys.columns col ON ic.object_id = col.object_id and ic.column_id = col.column_id 
INNER JOIN 
     sys.tables t ON ind.object_id = t.object_id 
WHERE 
     
	 t.is_ms_shipped = 0 
ORDER BY 
     t.name, ind.name, ind.index_id, ic.index_column_id;
GO

