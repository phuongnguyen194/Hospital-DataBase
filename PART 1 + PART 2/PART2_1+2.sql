use mydb;
-- a
-- Increase Inpatient Fee to 10% for all the inpatients who are admitted to hospital from 01/09/2020.

DELIMITER $$
drop procedure if exists increase_fee;
CREATE PROCEDURE increase_fee()
BEGIN
	UPDATE INPATIENT 
	SET
        	Fee = Fee*1.1
	WHERE 
		`Date of admission` > '2020-09-01';
END; $$
DELIMITER ;

CALL mydb.increase_fee()

-- b
-- Select all the patients (outpatient & inpatient) of the doctor 
-- named ‘Nguyen Van A’.

DELIMITER $$
drop procedure if exists print_patients_of_doctor;
CREATE PROCEDURE mydb.print_patients_of_doctor(FirstName varchar(50), LastName varchar(50))
BEGIN
	SELECT P.`Last Name`, P.`First Name`
	FROM mydb.`PATIENT` AS P
	INNER JOIN mydb.`OUTPATIENT` AS O ON P.`PATCode` = O.`OUTCode`
	INNER JOIN mydb.`EMPLOYEE` as E ON O.`ExaminingDOCcode` = E.`EMPcode`
	WHERE E.`First Name` = FirstName and E.`Last Name` = LastName
	UNION ALL
	SELECT P.`Last Name`, P.`First Name`
	FROM mydb.`PATIENT` AS P
	INNER JOIN mydb.`is_treated_by` AS T ON P.`PATCode` = T.`INCode`
	INNER JOIN mydb.`EMPLOYEE` as E ON T.`DOCcode` = E.`EMPcode`
	WHERE E.`First Name` = FirstName and E.`Last Name` = LastName;
END; $$
DELIMITER ;

CALL mydb.print_patients_of_doctor('A', 'Nguyen')
