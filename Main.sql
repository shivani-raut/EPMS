set serveroutput on;
declare
    choice number;
    lv_empid employee.empid%type;
    lv_password login.password%type;
    lv_result varchar(10);
begin
    lv_empid := &EmployeeId;
    lv_password := '&Password';
    Login_procedure(lv_empid,lv_password,lv_result);    
    if lv_result = 'sucess' then
        dbms_output.put_line('*******************************');
        dbms_output.put_line('1. Edit Bank Details');
        dbms_output.put_line('2. Apply Leave');
        dbms_output.put_line('3. Allowance Addition');
        dbms_output.put_line('4. Deduction Addition');
        dbms_output.put_line('5. View PaySlip');    
    end if;
end;
/