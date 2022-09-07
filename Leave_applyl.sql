create  sequence sqle
minvalue 0
start with 0
increment by 1
nocache
nocycle;
/ 


create or replace procedure leave_apply 
(employeeid in employee.empid%type,leavestartdate in timesheet.LEAVE_START_DATE%type,leaveenddate in timesheet.LEAVE_END_DATE%type ,typeofleave in timesheet.TYPE_OF_LEAVE%type)
is
leaveamt timesheet.LEAVE_DEDUCTED_AMOUNT%type;
BEGIN
if typeofleave='%casual%' and to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy') >10 then 
leaveamt := 200;
elsif typeofleave='%casual%' and to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy') <10 then 
leaveamt := 0;
else  
leaveamt := 0;
end if;
insert into timesheet values(sqle.nextval,employeeid,leavestartdate,leaveenddate,typeofleave,leaveamt);
END;
/

exec leave_apply(101,to_date('04-07-2022','dd-mm-yyyy'),to_date('06-07-2022','dd-mm-yyyy'),'sick');