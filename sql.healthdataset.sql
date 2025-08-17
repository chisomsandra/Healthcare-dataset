select *
from healthcare_dataset_2;

create table health_datasetstagging
like healthcare_dataset_2;

insert health_datasetstagging
select *
from healthcare_dataset_2;

select *
from health_datasetstagging;

select *,
row_number() over( partition by
ï»¿Name, Age, Gender,`Blood Type`,`Medical Condition`,`Date of Admission`
, Doctor, Hospital, Medication, `Insurance Provider`,`Billing Amount`, `Room Number`,
`Admission Type`,`Test Results`) as row_num
from health_datasetstagging;

with duplicate_cte as 
(
select *,
row_number() over( partition by ï»¿Name,
 Age, Gender,`Blood Type`,`Medical Condition`,`Date of Admission`,
 Doctor, Hospital, Medication, `Insurance Provider`,`Billing Amount`,`Room Number`,
 `Admission Type`,`Test Results`
) as row_num
from health_datasetstagging
)
select *
from duplicate_cte
where row_num > 1;


select *
from health_datasetstagging
where Doctor = 'Jennifer Lee';

CREATE TABLE `health_datasetstagging2` (
  `Name` text,
  `Age` int DEFAULT NULL,
  `Gender` text,
  `Blood_Type` text,
  `Medical_Condition` text,
  `Date_Admission` text,
  `Doctor` text,
  `Hospital` text,
  `Insurance_Provider` text,
  `Billing_Amount` text,
  `Room_Number` int DEFAULT NULL,
  `Admission_Type` text,
  `Discharge_Date` text,
  `Medication` text,
  `Test_Results` text,
  `row_num` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *
from health_datasetstagging2;


insert into health_datasetstagging2
select *,
row_number() over( partition by
ï»¿Name, Age, Gender, `Blood Type`, `Medical Condition`, `Date of Admission`,
 Doctor, Hospital, `Insurance Provider`, `Billing Amount`, `Room Number`,
 `Admission Type`, `Discharge Date`, Medication, `Test Results`) as row_num
 from health_datasetstagging;


select *
from health_datasetstagging2
where row_num >1;

delete 
from health_datasetstagging2
where row_num > 1;

select *
from health_datasetstagging2;

select *
from health_datasetstagging2;

-- standardizing Data

select *
from health_datasetstagging2;


delete
from health_datasetstagging2
where Date_Admission = '';


alter table health_datasetstagging2
modify Date_Admission date;

update health_datasetstagging2
set Date_Admission_date = str_to_date(Date_Admission, '%y-%m-%d');

select *
from health_datasetstagging2;

delete
from health_datasetstagging2
where Name = '';

alter table health_datasetstagging2
drop column `Date of Admission`;

alter table health_datasetstagging2
drop column Date_Discharge_Date;

delete
from health_datasetstagging2
where Gender ='';

select Insurance_Provider, hospital, max(Billing_Amount), count(Insurance_Provider)
from health_datasetstagging2
group by Insurance_Provider,hospital;

select *
from health_datasetstagging2;

update health_datasetstagging2
set Billing_Amount =replace(replace(Billing_amount, '(', ''), '(', '');


delete 
from health_datasetstagging2
where Billing_Amount = '';


select Insurance_provider, Billing_Amount
from health_datasetstagging2
order by  Billing_Amount ;

update health_datasetstagging2
set Billing_Amount = replace(Billing_Amount, ')', '');


select gender, max(age), min(AGE), count(age)
from health_datasetstagging2
group by gender;

select *
from health_datasetstagging2
order by Date_Admission desc
limit 3;

--- Exploratory analysis

select max(Billing_Amount)
from health_datasetstagging2;

select *
from health_datasetstagging2;

select age, gender, billing_amount
from health_datasetstagging2
order by age desc;

select hospital, sum(billing_amount)
from health_datasetstagging2
group by hospital
order by 2 desc;

select max(Date_admission), min(Date_Admission)
from health_datasetstagging2;

select max(Discharge_Date), min(Discharge_Date)
from health_datasetstagging2;


select Doctor, max(Billing_Amount)
from health_datasetstagging2
group by Doctor
order by 2;

select *
from health_datasetstagging2;


alter table health_datasetstagging2
drop column row_num;

select min(age),
max(age),
avg(Billing_Amount) as avg_bill
from health_datasetstagging2;

select Date_Admission, Discharge_Date,
datediff(Discharge_Date, Date_Admission) as Stay_lenght
from health_datasetstagging2;

update health_datasetstagging2
set Date_Admission = (@temp := Date_Admission),
Date_Admission = Discharge_Date,
Discharge_Date = @temp
where Date_Admission > Discharge_Date;

alter table health_datasetstagging2
add column stay_lenght int;

update health_datasetstagging2
set Stay_lenght = datediff(Discharge_Date, Date_Admission);

select *
from health_datasetstagging2;

select max(stay_lenght), min(stay_lenght)
from health_datasetstagging2;

select *
from health_datasetstagging2
where stay_lenght = 0;

select medical_Condition,
count(medical_Condition) as medical_frequency
from health_datasetstagging2
group by Medical_Condition

