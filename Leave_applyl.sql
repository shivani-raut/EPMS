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
if typeofleave='casual' and to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy') >10 then 
    leaveamt := 200;
    dbms_output.put_line('Leave Type => '||typeofleave);
    dbms_output.put_line('No of days on leave => '||(to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy')));
    dbms_output.put_line('Deducted Amount => '||leaveamt);
elsif typeofleave='%casual%' and to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy') <10 then 
    leaveamt := 0;
    dbms_output.put_line('Leave Type => '||typeofleave);
    dbms_output.put_line('No of days on leave => '||(to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy')));
    dbms_output.put_line('Deducted Amount => '||leaveamt);
else  
    leaveamt := 0;
    dbms_output.put_line('Leave Type => '||typeofleave);
    dbms_output.put_line('No of days on leave => '||(to_date(leaveenddate,'dd-mm-yyyy') - to_date(leavestartdate,'dd-mm-yyyy')));
    dbms_output.put_line('Deducted Amount => '||leaveamt);
end if;
insert into timesheet values(sqle.nextval,employeeid,leavestartdate,leaveenddate,typeofleave,leaveamt);
END;
/

exec leave_apply(102,to_date('09-10-2022','dd-mm-yyyy'),to_date('20-10-2022','dd-mm-yyyy'),'casual');