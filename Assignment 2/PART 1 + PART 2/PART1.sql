-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `mydb`;
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mydb_new
-- -----------------------------------------------------
USE `mydb` ;
SET FOREIGN_KEY_CHECKS=0; 
-- -----------------------------------------------------
-- Table `mydb`.`EMPLOYEE`
-- -----------------------------------------------------


CREATE TABLE IF NOT EXISTS `mydb`.`EMPLOYEE` (
  `EMPcode` SMALLINT UNSIGNED NOT NULL,
  `Address` VARCHAR(50) NULL DEFAULT NULL,
  `Gender` CHAR(1) DEFAULT NULL,
  `Date of birth` DATE NULL DEFAULT NULL,
  `Start date` DATE NULL DEFAULT NULL,
  `SpecName` VARCHAR(50) NULL DEFAULT NULL,
  `Spec_Degree's year` TINYINT(2) UNSIGNED NOT NULL,
  `First name` VARCHAR(50) NOT NULL,
  `Last name` VARCHAR(50) NOT NULL,
  `DEPcode` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`EMPcode`),
  INDEX `fk_EMPLOYEE_DEPARTMENT1_idx` (`DEPcode` ASC) VISIBLE,
  CONSTRAINT `fk_EMPLOYEE_DEPARTMENT1`
    FOREIGN KEY (`DEPcode`)
    REFERENCES `mydb`.`DEPARTMENT` (`DEPcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

insert into mydb.employee VALUE (1, '5 ManCity', 'F', '2001-1-1', '2019-1-1', 'Ophthalmologists',2, 'A', 'Nguyen', 1);
insert into mydb.employee VALUE (2, '5 ManUtd', 'F', '2001-1-2', '2019-1-1', 'Ophthalmologists', 3, 'B ', 'Nguyen', 2);
insert into mydb.employee VALUE (3, '5 Liverpool', 'M', '2001-1-1', '2019-1-1', 'Dermatologists',2, 'C', 'Nguyen', 3);
insert into mydb.employee VALUE (4, '5 Ansernal', 'F', '2001-1-2', '2019-1-4', 'Dermatologists', 3, 'D ', 'Nguyen', 4);
insert into mydb.employee VALUE (5, '5 ManCity', 'M', '2001-1-1', '2019-1-1', 'Ophthalmologists',2, 'E', 'Nguyen', 1);
insert into mydb.employee VALUE (6, '5 ManUtd', 'F', '2001-1-2', '2019-1-1', 'Ophthalmologists', 3, 'F ', 'Nguyen', 2);
insert into mydb.employee VALUE (7, '5 Liverpool', 'M', '2001-1-1', '2019-1-1', 'Dermatologists',2, 'G', 'Nguyen', 1);
insert into mydb.employee VALUE (8, '5 Ansernal', 'M', '2001-1-2', '2019-1-4', 'Dermatologists', 3, 'H ', 'Nguyen', 4);
-- -----------------------------------------------------
-- Table `mydb`.`DOCTOR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DOCTOR` (
  `DOCcode` SMALLINT UNSIGNED NOT NULL,
  INDEX `fk_DOCTOR_EMPLOYEE_idx` (`DOCcode` ASC) VISIBLE,
  PRIMARY KEY (`DOCcode`),
  CONSTRAINT `fk_DOCTOR_EMPLOYEE`
    FOREIGN KEY (`DOCcode`)
    REFERENCES `mydb`.`EMPLOYEE` (`EMPcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO doctor VALUE(1);
INSERT INTO doctor VALUE(2);
INSERT INTO doctor VALUE(3);
INSERT INTO doctor VALUE(4);

-- -----------------------------------------------------
-- Table `mydb`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DEPARTMENT` (
  `DEPcode` SMALLINT UNSIGNED NOT NULL,
  `Title` VARCHAR(50) NOT NULL,
  `DOCcode` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`DEPcode`, `DOCcode`),
  INDEX `fk_DEPARTMENT_DOCTOR1_idx` (`DOCcode` ASC) VISIBLE,
  CONSTRAINT `fk_DEPARTMENT_DOCTOR1`
    FOREIGN KEY (`DOCcode`)
    REFERENCES `mydb`.`DOCTOR` (`DOCcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO mydb.department VALUE ('1', 'A', '4');
INSERT INTO mydb.department VALUE ('2', 'B', '2');
INSERT INTO mydb.department VALUE ('3', 'C', '1');
INSERT INTO mydb.department VALUE ('4', 'D', '3');

-- -----------------------------------------------------
-- Table `mydb`.`EMP_PHONENUMBERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`EMP_PHONENUMBERS` (
  `EMPcode` SMALLINT UNSIGNED NOT NULL,
  `phone number` CHAR(10) NOT NULL,
  PRIMARY KEY (`EMPcode`, `phone number`),
  INDEX `fk_EMP_PHONENUMBERS_EMPLOYEE1_idx` (`EMPcode` ASC) VISIBLE,
  CONSTRAINT `fk_EMP_PHONENUMBERS_EMPLOYEE1`
    FOREIGN KEY (`EMPcode`)
    REFERENCES `mydb`.`EMPLOYEE` (`EMPcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO emp_phonenumbers VALUE ('1','111222333');
INSERT INTO emp_phonenumbers VALUE ('2','111222334');
INSERT INTO emp_phonenumbers VALUE ('3','111222335');
INSERT INTO emp_phonenumbers VALUE ('4','111222336');
INSERT INTO emp_phonenumbers VALUE ('5','111222337');
INSERT INTO emp_phonenumbers VALUE ('6','111222338');
INSERT INTO emp_phonenumbers VALUE ('7','111222339');
INSERT INTO emp_phonenumbers VALUE ('8','111222340');
INSERT INTO emp_phonenumbers VALUE ('7','111222341');
INSERT INTO emp_phonenumbers VALUE ('6','111222342');
INSERT INTO emp_phonenumbers VALUE ('5','111222343');
INSERT INTO emp_phonenumbers VALUE ('4','111222344');

-- -----------------------------------------------------
-- Table `mydb`.`NURSE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`NURSE` (
  `NURcode` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`NURcode`),
  CONSTRAINT `fk_NURSE_EMPLOYEE1`
    FOREIGN KEY (`NURcode`)
    REFERENCES `mydb`.`EMPLOYEE` (`EMPcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO nurse VALUE(5);
INSERT INTO nurse VALUE(6);
INSERT INTO nurse VALUE(7);
INSERT INTO nurse VALUE(8);

-- -----------------------------------------------------
-- Table `mydb`.`PATIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PATIENT` (
  `PATcode` CHAR(11) NOT NULL,
  `Address` VARCHAR(50) NULL,
  `First Name` VARCHAR(50) NULL,
  `Last Name` VARCHAR(50) NULL,
  `Date of Birth` DATE NULL,
  `Gender` CHAR(1) NULL,
  `Phone number` CHAR(10) NULL,
  PRIMARY KEY (`PATcode`))
ENGINE = InnoDB;

INSERT INTO patient VALUES ('IP000000001', '1 Mancity', 'A', 'Nguyen', '2000-12-2', 'F', '123456789');
INSERT INTO patient VALUES ('IP000000002', '1 ManUtd', 'B', 'Nguyen', '2000-12-2', 'U', '123456710');
INSERT INTO patient VALUES ('IP000000003', '1 Ansernal', 'C', 'Nguyen', '2000-12-2', 'F', '123456711');
INSERT INTO patient VALUES ('IP000000004', '1 Liverpool', 'D', 'Nguyen', '2000-12-2', 'F', '123456712');
INSERT INTO patient VALUES ('OP000000001', '1 Mancity', 'E', 'Nguyen', '2000-12-2', 'M', '123456713');
INSERT INTO patient VALUES ('OP000000002', '1 ManUtd', 'F', 'Nguyen', '2000-12-2', 'M', '123456714');
INSERT INTO patient VALUES ('OP000000003', '1 Mancity', 'G', 'Nguyen', '2000-12-2', 'M', '123456715');
INSERT INTO patient VALUES ('OP000000004', '1 Ansernal', 'H', 'Nguyen', '2000-12-2', 'M', '123456716');



-- -----------------------------------------------------
-- Table `mydb`.`OUTPATIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OUTPATIENT` (
  `OUTcode` CHAR(11) NOT NULL,
  `ExaminingDOCcode` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`OUTcode`),
  INDEX `fk_OUTPATIENT_DOCTOR1_idx` (`ExaminingDOCcode` ASC) VISIBLE,
  INDEX `fk_OUTPATIENT_PATIENT1_idx` (`OUTcode` ASC) VISIBLE,
  CONSTRAINT `fk_OUTPATIENT_DOCTOR1`
    FOREIGN KEY (`ExaminingDOCcode`)
    REFERENCES `mydb`.`DOCTOR` (`DOCcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_OUTPATIENT_PATIENT1`
    FOREIGN KEY (`OUTcode`)
    REFERENCES `mydb`.`PATIENT` (`PATcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO outpatient VALUES ('OP000000001', 1);
INSERT INTO outpatient VALUES ('OP000000002', 4);
INSERT INTO outpatient VALUES ('OP000000003', 1);
INSERT INTO outpatient VALUES ('OP000000004', 2);

-- -----------------------------------------------------
-- Table `mydb`.`OUTPATIENT_EXAMINATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`OUTPATIENT_EXAMINATION` (
  `Date` DATE NOT NULL,
  `Fee` DECIMAL(10,2) NOT NULL,
  `Diagnosis` VARCHAR(50) NOT NULL,
  `Next examination date` DATE NOT NULL,
  `OUTcode` CHAR(11) NOT NULL,
  PRIMARY KEY (`Date`, `Fee`, `Diagnosis`, `Next examination date`, `OUTcode`),
  INDEX `fk_OUTPATIENT_EXAMINATION_OUTPATIENT1_idx` (`OUTcode` ASC) VISIBLE,
  CONSTRAINT `fk_OUTPATIENT_EXAMINATION_OUTPATIENT1`
    FOREIGN KEY (`OUTcode`)
    REFERENCES `mydb`.`OUTPATIENT` (`OUTcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO outpatient_examination VALUES ('2021-1-1', 12.0, 'Diabetes', '2021-2-1', 'OP000000001');
INSERT INTO outpatient_examination VALUES ('2021-1-1', 100.10, 'Chickenpox', '2021-2-1', 'OP000000002');
INSERT INTO outpatient_examination VALUES ('2021-1-1', 90.30, 'Depression', '2021-2-1', 'OP000000003');
INSERT INTO outpatient_examination VALUES ('2021-1-1', 134.0, 'Cyclospora', '2021-2-1', 'OP000000004');

-- -----------------------------------------------------
-- Table `mydb`.`MEDICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEDICATION` (
  `MEDcode` SMALLINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NULL,
  `Price` DECIMAL(10,2) NULL,
  `Expiration Date` DATE NULL,
  PRIMARY KEY (`MEDcode`))
ENGINE = InnoDB;

INSERT INTO medication VALUES (1,'Adderall', 100, '2025-5-10');
INSERT INTO medication VALUES (2,'Amlodipine', 70, '2025-5-10');
INSERT INTO medication VALUES (3,'Brilinta', 50, '2025-5-10');
INSERT INTO medication VALUES (4,'Chloroquine', 1000, '2025-5-10');

-- -----------------------------------------------------
-- Table `mydb`.`OUTPATIENT_EXAMINATION_MEDICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`outpatient_examination_medication` (
  `OUTCode` CHAR(11) NOT NULL,
  `Date` DATE NOT NULL,
  `Fee` DECIMAL(10,2) NOT NULL,
  `Diagnosis` VARCHAR(50) NOT NULL,
  `Next examination date` DATE NOT NULL,
  `MEDcode` SMALLINT NOT NULL,
  PRIMARY KEY (`OUTCode`, `Next examination date`, `Fee`, `Date`, `MEDcode`),
  INDEX `fk_outpatient_examination_medication_medication1_idx` (`MEDcode` ASC) VISIBLE,
  INDEX `fk_outpatient_examination_medication_outpatient_examination_idx` (`Date` ASC, `Fee` ASC, `Diagnosis` ASC, `Next examination date` ASC, `OUTcode` ASC) VISIBLE,
  CONSTRAINT `fk_outpatient_examination_medication_medication1`
    FOREIGN KEY (`MEDcode`)
    REFERENCES `mydb`.`medication` (`MEDcode`),
  CONSTRAINT `fk_outpatient_examination_medication_outpatient_examination1`
    FOREIGN KEY (`Date` , `Fee` , `Diagnosis` , `Next examination date` , `OUTcode`)
    REFERENCES `mydb`.`outpatient_examination` (`Date` , `Fee` , `Diagnosis` , `Next examination date` , `OUTcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO outpatient_examination_medication VALUES('OP000000001', '2021-10-5', 100,'Diabetes', '2021-11-5',1 );
INSERT INTO outpatient_examination_medication VALUES('OP000000002', '2020-10-5', 50,'Chickenpox', '2020-11-5',2 );
INSERT INTO outpatient_examination_medication VALUES('OP000000003', '2019-10-5', 4000, 'Depression', '2019-11-5',4 );
INSERT INTO outpatient_examination_medication VALUES('OP000000004', '2018-10-5', 12, 'Cyclospora', '2018-11-5',2 );

-- -----------------------------------------------------
-- Table `mydb`.`INPATIENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INPATIENT` (
  `INcode` CHAR(11) NOT NULL,
  `NURcode` SMALLINT UNSIGNED NOT NULL,
  `Date of admission` DATE NULL DEFAULT NULL,
  `Sickroom` TINYINT UNSIGNED NULL DEFAULT NULL,
  `Date of discharge` DATE NULL DEFAULT NULL,
  `Fee` DECIMAL(10,2) NULL DEFAULT NULL,
  `Diagnosis` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`INcode`),
  INDEX `fk_INPATIENT_NURSE1_idx` (`NURcode` ASC) VISIBLE,
  INDEX `fk_INPATIENT_PATIENT1_idx` (`INcode` ASC) VISIBLE,
  CONSTRAINT `fk_INPATIENT_NURSE1`
    FOREIGN KEY (`NURcode`)
    REFERENCES `mydb`.`NURSE` (`NURcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_INPATIENT_PATIENT1`
    FOREIGN KEY (`INcode`)
    REFERENCES `mydb`.`PATIENT` (`PATcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO inpatient VALUES ('IP000000001', 1,'2021-1-1', 12, '2021-2-1', 100.0, 'Pharyngitis');
INSERT INTO inpatient VALUES ('IP000000002', 2,'2021-1-1', 11, '2021-2-1', 100.0, 'Pharyngitis');
INSERT INTO inpatient VALUES ('IP000000003', 1,'2021-1-1', 100, '2021-2-1', 100.0, 'Ulcerative colitis');
INSERT INTO inpatient VALUES ('IP000000004', 4,'2021-1-1', 19, '2021-2-1', 100.0, 'Ulcerative colitis');

-- -----------------------------------------------------
-- Table `mydb`.`IS_TREATED_BY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IS_TREATED_BY` (
  `DOCcode` SMALLINT UNSIGNED NOT NULL,
  `INcode` CHAR(11) NOT NULL,
  `Start date` DATE NULL DEFAULT NULL,
  `End date` DATE NULL DEFAULT NULL,
  `Result` TINYTEXT NULL DEFAULT NULL,
  INDEX `fk_IS_TREATED_BY_DOCTOR1_idx` (`DOCcode` ASC) VISIBLE,
  PRIMARY KEY (`DOCcode`, `INcode`),
  INDEX `fk_IS_TREATED_BY_INPATIENT1_idx` (`INcode` ASC) VISIBLE,
  CONSTRAINT `fk_IS_TREATED_BY_DOCTOR1`
    FOREIGN KEY (`DOCcode`)
    REFERENCES `mydb`.`DOCTOR` (`DOCcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_IS_TREATED_BY_INPATIENT1`
    FOREIGN KEY (`INcode`)
    REFERENCES `mydb`.`INPATIENT` (`INcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO is_treated_by VALUES(1, 'IP000000002', '2021-1-1', '2021-2-1', 'Conjunctivitis');
INSERT INTO is_treated_by VALUES(4, 'IP000000001', '2021-1-1', '2021-2-1', 'Crabs');
INSERT INTO is_treated_by VALUES(1, 'IP000000003', '2021-1-1', '2021-2-1', 'Cryptosporidiosis');
INSERT INTO is_treated_by VALUES(1, 'IP000000004', '2021-2-1', '2021-3-1', 'Conjunctivitis');

-- -----------------------------------------------------
-- Table `mydb`.`IS_TREATED_BY_MEDICATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IS_TREATED_BY_MEDICATION` (
  `MEDcode` SMALLINT NOT NULL,
  `DOCcode` SMALLINT UNSIGNED NOT NULL,
  `INcode` CHAR(11) NOT NULL,
  PRIMARY KEY (`MEDcode`, `DOCcode`, `INcode`),
  INDEX `fk_IS_TREATED_BY_MEDICATION_MEDICATION1_idx` (`MEDcode` ASC) VISIBLE,
  INDEX `fk_IS_TREATED_BY_MEDICATION_IS_TREATED_BY1_idx` (`DOCcode` ASC, `INcode` ASC) VISIBLE,
  CONSTRAINT `fk_IS_TREATED_BY_MEDICATION_MEDICATION1`
    FOREIGN KEY (`MEDcode`)
    REFERENCES `mydb`.`MEDICATION` (`MEDcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_IS_TREATED_BY_MEDICATION_IS_TREATED_BY1`
    FOREIGN KEY (`DOCcode` , `INcode`)
    REFERENCES `mydb`.`IS_TREATED_BY` (`DOCcode` , `INcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO is_treated_by_medication VALUES(1,4,'IP000000001');
INSERT INTO is_treated_by_medication VALUES(2,4,'IP000000001');
INSERT INTO is_treated_by_medication VALUES(3,4,'IP000000001');
INSERT INTO is_treated_by_medication VALUES(2,1,'IP000000002');

-- -----------------------------------------------------
-- Table `mydb`.`MED_EFFECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MED_EFFECT` (
  `MEDeffect` VARCHAR(50) NOT NULL,
  `MEDcode` SMALLINT NOT NULL,
  PRIMARY KEY (`MEDeffect`, `MEDcode`),
  INDEX `fk_MED_EFFECT_MEDICATION1_idx` (`MEDcode` ASC) VISIBLE,
  CONSTRAINT `fk_MED_EFFECT_MEDICATION1`
    FOREIGN KEY (`MEDcode`)
    REFERENCES `mydb`.`MEDICATION` (`MEDcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO med_effect VALUES('Bladder pain', 1);
INSERT INTO med_effect VALUES('bloody or cloudy urine', 1);
INSERT INTO med_effect VALUES('difficult, burning, or painful urination', 1);
INSERT INTO med_effect VALUES('Swelling of the ankles or feet', 2);
INSERT INTO med_effect VALUES('Difficult or labored breathing', 2);
INSERT INTO med_effect VALUES('Back pain', 3);
INSERT INTO med_effect VALUES('bleeding gums',3);
INSERT INTO med_effect VALUES('Anxiety', 4);
INSERT INTO med_effect VALUES('Overdose: Cold, clammy skin', 4);


-- -----------------------------------------------------
-- Table `mydb`.`PROVIDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PROVIDER` (
  `PDRnumber` SMALLINT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(50) NULL DEFAULT NULL,
  `Address` VARCHAR(50) NULL DEFAULT NULL,
  `Phone number` CHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`PDRnumber`))
ENGINE = InnoDB;

INSERT INTO provider VALUES(1,'A','10 ManCity', '123456123');
INSERT INTO provider VALUES(2,'B','10 ManUtd', '123456123');
INSERT INTO provider VALUES(3,'C','10 Liverpool', '123456124');
INSERT INTO provider VALUES(4,'D','10 Real Madrid', '123456125');

-- -----------------------------------------------------
-- Table `mydb`.`IS_IMPORTED_BY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`IS_IMPORTED_BY` (
  `Price` DECIMAL(10,2) NULL,
  `Imported date` DATE NULL,
  `Quantity` SMALLINT NULL,
  `MEDcode` SMALLINT NOT NULL,
  `PDRnumber` SMALLINT NOT NULL,
  PRIMARY KEY (`MEDcode`),
  INDEX `fk_IS_IMPORTED_BY_PROVIDER1_idx` (`PDRnumber` ASC) VISIBLE,
  CONSTRAINT `fk_IS_IMPORTED_BY_MEDICATION1`
    FOREIGN KEY (`MEDcode`)
    REFERENCES `mydb`.`MEDICATION` (`MEDcode`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_IS_IMPORTED_BY_PROVIDER1`
    FOREIGN KEY (`PDRnumber`)
    REFERENCES `mydb`.`PROVIDER` (`PDRnumber`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

INSERT INTO is_imported_by VALUES(100,'2021-10-10',200,1,2);
INSERT INTO is_imported_by VALUES(500,'2021-10-10',200,2,1);
INSERT INTO is_imported_by VALUES(400,'2021-10-10',200,3,3);
INSERT INTO is_imported_by VALUES(1000,'2021-10-10',200,4,4);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
