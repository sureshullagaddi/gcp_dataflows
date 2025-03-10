#https://www.sql-practice.com/ - Easy
SELECT * FROM patients;
select * from admissions;
select * from doctors;
select * from province_names;

select first_name, last_name, gender from patients where gender = 'M';
select first_name, last_name from patients where allergies is null;
select first_name from patients where first_name like 'C%';
select first_name, last_name from patients where weight between 100 and 120;
update patients set allergies='NKA' where allergies is NULL;
select concat(first_name,' ',last_name) as full_name from patients;

select p.first_name, p.last_name, pr.province_name
from patients as p
INNER join province_names as pr
on p.province_id = pr.province_id;

select count(*) from patients where YEAR(birth_date) = 2010;
select first_name,last_name, MAX(height)as height from patients;
select * from patients where patient_id in (1,45,534,879,1000);
select count(*) from admissions;
select * from admissions where admission_date = discharge_date;
select patient_id,count(*) as total_admissions from admissions where patient_id=579;
select distinct (city) as unique_cities from patients where province_id='NS';
select first_name,last_name,birth_date from patients where height > 160 and weight > 70;
select first_name, last_name,allergies from patients where allergies is not NULL and city = 'Hamilton';
select distinct year(birth_date) as birth_year from patients order by birth_year asc;