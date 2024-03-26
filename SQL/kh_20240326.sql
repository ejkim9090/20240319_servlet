select * from employee;
select * from department;
select * from location;
select * from national;
select * 
from employee
-- where 속성명 = '속성값'
where dept_code = 'D5'
;
select emp_name, job_code, emp_id, hire_date 
from employee
-- where 속성명 = '속성값'
where dept_code = 'D5'
;

select * 
from employee
-- where 속성명 = '속성값'
where emp_id='200'
;