USE OOVEO_Salon

--Soal 1
SELECT MAX(Price) AS [Maximum Price], MIN(Price) AS [Minimum Price], CAST(ROUND(AVG(Price), 0) as decimal(18,2)) AS [Average Price]
FROM MsTreatment

--Soal 2
SELECT StaffPosition, LEFT(StaffGender, 1) AS Gender, CAST('Rp. ' AS VARCHAR) + CAST(CAST(AVG(StaffSalary) AS DECIMAL(10,2)) AS VARCHAR) AS [Average Salary]
FROM MsStaff
GROUP BY StaffPosition, StaffGender

--Soal 3
SELECT CONVERT(VARCHAR, TransactionDate, 107) AS TransactionDate, COUNT(TransactionId) AS [Total Transaction per Day]
FROM HeaderSalonServices
GROUP BY TransactionDate

--Soal 4
SELECT UPPER(CustomerGender) AS CustomerGender, COUNT(TransactionId) AS [Total Transaction]
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
GROUP BY CustomerGender

--Soal  5
SELECT TreatmentTypeName, COUNT(D.TransactionId) AS [Total Transaction]
FROM DetailSalonServices A
JOIN MsTreatment B
	ON A.TreatmentId = B.TreatmentId
JOIN MsTreatmentType C
	ON B.TreatmentTypeId = C.TreatmentTypeId
JOIN HeaderSalonServices D
	ON A.TransactionId = D.TransactionId
GROUP BY TreatmentTypeName
ORDER BY COUNT(D.TransactionId) Desc

--Soal 6
SELECT CONVERT(VARCHAR, TransactionDate, 106) AS Date, CAST('Rp. ' AS VARCHAR) + CAST(SUM(Price) AS VARCHAR) AS [Revenue per Day]
FROM DetailSalonServices A
JOIN MsTreatment B
	ON A.TreatmentId = B.TreatmentId
JOIN HeaderSalonServices C
	ON C.TransactionId = A.TransactionId
GROUP BY TransactionDate
HAVING SUM(Price) BETWEEN 1000000 AND 5000000

--Soal 7
SELECT REPLACE(A.TreatmentTypeId, 'TT0', 'Treatment Type ') AS ID, TreatmentTypeName, CAST(COUNT(A.TreatmentTypeId) AS VARCHAR) + CAST(' Treatment' AS VARCHAR) AS [Total Treatment per Type]
FROM MsTreatment A
JOIN MsTreatmentType B
	ON A.TreatmentTypeId = B.TreatmentTypeId
GROUP BY A.TreatmentTypeId, TreatmentTypeName
HAVING COUNT(A.TreatmentTypeId) > 5
ORDER BY COUNT(A.TreatmentTypeId) DESC

--Soal 8
SELECT LEFT(StaffName, CHARINDEX(' ', StaffName, 1)), A.TransactionId, COUNT(D.TreatmentId) AS [Total Treatment per Transaction]
FROM HeaderSalonServices A
JOIN MsStaff B
	ON A.StaffId = B.StaffId
JOIN DetailSalonServices C
	ON A.TransactionId = C.TransactionId
JOIN MsTreatment D
	ON D.TreatmentId = C.TreatmentId
GROUP BY StaffName, A.TransactionId

--Soal 9
SELECT TransactionDate, CustomerName, TreatmentName, Price
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
JOIN MsStaff C
	ON A.StaffId = C.StaffId
JOIN DetailSalonServices D
	ON A.TransactionId = D.TransactionId
JOIN MsTreatment E
	ON D.TreatmentId =  E.TreatmentId
WHERE DATENAME(WEEKDAY, TransactionDate) = 'Thursday' AND StaffName LIKE '%Ryan%'
ORDER BY TransactionDate, CustomerName ASC

--Soal 10
SELECT TransactionDate, CustomerName, SUM(Price) AS TotalPrice
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
JOIN DetailSalonServices C
	On A.TransactionId = C.TransactionId
JOIN MsTreatment D
	ON D.TreatmentId = C.TreatmentId
GROUP BY CustomerName, TransactionDate
HAVING DAY(TransactionDate) > 20
ORDER BY TransactionDate ASC