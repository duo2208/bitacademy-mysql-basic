select * from departments;

-- alias
select first_name as '이름', last_name as '성', hire_date as '입사일' from employees;

-- def
select concat(first_name, ' ', last_name) as '이름', 
		length(first_name),
        gender as '성별',
		hire_date as '입사일' 
	from employees;

-- distinct
select distinct title from titles;

-- order by
select concat(first_name, ' ', last_name) as '이름', 
		length(first_name),
        gender as '성별',
		hire_date as '입사일' 
	from employees
order by hire_date desc;

-- like 
select * from employees where first_name like '%pe%';
select * from employees where first_name like 'p____';

-- 2001년 월급을 가낭 높은순으로 사번, 월급순으로 출력
select emp_no, salary
	from salaries
    where from_date like '2001-%'
order by salary desc;

select emp_no, salary
	from salaries
    where from_date > '2000-12-31' and from_date < '2002-01-01'
order by salary desc;

-- where
-- employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일
select concat(first_name, ' ', last_name) as '이름', gender, hire_date
	from employees
    where hire_date < '1991-01-01'
order by hire_date asc;

-- date_format
select concat(first_name, ' ', last_name) as name, gender, date_format(hire_date, '%Y년 %m월 %d일') as hire_date
	from employees
    where hire_date < '1989-01-01' and gender = 'F'
order by hire_date desc;


