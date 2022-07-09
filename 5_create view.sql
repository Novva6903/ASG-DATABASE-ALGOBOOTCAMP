USE OOVEO_Salon

--Soal 1
CREATE VIEW ViewBonus AS
SELECT STUFF(CustomerId, 1, 2, 'BN') AS BinusId, CustomerName
FROM MsCustomer
WHERE LEN(CustomerName) > 10
GO

SELECT *
FROM ViewBonus
GO

--Soal 2
CREATE VIEW ViewCustomerData AS
SELECT SUBSTRING(CustomerName, 1, CHARINDEX(' ', CustomerName, 1)) AS Name, CustomerAddress AS Address, CustomerPhone AS Phone
FROM MsCustomer
WHERE CustomerName LIKE '% %'
GO

SELECT *
FROM ViewCustomerData
GO

--Soal 3
CREATE VIEW ViewTreatment AS
SELECT TreatmentName, TreatmentTypeName, CAST('Rp. ' AS VARCHAR) + CAST(Price AS VARCHAR) AS Price
FROM MsTreatment a
JOIN MsTreatmentType b
	ON a.TreatmentTypeId = b.TreatmentTypeId
WHERE TreatmentTypeName = 'Hair Treatment' AND Price BETWEEN 450000 AND 800000
GO

SELECT *
FROM ViewTreatment
GO

--Soal 4
CREATE VIEW ViewTransaction AS
SELECT StaffName, CustomerName, CONVERT(VARCHAR, TransactionDate, 106) AS TransactionDate, PaymentType
FROM HeaderSalonServices a
JOIN MsStaff b
	ON a.StaffId = b.StaffId
JOIN MsCustomer c
	ON a.CustomerId = c.CustomerId
WHERE PaymentType = 'Credit' AND DAY(TransactionDate) BETWEEN 21 AND 25
GO

SELECT *
FROM ViewTransaction

--Soal 5
CREATE VIEW ViewBonusCustomer AS
SELECT REPLACE(a.CustomerId, 'CU', 'BN') AS BonusId, LOWER(REVERSE(SUBSTRING(REVERSE(CustomerName), 1, CHARINDEX(' ', REVERSE(CustomerName), 1)))) AS Name, DATENAME(WEEKDAY, TransactionDate) AS Day, CONVERT(VARCHAR, TransactionDate, 101) AS TransactionDate
FROM HeaderSalonServices a
JOIN MsCustomer b
	ON a.CustomerId = b.CustomerId
WHERE CustomerName LIKE '% %a%'
GO

SELECT *
FROM ViewBonusCustomer
GO

--Soal 6
CREATE VIEW ViewTransactionByLivia AS
SELECT a.TransactionId, CONVERT(VARCHAR, TransactionDate, 100) AS TransactionDate, c.TreatmentName
FROM HeaderSalonServices a
JOIN DetailSalonServices b
	ON a.TransactionId = b.TransactionId
JOIN MsTreatment c
	ON b.TreatmentId = c.TreatmentId
JOIN MsStaff d
	ON a.StaffId = d.StaffId
WHERE DAY(a.TransactionDate) = 21 AND StaffName like 'Livia Ashianti'
GO

SELECT *
FROM ViewTransactionByLivia

--Soal 7
ALTER VIEW ViewCustomerData AS
SELECT RIGHT(CustomerId, CHARINDEX('0', CustomerId, 1)) AS ID, CustomerName AS Name, CustomerAddress AS Address, CustomerPhone AS Phone
FROM MsCustomer
WHERE CustomerName LIKE '% %'
GO

SELECT *
FROM ViewCustomerData

--Soal 8
CREATE VIEW ViewCustomer AS
SELECT *
FROM MsCustomer
GO

INSERT INTO ViewCustomer (CustomerId, CustomerName, CustomerGender)
VALUES ('CU006', 'Cristian', 'Male')

SELECT *
FROM ViewCustomer

--Soal 9
DELETE
FROM ViewCustomerData
WHERE ID = '005'

SELECT *
FROM ViewCustomerData

--Soal 10
DROP VIEW ViewCustomerData