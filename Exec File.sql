use master
GO

USE SalesInvoices;

GO


SELECT * FROM Vehicles;
SELECT * FROM UserCategories;
SELECT * FROM Users;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderActions;
SELECT * FROM OrderDetails;
SELECT * FROM Company;

GO 
EXEC Sp_helpindex Vehicles ;

GO

SELECT * FROM  VW_CUSTOMERS;

GO
SELECT * FROM  VW_ORDERS;

GO
EXEC SP_CustomerOrder;


EXEC SP_ORDERCOUNT '2019-01-04', 'M%' ;

PRINT dbo.fn_GetCustomers2();

SELECT * FROM dbo.fn_GETCustomers(2);

INSERT Customers VALUES ( 6, 'Md. Akram', '23568742');



 -------==========================USE THE CONVERT FUNCTION ---================================

 select   'invoice: # ' +invoiceNo + ', dated ' + convert (char(8),OrderDate,1),issueAddress from Orders;



 SELECT OrderDate, GETDATE()AS 'TODAY''S Date', DATEDIFF (day,OrderDate,GETDATE()) AS DAY FROM Orders;

----inner join==================================================================

select customerName,CustomerBIN,InvoiceNO,IssueAddress from orders
join customers on orders.CustomerID = customers.CustomerID
order by CustomerName ;

 ----===--USE A SELF JOIN--==============================

SELECT DISTINCT Customers1.CustomerName,Customers1.CustomerBIN
  FROM
     Customers AS Customers1 join Customers AS Customers2
	 ON(Customers1.CustomerBIN =Customers2.CustomerBIN)
	 AND
	 (Customers1.CustomerID <> Customers2.CustomerID)
	 ORDER BY
	 Customers1.CustomerName DESC;

	 ---========= A LEFT OUTER JOIN--=======================

	 SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders LEFT JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;

	   ---- A RIGHT OUTER JOIN=======================================================================
	   SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders RIGHT JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;


	   ----A FULL OUTER JOIN---================================================================================
	    SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders FULL JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;

-----------===========---use CROSS JOINJ============================================================================

	   SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders CROSS JOIN Customers
	   ORDER BY Customers.CustomerID;


	   


		  ----USE EXCEPT AND INTERSECT--=========================================
		  SELECT CustomerName FROM Customers
		  EXCEPT
		  SELECT UserName FROM Users
		  ORDER BY CustomerName; 
		  ---------====INTERSECT--===================

          SELECT CustomerName FROM Customers
             INTERSECT
		  SELECT UserName FROM Users
		  ORDER BY CustomerName;


		 GO

		  -----###############---USE THE CONVERT FUNCTION ---================================

		 select   'invoice: # ' +invoiceNo + ', dated ' + convert (char(8),OrderDate,1),issueAddress
		  from Orders;

		  SELECT OrderDate,
		      GETDATE()AS 'TODAY''S Date',
			  DATEDIFF (day,OrderDate,GETDATE()) AS DAY
			  FROM Orders;


			  
----inner join==================================================================
GO

select customerName,CustomerBIN,InvoiceNO,IssueAddress from orders
join customers on orders.CustomerID = customers.CustomerID
order by CustomerName ;



 ----===--USE A SELF JOIN--==============================

SELECT DISTINCT Customers1.CustomerName,Customers1.CustomerBIN
  FROM
     Customers AS Customers1 join Customers AS Customers2
	 ON(Customers1.CustomerBIN =Customers2.CustomerBIN)
	 AND
	 (Customers1.CustomerID <> Customers2.CustomerID)
	 ORDER BY
	 Customers1.CustomerName DESC;

	 ---========= A LEFT OUTER JOIN--=======================


	 GO
	 SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders LEFT JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;

	   ---- A RIGHT OUTER JOIN=======================================================================

	   GO
	   SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders RIGHT JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;


	   ----A FULL OUTER JOIN---================================================================================

	   GO

	    SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders FULL JOIN Customers
	   ON Orders.OrderID =Customers.CustomerID;

-----------===========---use CROSS JOINJ============================================================================

GO


	   SELECT  CustomerName,CustomerBIN,InvoiceNO
	 FROM 
	   Orders CROSS JOIN Customers
	   ORDER BY Customers.CustomerID;


	  -- ===USE UNION STATEMENT-=========================================================================

	   --SELECT CustomerName,CustomerBIN,InvoiceNO 
	   --FROM
	   --   Orders
		  --JOIN Customers ON Orders.CustomerID = Customers.CustomerID

		  --UNION
		  --SELECT CustomerID,InvoiceNO, PrepareBy --,ApprovedBy
		  --FROM
		  --OrderActions
		  --JOIN Orders  ON OrderActions.OrderID =Orders.OrderID
		  --WHERE Orders. OrderID = 2
		  --ORDER BY InvoiceNO DESC;


		  

		  ----USE EXCEPT AND INTERSECT--=========================================

		  GO

		  SELECT CustomerName FROM Customers
		  EXCEPT
		  SELECT UserName FROM Users
		  ORDER BY CustomerName; 
		  ---------====INTERSECT--===================

		  GO

          SELECT CustomerName FROM Customers
             INTERSECT
		  SELECT UserName FROM Users
		  ORDER BY CustomerName; 
		   

		   ---DECLARE STATEMENT FOR A TABLE VARIABLE--=======================================

GO

DECLARE @BigUsers table
(UserID INT,
UserName VARCHAR (80));
INSERT @BigUsers
SELECT UserID, UserNAme 
FROM Users;
SELECT * FROM @BigUsers;

GO

--===================================================

SELECT * FROM  VW_CUSTOMERS;

GO

--=============================================================

SELECT * FROM  VW_ORDERS;
GO
--==================================================

SELECT * FROM VW_ORDERS2;

GO
--====================================================

EXEC SP_CustomerOrder;

GO
---==========================================

 EXEC  SP_ORDERCOUNT;
 GO
 --============================================
 PRINT dbo.fn_GETCustomers(2);
 GO
 --==============================================
 PRINT dbo.fn_GetCustomers2()

 --***************************************************************00000000000000000000000000000000**********************************************
 


 --ALTER TABLE Vehicles
--ADD TotalPrice money NOT NULL;
-----A statement that delete the new Column----
--ALTER TABLE Vehicles
--DROP Column TotalPrice;




-------UPDATE Statement------
UPDATE Vehicles
SET UnitPrice = 15000000
WHERE UnitPrice =12000000;



------A select Statement that retrives three column----
SELECT CustomerID,  InvoiceNo,OrderDate
FROM Orders
ORDER BY OrderID;

SELECT CustomerID, CustomerName,CustomerBIN
FROM Customers
WHERE CustomerID = 5;

------USE OF Fetch and offset-----
SELECT CustomerID,CustomerName,CustomerBIN
FROM
Customers 
ORDER BY Customername
OFFSET 5 Rows
FETCH  NEXT 8 ROWS ONLY;

-----AN INNER JOIN WITH CORRELATION NAME----




---------======================DECLARE STATEMENT FOR A TABLE VARIABLE--=======================================

GO
DECLARE @BigUsers table
GO
SELECT * FROM VW_ORDERS2;
GO
--ALL INDEXINFORMATION  OF SALESINVOICES----

EXEC SP_IndexDetails;
GO
