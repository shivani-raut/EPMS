create or replace procedure Login_procedure
(empid in employee.empid%type,login_result out varchar)
is 
    lv_password login.password%type;
    sel_password login.password%type;
begin
    lv_password:='&password';
    select password into sel_password from login where username_empid = empid;
    if sel_password = lv_password  then
        dbms_output.put_line('Login Successful');
        login_result:='sucess';
    else
        dbms_output.put_line('Login Failed');
        login_result:='fail';
    end if;
end;
/
