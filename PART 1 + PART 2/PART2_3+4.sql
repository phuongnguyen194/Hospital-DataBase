use mydb;
-- c. Write a function to calculate the total medication price a patient has to pay for 
-- each treatment or examination (1 mark).
-- Input: Patient ID
-- Output: A list of payment of each treatment or examination
DELIMITER $$
drop procedure if exists list_payment;
CREATE PROCEDURE mydb.list_payment(IN PATcode char(11))
BEGIN
	IF LEFT(PATcode, 2) = 'IP' THEN
	SELECT A.DOCcode, A. MEDcode, C.`Name`, C.`Expiration Date` ,C.price FROM  
 	mydb.is_treated_by_medication AS A
 	INNER JOIN mydb.medication AS C
 	ON A.MEDcode=C.MEdcode
 	-- GROUP BY A.INcode;
 	WHERE A.INcode = PATcode;
    ELSE -- OP
    SELECT M.price FROM 
	outpatient_examination_medication AS O
	INNER JOIN medication AS M
	USING (MEDcode)
	WHERE OUTcode = PATcode;
    END IF;
END; $$
DELIMITER ;

CALL mydb.list_payment('IP000000001')



-- d. Write a procedure to sort the doctor in increasing number of patients he/she 
-- takes care in a period of time (1 mark). 
-- Input: Start date, End date
-- Output: A list of sorting doctors.

-- INPATIENT, use is_treated_by.`Start date`. Because DOCcode and INcode are primary key,
-- then 1 doctor cannot treat 1 patient more than 1 time.
-- OUTPATIENT, use .outpatient_examination.`date`

DELIMITER $$
drop procedure if exists sorting_doctors;
CREATE PROCEDURE mydb.sorting_doctors(IN start_date DATE, IN end_date DATE)
BEGIN
	drop table if exists tmp1;
	CREATE TABLE tmp1 
	SELECT DOCcode, COUNT(INcode) `#patients` FROM is_treated_by
	WHERE `Start date` > start_date AND `Start date` < end_date
	GROUP BY Doccode
	ORDER BY `#patients` DESC;
    
    drop table if exists tmp2;
	CREATE TABLE tmp2
    SELECT ExaminingDOCcode, COUNT(OUTcode) `#patients` FROM 
	outpatient AS A
	INNER JOIN outpatient_examination as B
	USING (OUTcode)
    WHERE `date`> start_date AND `date` < end_date
	GROUP BY ExaminingDOCcode
	ORDER BY `#patients` DESC;
    
    SELECT tmp1.DOCcode, tmp1.`#patients` + tmp2.`#patients` as totalPatients FROM
    tmp1 INNER JOIN tmp2
    ON tmp1.DOCcode = tmp2.ExaminingDOCcode;
    
END; $$
DELIMITER ;

CALL mydb.sorting_doctors('2020-1-1','2022-1-1')