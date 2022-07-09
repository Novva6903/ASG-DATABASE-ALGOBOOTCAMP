USE OOVEO_Salon

--Soal 1
CREATE PROCEDURE sp1(
	@id VARCHAR(10)
)
AS
	SELECT CustomerId, CustomerName, CustomerGender, CustomerAddress
	FROM MsCustomer
	WHERE CustomerId = @id
GO

EXEC sp1 'CU001'

GO

--Soal 2
CREATE PROCEDURE sp2(
	@name VARCHAR(20)
)
AS
	IF LEN(@name) % 2 = 0
		BEGIN
			SELECT a.CustomerId, CustomerName, CustomerGender, TransactionId, TransactionDate
			FROM MsCustomer a
			JOIN HeaderSalonServices b
				ON a.CustomerId = b.CustomerId
			WHERE CustomerName LIKE '%' + @name + '%'
		END
	ELSE
		BEGIN
			PRINT 'Character Length of Customer Name is an Odd Number'
		END
GO

EXEC sp2 'Elysia Chen'
GO

EXEC sp2 'Fran'
GO

--make begin tran biar ga keubah databasenya
--Soal 3
CREATE PROCEDURE sp3(
	@id VARCHAR(10),
	@name VARCHAR(20),
	@gender VARCHAR(10),
	@phone VARCHAR(20)
)
AS
	IF EXISTS(SELECT * FROM MsStaff WHERE StaffId = @id)
		BEGIN
			UPDATE MsStaff
			SET StaffName = @name, StaffGender = @gender, StaffPhone = @phone
			WHERE StaffId = @id

			SELECT *
			FROM MsStaff
		END
	ELSE
		BEGIN
			PRINT 'Staff does not exists'
		END
GO

EXEC sp3 'SF005', 'Ryan Nixon', 'M', '08567756123'
GO

EXEC sp3 'SF008', 'Ryan Nixon', 'M', '08567756123'
GO

--Soal 4
CREATE TRIGGER trig1
ON MsCustomer
AFTER UPDATE
AS
	SELECT *
	FROM deleted
	UNION
	SELECT *
	FROM inserted
GO

UPDATE MsCustomer SET CustomerName = 'Franky Quo' WHERE CustomerId = 'CU001'

--Soal 5
CREATE TRIGGER trig2
ON MsCustomer
AFTER INSERT
AS
	DELETE TOP(1) FROM MsCustomer
	SELECT *
	FROM MsCustomer
GO

INSERT INTO MsCustomer
VALUES ('CU006', 'Yogie soesanto', 'Male', '085562133000', 'Pelkasih Street no 52')

--Soal 6
CREATE OR ALTER TRIGGER trig3
ON MsCustomer
AFTER DELETE
AS
	IF OBJECT_ID('Removed') is not null
		INSERT INTO Removed
		SELECT * FROM deleted
	ELSE
		SELECT *
		INTO Removed
		FROM deleted
	SELECT *
	FROM Removed
GO

DELETE FROM MsCustomer WHERE CustomerId = 'CU002'

--Soal 7
DECLARE @name VARCHAR(20)

DECLARE Scursor CURSOR
FOR SELECT StaffName FROM MsStaff

OPEN Scursor

FETCH NEXT FROM Scursor INTO @name

WHILE @@FETCH_STATUS = 0
	BEGIN
		IF LEN(@name) % 2 = 0
			PRINT 'The Length from StaffName ' + @name + ' is an odd number'
		ELSE
			PRINT 'The Length from StaffName ' + @name + ' is an even number'
		FETCH NEXT FROM Scursor INTO @name
	END

CLOSE Scursor

DEALLOCATE Scursor
GO

--Soal 8
CREATE PROCEDURE sp4(
	@contain VARCHAR(10)
)
AS
	DECLARE
		@name VARCHAR(20),
		@position VARCHAR(50)

	DECLARE Scursor CURSOR
	FOR
		SELECT StaffName, StaffPosition
		FROM MsStaff

	OPEN Scursor

	FETCH NEXT FROM Scursor INTO 
		@name,
		@position

	WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @name LIKE '%' + @contain + '%'
				PRINT 'Staff Name: ' + @name + ' Position: ' + @position
			FETCH NEXT FROM Scursor INTO 
				@name,
				@position
		END

	CLOSE Scursor

	DEALLOCATE Scursor
GO

EXEC sp4 'a'

--Soal 9
CREATE OR ALTER PROCEDURE sp5(
	@id VARCHAR(10)
)
AS
	DECLARE
		@CustId VARCHAR(20),
        @name VARCHAR(20),
        @date VARCHAR(50),
		@TranId VARCHAR(10)

    DECLARE Ccursor CURSOR
    FOR
        SELECT a.CustomerId, CustomerName, TransactionDate, TransactionId
        FROM MsCustomer a
		JOIN HeaderSalonServices b
			ON a.CustomerId = b.CustomerId

    OPEN Ccursor

    FETCH NEXT FROM Ccursor INTO
		@CustId,
        @name,
        @date,
		@TranId

    WHILE @@FETCH_STATUS = 0
        BEGIN
			IF RIGHT(@TranId, 1) % 2 = 0 AND @CustId IN(@id) 
				PRINT 'Customer Name: ' + @name + ' Transaction Date is ' + @date
            FETCH NEXT FROM Ccursor INTO
				@CustId,
                @name,
                @date,
				@TranId
        END

    CLOSE Ccursor

    DEALLOCATE Ccursor
GO

EXEC sp5 'CU001'

--Soal 10
DROP PROC sp1
DROP PROC sp2
DROP PROC sp3
DROP PROC sp4
DROP PROC sp5

DROP TRIGGER trig1
DROP TRIGGER trig2
DROP TRIGGER trig3