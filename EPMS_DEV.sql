---allowance
create table allowance(allowanceid number(10),
type varchar2(30),
discription varchar2(100),
constraint pk_employees_allowanceid primary key (allowanceid));


insert into allowance values ('101','medical','partial_taxable');
insert into allowance values ('102','house_rent','partial_taxable');
insert into allowance values ('103','overtime','taxable');
insert into allowance values ('104','special_allowance','partial_taxable');
insert into allowance values ('105','meal','partial_taxable');
insert into allowance values ('106','transport','partial_taxable');


select * from allowance;


--deduction
create table deduction(deductid number(10),
type varchar2(30),
discription varchar2(100),
constraint pk_deduction_deducid primary key (deductid));

insert into deduction values (101,'mobile reimbursement','volunteer_deduction');
insert into deduction values (102,'medical','pretax_deduction');
insert into deduction values (103,'life_insurance','pretax_deduction');
insert into deduction values (104,'ppf','volunteer_deduction');
insert into deduction values (105,'loan','volunteer_deduction');

select * from deduction;

