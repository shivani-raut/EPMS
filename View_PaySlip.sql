exec View_PaySlip(100,'September','2022');
set serveroutput on;
create or replace Procedure View_PaySlip(lv_empid employee.empid%type,lv_month varchar,lv_year varchar)
is
    lv_emp_net_salary payroll.emp_net_salary%type;
    lv_acc_no bank_details.acc_no%type;
    lv_bank_name bank_details.bank_name%type;
    lv_ifsc bank_details.ifsc%type;
    lv_pf band.band_pf%type;
    lv_basic_salary band.basic_salary%type;
    lv_empname employee.empname%type;
    lv_credit_date payroll.salary_credited_date%type;
begin
    select empname,salary_credited_date,emp_net_salary,bd.acc_no,bank_name,ifsc,band_pf,basic_salary 
        into lv_empname,lv_credit_date,lv_emp_net_salary,lv_acc_no,lv_bank_name,lv_ifsc,lv_pf,lv_basic_salary 
    from employee e,band b,bank_details bd,payroll p
    where
        e.empid=bd.employee_empid and
        e.bandid = b.bandid and
        p.empid=e.empid 
        and e.empid =  lv_empid
        and
        trim(to_char(to_date(extract(month from SALARY_CREDITED_DATE),'MM'),'MONTH')) like upper(lv_month) and 
        trim(to_char(to_date(extract(year from SALARY_CREDITED_DATE),'YY'),'YYYY')) like (lv_year);
        
        if sql%found then
        dbms_output.put_line('Employee Id => '||lv_empid);
        dbms_output.put_line('Employee Name => '||lv_empname);
        dbms_output.put_line('Account Number => '||lv_acc_no);
        dbms_output.put_line('Bank Name => '||lv_bank_name);
        dbms_output.put_line('IFSC Code => '||lv_ifsc);
        dbms_output.put_line('Basic Salary => '||lv_basic_salary);
        dbms_output.put_line('Provident Fund => '||lv_pf);
        dbms_output.put_line('---------------------------------------');
        dbms_output.put_line('Employee Net Salary => '||lv_emp_net_salary);
    
    end if;
    exception 
    when no_data_found then
         dbms_output.put_line('Not Matching for the Employee Id '||lv_empid||' or No Employee Id Found');
end;
/
set serveroutput on;