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

--Show unique birth years from patients and order them by ascending.
select distinct year(birth_date) as birth_year from patients order by birth_year asc;

--Show unique first names from the patients table which only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select first_name
from patients
group by first_name
having count(*) = 1;

--Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name
from patients
where first_name
like 's%s'
and length(first_name) >=6;

--Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.Primary diagnosis is stored in the admissions table.
select p.patient_id, p.first_name, p.last_name
from patients As p
inner join admissions as a on p.patient_id = a.patient_id
where a.diagnosis = 'Dementia';

--Display every patient's first_name.Order the list by the length of each name and then by alphabetically.
select first_name
from patients
order by length(first_name), first_name ASC;
--Show the total amount of male patients and the total amount of female patients in the patients table.Display the two results in the same row.
select
SUM(CASE when gender = 'M' then 1 else 0 END) as male_count,
SUM(CASE when gender = 'F' then 1 else 0 END) as female_count
from patients;

--