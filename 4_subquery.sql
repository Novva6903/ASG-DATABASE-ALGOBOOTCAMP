	USE OOVEO_Salon

--Soal 1
SELECT TreatmentId, TreatmentName
FROM MsTreatment
WHERE TreatmentId IN('TM001', 'TM002')

--Soal 2
SELECT TreatmentName, Price
FROM MsTreatment
WHERE TreatmentTypeId NOT IN('TT001', 'TT002')

--Soal 3
SELECT CustomerName, CustomerPhone, CustomerAddress
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
WHERE LEN(CustomerName) > 8 AND DATENAME(WEEKDAY, TransactionDate) IN('Friday')

--Soal 4
SELECT TreatmentTypeName, TreatmentName, Price
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
JOIN DetailSalonServices C
	ON A.TransactionId = C.TransactionId
JOIN MsTreatment D
	ON C.TreatmentId = D.TreatmentId
JOIN MsTreatmentType E
	ON D.TreatmentTypeId = E.TreatmentTypeId
WHERE CustomerName LIKE '%Putra%' AND DAY(TransactionDate) IN(22)

--Soal 5
SELECT StaffName, CustomerName, CONVERT(VARCHAR, TransactionDate, 107) AS TransactionDate
FROM HeaderSalonServices A
JOIN MsStaff B
	ON A.StaffId = B.StaffId
JOIN MsCustomer C
	ON A.CustomerId = C.CustomerId
WHERE EXISTS(SELECT TreatmentId FROM DetailSalonServices AS D WHERE A.TransactionId = D.TransactionId AND RIGHT(TreatmentId, 1) % 2 = 0)

--Soal 6
SELECT CustomerName, CustomerPhone, CustomerAddress
FROM HeaderSalonServices A
JOIN MsCustomer B
	ON A.CustomerId = B.CustomerId
WHERE EXISTS(SELECT StaffName FROM MsStaff AS C WHERE A.StaffId = C.StaffId AND LEN(StaffName) % 2 != 0)

--Soal 7
SELECT RIGHT(B.StaffId, 3) AS ID, SUBSTRING(StaffName, CHARINDEX(' ', StaffName, 1) + 1, CHARINDEX(' ', StaffName, CHARINDEX(' ', StaffName, 1)+1) - CHARINDEX(' ', StaffName,1)) AS Name
FROM MsStaff A
JOIN HeaderSalonServices B
	ON A.StaffId = B.StaffId
WHERE StaffName LIKE '% % %' AND EXISTS(SELECT CustomerGender FROM MsCustomer AS C WHERE B.CustomerId = C.CustomerId AND CustomerGender NOT LIKE 'Male')
ORDER BY B.StaffId

--Soal 8
SELECT TreatmentTypeName, TreatmentName, Price
FROM MsTreatment A
JOIN MsTreatmentType B
	ON A.TreatmentTypeId = B.TreatmentTypeId
WHERE Price > ALL(SELECT AVG(Price) FROM MsTreatment)

--Soal 9
SELECT StaffName, StaffPosition, StaffSalary 
FROM MsStaff
WHERE StaffSalary = ANY(SELECT MAX(StaffSalary) FROM MsStaff) OR StaffSalary = ANY(SELECT MIN(StaffSalary) FROM MsStaff)

--Soal 10
SELECT TOP 1 CustomerName, CustomerPhone, CustomerAddress, COUNT(TreatmentId) AS [Count Treatment]
FROM MsCustomer A
JOIN HeaderSalonServices B
	ON A.CustomerId = B.CustomerId
JOIN DetailSalonServices C
	ON B.TransactionId = C.TransactionId
GROUP BY CustomerName, CustomerPhone, CustomerAddress
HAVING Count(TreatmentId) >= (
	SELECT MAX(y.num)
	FROM (SELECT COUNT(TreatmentId) AS num 
		FROM DetailSalonServices A
		JOIN HeaderSalonServices B
			ON A.TransactionId = B.TransactionId
		JOIN MsCustomer C
			ON C.CustomerId = B.CustomerId
		GROUP BY CustomerName
	) AS y
)