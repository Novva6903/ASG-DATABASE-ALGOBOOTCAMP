USE Salon

--Soal 1
CREATE TABLE MsCustomer(
	CustomerId CHAR(5) NOT NULL,
	CustomerName VARCHAR(50),
	CustomerGender VARCHAR(10),
	CustomerPhone VARCHAR(13),
	CustomerAddress VARCHAR(100),

	CONSTRAINT check_id_customer
		CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]'),
	
	CONSTRAINT check_gender_customer
		CHECK(CustomerGender = 'Male' OR CustomerGender = 'Female'),

	CONSTRAINT Id_PK_Customer
		PRIMARY KEY(CustomerId),
)

CREATE TABLE MsStaff(
	StaffId CHAR(5) NOT NULL,
	StaffName VARCHAR(50),
	StaffGender VARCHAR(10),
	StaffPhone VARCHAR(13),
	StaffAddress VARCHAR(100),
	StaffSalary NUMERIC(11,2),
	StaffPosition VARCHAR(20),

	CONSTRAINT check_id_staff
		CHECK(StaffId LIKE 'SF[0-9][0-9][0-9]'),
	
	CONSTRAINT check_gender_staff
		CHECK(StaffGender = 'Male' OR StaffGender = 'Female'),

	CONSTRAINT Id_PK_Staff
		PRIMARY KEY(StaffId),
)

CREATE TABLE MsTreatmentType(
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentTypeName VARCHAR(50),

	CONSTRAINT check_id_treatment_type
		CHECK(TreatmentTypeId LIKE 'TT[0-9][0-9][0-9]'),

	CONSTRAINT Id_PK_treatment_type
		PRIMARY KEY(TreatmentTypeId),
)

CREATE TABLE MsTreatment(
	TreatmentId CHAR(5) NOT NULL,
	TreatmentTypeId CHAR(5) NOT NULL,
	TreatmentName VARCHAR(50),
	Price NUMERIC(11,2),

	CONSTRAINT check_id_treatment
		CHECK(TreatmentId LIKE 'TM[0-9][0-9][0-9]'),

	CONSTRAINT Id_PK_treatment
		PRIMARY KEY(TreatmentId),

	CONSTRAINT id_FK_treatment_type
		FOREIGN KEY(TreatmentTypeId) REFERENCES MsTreatmentType(TreatmentTypeId)
		ON UPDATE CASCADE
)

CREATE TABLE HeaderSalonServices(
	TransactionId CHAR(5) NOT NULL,
	CustomerId CHAR(5) NOT NULL,
	StaffId CHAR(5) NOT NULL,
	TransactionDate DATE,
	PaymentType VARCHAR(20),

	CONSTRAINT check_id_transaction
		CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]'),

	CONSTRAINT id_FK_Customer
		FOREIGN KEY(CustomerId) REFERENCES MsCustomer(CustomerId)
		ON UPDATE CASCADE,

	CONSTRAINT id_FK_staff
		FOREIGN KEY(StaffId) REFERENCES MsStaff(StaffId)
		ON UPDATE CASCADE,

	CONSTRAINT id_PK_transaction
		PRIMARY KEY(TransactionId),
)

CREATE TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	CONSTRAINT id_FK_transaction
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId)
		ON UPDATE CASCADE,

	CONSTRAINT id_FK_treatment
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatment(TreatmentId)
		ON UPDATE CASCADE,

	CONSTRAINT id_PK_transaction_detail
		PRIMARY KEY(TransactionId, TreatmentId)
)

--Soal 2
DROP TABLE DetailSalonServices

--Soal 3
CREATE TABLE DetailSalonServices(
	TransactionId CHAR(5) NOT NULL,
	TreatmentId CHAR(5) NOT NULL,

	CONSTRAINT id_FK_transaction
		FOREIGN KEY(TransactionId) REFERENCES HeaderSalonServices(TransactionId)
		ON UPDATE CASCADE,

	CONSTRAINT id_FK_treatment
		FOREIGN KEY(TreatmentId) REFERENCES MsTreatment(TreatmentId)
		ON UPDATE CASCADE,
)

ALTER TABLE DetailSalonServices
ADD CONSTRAINT id_PK_transac_treat
	PRIMARY KEY(TransactionId, TreatmentId)

--Soal 4
ALTER TABLE MsStaff WITH NOCHECK
ADD CONSTRAINT StaffNameLength
	CHECK(LEN(StaffName) >= 5 AND LEN(StaffName) <= 20)

ALTER TABLE MsStaff
DROP CONSTRAINT StaffNameLength

--Soal 5
ALTER TABLE MsCustomer
ADD Description VARCHAR(100)

ALTER TABLE MsCustomer
DROP COLUMN Description

--View & Delete
SELECT *
FROM MsCustomer

DROP TABLE IF EXISTS MsCustomer
DROP TABLE IF EXISTS MsStaff
DROP TABLE IF EXISTS MsTreatment
DROP TABLE IF EXISTS MsTreatmentType
DROP TABLE IF EXISTS HeaderSalonServices
DROP TABLE IF EXISTS DetailSalonServices