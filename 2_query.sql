USE OOVEO_Salon

--Soal 1
SELECT *
FROM MsStaff
WHERE StaffGender = 'Female'

--Soal 2
SELECT StaffName, CAST('Rp. ' AS VARCHAR) + CAST(StaffSalary AS VARCHAR) AS StaffSalary
FROM MsStaff
WHERE StaffName LIKE '%m%' AND StaffSalary >= 10000000

--Soal 3
SELECT TreatmentName, Price
FROM MsTreatment
WHERE TreatmentTypeId IN('TT002', 'TT003')

--Soal 4
SELECT StaffName, StaffPosition, CONVERT(varchar, TransactionDate, 107) AS TransactionDate
FROM HeaderSalonServices A
JOIN MsStaff B
	ON A.StaffId = B.StaffId
WHERE StaffSalary BETWEEN 7000000 AND 10000000

--Soal 5
SELECT SUBSTRING(CustomerName, 1, CHARINDEX(' ', CustomerName)) AS Name, LEFT(CustomerGender, 1) AS Gender, PaymentType AS 'Payment Type'
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
WHERE PaymentType = 'Debit'

--Soal 6
SELECT UPPER(LEFT(CustomerName, 1) + SUBSTRING(CustomerName, CHARINDEX(' ', CustomerName) + 1, 1)) AS Initial, DATENAME(WEEKDAY, TransactionDate) AS Day
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
WHERE DATEDIFF(DAY, '2012/12/24', TransactionDate) BETWEEN -2 AND 2

--Soal 7
SELECT TransactionDate, REVERSE(SUBSTRING(REVERSE(CustomerName), 1, CHARINDEX(' ', REVERSE(CustomerName)) - 1)) AS CustomerName
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
WHERE CustomerName LIKE '% %' AND DATENAME(WEEKDAY, TransactionDate) = 'Saturday'

--Soal 8
SELECT StaffName, CustomerName, REPLACE(CustomerPhone, '0', '+62') AS CustomerPhone, CustomerAddress
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
JOIN MsStaff C
	ON A.StaffId = C.StaffId
WHERE StaffName LIKE '% % %' AND CustomerName LIKE '[aiueo]%'

--Soal 9
SELECT StaffName, TreatmentName, DATEDIFF(DAY, TransactionDate, '2012/12/24') AS 'Term of Transaction'
FROM DetailSalonServices A
JOIN HeaderSalonServices B
	ON A.TransactionId = B.TransactionId
JOIN MsStaff C
	ON B.StaffId = C.StaffId
JOIN MsTreatment D
	ON A.TreatmentId = D.TreatmentId
WHERE LEN(TreatmentName) > 20 OR TreatmentName LIKE '% %'

--Soal 10
SELECT TransactionDate, CustomerName, TreatmentName, CAST(Price AS INT)*20/100 AS Discount, PaymentType AS 'Payment Type'
FROM DetailSalonServices A
JOIN HeaderSalonServices B
	ON A.TransactionId = B.TransactionId
JOIN MsStaff C
	ON B.StaffId = C.StaffId
JOIN MsTreatment D
	ON A.TreatmentId = D.TreatmentId
JOIN MsCustomer E
	ON B.CustomerId = E.CustomerId
WHERE TransactionDate = '2012/12/22'