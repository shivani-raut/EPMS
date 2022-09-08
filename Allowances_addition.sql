exec allowances_addition(105,'overtime');
CREATE OR REPLACE PROCEDURE  allowances_addition(empid in EMPLOYEE.EMPID%TYPE,ATYPE in ALLOWANCES.TYPE%TYPE)
IS
    CURSOR  C IS SELECT TYPE FROM ALLOWANCES ;
    VAR C%ROWTYPE;
    A_AMOUNT employee_allowance.ALLOW_AMOUNT%TYPE;
    ALL_ID ALLOWANCES.ALLOWANCEID%TYPE;
BEGIN
    OPEN C;
    dbms_output.put_line('TYPES OF ALLOWANCES');
    dbms_output.put_line('------------------------------');
    LOOP
    FETCH C INTO VAR;
    EXIT WHEN C%NOTFOUND;
     dbms_output.put_line(upper(VAR.TYPE));
    END LOOP;
    CLOSE C;
    SELECT ALLOWANCEID INTO ALL_ID FROM ALLOWANCES WHERE TYPE =ATYPE ;
    A_AMOUNT := ALLOWANCE_AMOUNT(ATYPE);
    dbms_output.put_line('------------------------------');
    dbms_output.put_line(''||upper(ATYPE)||' allowance with employee id '||EMPID||' has been added to the Employee Allowance Table');
    INSERT INTO  employee_allowance VALUES(EMPID,ALL_ID,TO_DATE(SYSDATE,'DD-MM-YYYY'),A_AMOUNT);
END;
/
set SERVEROUTPUT on;
CREATE OR REPLACE FUNCTION ALLOWANCE_AMOUNT(ATYPE ALLOWANCES.TYPE%TYPE )
RETURN NUMBER
IS
BEGIN
    IF UPPER(ATYPE)=UPPER('MEDICAL') THEN
    RETURN 3000;
    ELSIF 
    UPPER(ATYPE)=UPPER('house_rent') THEN
    RETURN 5000;
    ELSIF 
    UPPER(ATYPE)=UPPER('overtime') THEN
    RETURN 6000;
    ELSIF 
    UPPER(ATYPE)=UPPER('special_allowance') THEN
    RETURN 2000;
    ELSIF 
    UPPER(ATYPE)=UPPER('meal') THEN
    RETURN 4000;
    ELSE
    RETURN 3000;
END IF;
END;
/