create sequence payid
    minvalue 0
    start with 0
    increment by 1
    nocycle
    nocache ;



Create or replace PROCEDURE salary_credited
is 
CURSOR cur is select e.empid, basic_salary,bonus,band_pf,allow_amount,loan_deducted_amt,leave_deducted_amount,bd.acc_no 
from band b inner join employee e on e.bandid = b.bandid left join employee_allowance ea on ea.empid = e.empid 
left join employee_deduction ed on ed.empid = e.empid 
left join timesheet t on e.empid = t.empid
inner join bank_details bd on bd.employee_empid = e.empid;
var_net_salary payroll.emp_net_salary%type;
cc cur%rowtype;
BEGIN
open cur;
loop
fetch cur into cc;
exit when cur%notfound;
var_net_salary := cc.basic_salary + cc.bonus + nvl(cc.allow_amount,0) - (cc.band_pf + nvl(cc.loan_deducted_amt,0) + nvl(cc.leave_deducted_amount,0));
if extract(day from sysdate)= 30 then 
Insert into payroll values (payid.nextval,cc.empid,var_net_salary,TO_date(sysdate,'DD-MM-YYYY'),cc.acc_no);
END if;
END LOOP;
dbms_output.put_line('Salary Credited...');
CLOSE cur;
END;




