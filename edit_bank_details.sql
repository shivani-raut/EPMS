create or replace procedure Edit_Bank_Details(pv_empid employee.empid%type)
is
    l_deptname department.deptname%type;
    No_Edit_Permitted Exception; 
    cursor bank_c is  select * from bank_details;
    var bank_c%rowtype;
begin
    select deptname into l_deptname from department d,employee e where d.deptid = e.deptid  and e.empid = pv_empid;
    if upper(l_deptname)=upper('finance') then
        open bank_c;
        loop
        EXIT WHEN bank_c%NOTFOUND;
        FETCH bank_c INTO var; 
        dbms_output.put_line('****************************************************');
        dbms_output.put_line('Account Number => '|| var.acc_no);
        dbms_output.put_line('Bank Name => '|| var.Bank_name);
        dbms_output.put_line('IFSC => ' || var.IFSC);
        dbms_output.put_line('Employee Id => '|| var.Employee_empid);
        dbms_output.put_line('****************************************************');
    END LOOP;    
    CLOSE bank_c;    
    dbms_output.put_line('Permitted to edit the details');   
    else
        raise No_Edit_Permitted;
    end if;        
     exception
        when No_Edit_Permitted then
             dbms_output.put_line(' No edit is permitted for the Employee with empid  '||pv_empid);        
END  Edit_Bank_Details; 
/

exec Edit_Bank_Details(102);
exec Edit_Bank_Details(103);

