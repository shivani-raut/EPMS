exec deduction_addition(103,'ppf');
CREATE OR REPLACE PROCEDURE  deduction_addition
    (empid in EMPLOYEE.EMPID%TYPE,ATYPE in DEDUCTION.TYPE%TYPE)
IS
    CURSOR  Cur IS SELECT TYPE FROM DEDUCTION ;
    VAR CUR%ROWTYPE;
    D_AMOUNT employee_deduction.loan_deducted_amt%TYPE;
    DED_ID DEDUCTION.DEDUCTID%TYPE;
BEGIN
    OPEN CUR;
    dbms_output.put_line('TYPES OF DEDUCTIONS');
    dbms_output.put_line('------------------------------');
    LOOP
    FETCH CUR INTO VAR;
    EXIT WHEN CUR%NOTFOUND;
     dbms_output.put_line(VAR.TYPE);
    END LOOP;
    CLOSE CUR;
    SELECT DEDUCTID INTO DED_ID FROM DEDUCTION WHERE TYPE =ATYPE ;
    D_AMOUNT := DEDUCTION_AMOUNT(ATYPE);
    dbms_output.put_line('------------------------------');
    dbms_output.put_line(''||upper(ATYPE)||' deduction with employee id '||EMPID||' has been added to the Employee Deduction Table');
    INSERT INTO  employee_deduction VALUES(EMPID,DED_ID,D_AMOUNT);
END;
/
 

CREATE OR REPLACE FUNCTION DEDUCTION_AMOUNT(ATYPE DEDUCTION.TYPE%TYPE )
RETURN NUMBER
IS
BEGIN
IF 
    UPPER(ATYPE)=UPPER('mobile reimbursement') THEN
        RETURN 1000;
    ELSIF UPPER(ATYPE)=UPPER('medical') THEN
        RETURN 4000;
    ELSIF UPPER(ATYPE)=UPPER('life_insurance') THEN
        RETURN 8000;
    ELSIF UPPER(ATYPE)=UPPER('ppf') THEN
        RETURN 2000;
    ELSIF UPPER(ATYPE)=UPPER('loan') THEN
        RETURN 10000;
    ELSE
        RETURN 3000;
END IF;
END;
/
