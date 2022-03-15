-- utils procedures
use mydb;

-- Insert inpatient and patient at the same time
DELIMITER $$
drop procedure if exists insert_inpatient;
CREATE PROCEDURE mydb.insert_inpatient(
-- patient
IN PATcode CHAR(11) ,
IN Address VARCHAR(50),
IN FName VARCHAR(50),
IN LName VARCHAR(50),
IN DateofBirth DATE,
IN Gender CHAR(1) ,
IN Phonenumber CHAR(10) ,  
-- INpatient
IN NURcode SMALLINT,
IN Date_admission DATE,
IN Sickroom TINYINT,
IN DateDischarge DATE,
IN Fee DECIMAL(10,2) ,
IN Diagnosis VARCHAR(50)
)
BEGIN
	INSERT INTO patient VALUES (PATcode, Address, FName, LName, DateofBirth, Gender, Phonenumber);
    INSERT INTO inpatient VALUES (PATcode, NURcode, Date_admission, Sickroom, DateDischarge, Fee, Diagnosis);
END; $$
DELIMITER ;

-- Insert outpatient and patient at the same time
use mydb;
DELIMITER $$
drop procedure if exists insert_outpatient;
CREATE PROCEDURE mydb.insert_outpatient(
-- patient
IN PATcode CHAR(11) ,
IN Address VARCHAR(50),
IN FName VARCHAR(50),
IN LName VARCHAR(50),
IN DateofBirth DATE,
IN Gender CHAR(1) ,
IN Phonenumber CHAR(10) , 
-- OUTpatient
ExaminingDOCcode SMALLINT
)
BEGIN
	INSERT INTO patient VALUES (PATcode, Address, FName, LName, DateofBirth, Gender, Phonenumber);
    INSERT INTO outpatient VALUES (PATcode, ExaminingDOCcode);
END; $$
DELIMITER ;

-- Insert Doctor or Nurse information
use mydb;
DELIMITER $$
drop procedure if exists insert_emp;
CREATE PROCEDURE mydb.insert_emp(
-- bool
isDoctor BOOL,
-- employee
EMPcode SMALLINT ,
Address VARCHAR(50) ,
Gender CHAR(1) ,
Dateofbirth DATE,
StartDate DATE ,
SpecName VARCHAR(50) ,
Spec_Degree_year TINYINT(2) ,
Fname VARCHAR(50) ,
Lname VARCHAR(50),
DEPcode SMALLINT 
)
BEGIN
	IF isDoctor=True
    THEN 
		INSERT INTO doctor VALUE(EMPcode);
	ELSE
		INSERT INTO nurse VALUE(EMPcode);
    END IF;
    INSERT INTO mydb.employee VALUE (EMPcode, Address, Gender, Dateofbirth, StartDate, SpecName,Spec_Degree_year, Fname, Lname, DEPcode);
END; $$
DELIMITER ;

-- --------------------------- TRIGGER
-- INSERT & UPDATE INPATIENT
delimiter //
drop TRIGGER if exists insert_INpatient;
CREATE TRIGGER insert_INpatient    
     BEFORE INSERT ON mydb.`inpatient` 
     FOR EACH ROW    
        BEGIN
			IF LEFT(NEW.INcode,2) != 'IP'
            THEN 
				SIGNAL SQLSTATE '20000'
					SET MESSAGE_TEXT = 'Wrong PATcode';
			END IF;
		END;  //
delimiter ;

delimiter //
drop TRIGGER if exists insert_INpatient;
CREATE TRIGGER insert_INpatient    
     BEFORE UPDATE ON mydb.`inpatient` 
     FOR EACH ROW    
        BEGIN
			IF LEFT(NEW.INcode,2) != 'IP'
            THEN 
				SIGNAL SQLSTATE '20000'
					SET MESSAGE_TEXT = 'Wrong PATcode';
			END IF;
		END;  //
delimiter ;

-- INSERT & UPDATE OUTPATIENT
delimiter //
drop TRIGGER if exists insert_OUTpatient;
CREATE TRIGGER insert_OUTpatient    
     BEFORE INSERT ON mydb.`outpatient` 
     FOR EACH ROW    
        BEGIN
			IF LEFT(NEW.OUTcode,2) != 'OP'
            THEN 
				SIGNAL SQLSTATE '20000'
					SET MESSAGE_TEXT = 'Wrong PATcode';
			END IF;
		END;  //
delimiter ;

delimiter //
drop TRIGGER if exists insert_OUTpatient;
CREATE TRIGGER insert_OUTpatient    
     BEFORE UPDATE ON mydb.`outpatient` 
     FOR EACH ROW    
        BEGIN
			IF LEFT(NEW.OUTcode, 2) != 'OP'
            THEN 
				SIGNAL SQLSTATE '20000'
					SET MESSAGE_TEXT = 'Wrong PATcode';
			END IF;
		END;  //
delimiter ;

SET FOREIGN_KEY_CHECKS=0; 

INSERT INTO inpatient VALUES ('IL000000001', 1,'2021-1-1', 12, '2021-2-1', 100.0, 'Pharyngitis');
INSERT INTO outpatient VALUES ('AB000000001', 1);
CALL mydb.insert_emp(True, 10, '5 ManCity', 'F', '2001-1-1', '2019-1-1', 'Ophthalmologists',2, 'A', 'Nguyen', 1);
CALL mydb.insert_inpatient('IP000000010', '1 Mancity', 'A', 'Nguyen', '2000-12-2', 1, '123456789', 1,'2021-1-1', 12, '2021-2-1', 100.0, 'Pharyngitis');
CALL mydb.insert_outpatient('OP000000009', '1 Mancity', 'E', 'Nguyen', '2000-12-2', 0, '123456713', 1);
CALL mydb.insert_inpatient('IK000000010', '1 Mancity', 'A', 'Nguyen', '2000-12-2', 1, '123456789', 1,'2021-1-1', 12, '2021-2-1', 100.0, 'Pharyngitis');
CALL mydb.insert_outpatient('OL000000009', '1 Mancity', 'E', 'Nguyen', '2000-12-2', 0, '123456713', 1);
