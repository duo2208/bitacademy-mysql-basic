-- 예제1 : 현재 근무하고있는 직원의 이름과 직책을 직원 이름순으로 출력하시오.
select concat(first_name, ' ', last_name) as name, title
	from employees a, titles b
    where a.emp_no = b.emp_no		-- join
    and b.to_date = '9999-01-01'	-- select
    order by name asc;
    
-- 예제2 : 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균 급여를 구하시오.
select a.dept_no, d.dept_name, avg(b.salary) as avg
	from dept_emp a, salaries b, titles c, departments d
    where a.emp_no = b.emp_no		-- join
    and b.emp_no = c.emp_no			-- join
    and a.dept_no = d.dept_no		-- join
    and a.to_date = '9999-01-01'	-- select
    and b.to_date = '9999-01-01'	-- select
    and c.to_date = '9999-01-01'	-- select
    and c.title = 'Engineer'
group by a.dept_no
order by a.dept_no asc;
    
-- 예제3 : 현재 직책별로 급여의 총합을 구하되 Engineer 직책은 제외하시오.
-- 단, 총합이 2,000,000,000 이상인 직책만 나타내며 급여의 통합에 대해서는 내림차순으로 출력.
SELECT 
    b.title, SUM(a.salary) AS salary_sum
FROM
    salaries a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND b.title != 'Enginner'
GROUP BY b.title
HAVING salary_sum > 2000000000
ORDER BY salary_sum DESC;
    
-- join ~ on
-- 예제1 : 현재 근무하고있는 직원의 이름과 직책을 직원 이름순으로 출력하시오.
select concat(first_name, ' ', last_name) as name, title
	from employees a join titles b on a.emp_no = b.emp_no
    where b.to_date = '9999-01-01'	-- select
    order by name asc;
    
-- natural join
-- 예제1 : 현재 근무하고있는 직원의 이름과 직책을 직원 이름순으로 출력하시오.
select concat(first_name, ' ', last_name) as name, title
	from employees a natural join titles b
    where b.to_date = '9999-01-01'	-- select
    order by name asc;
    
-- natural join의 단점
-- emp_no 와 from_date, to_date 공통칼럼을 묵시적으로 조인해버림
select count(*)
	from titles a
    join salaries b 
    on a.emp_no = b.emp_no
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01';	-- 241024 출력
    
select count(*)
	from titles a
    natural join salaries b 
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01';	-- 4 출력

-- join ~ using
select count(*)
	from titles a
    join salaries b 
    using (emp_no)
where a.to_date = '9999-01-01'
and b.to_date = '9999-01-01';	-- 241024 출력

-- outer join

-- 1. 테스트 데이터 넣기
-- insert into dept values(null, '총무');
-- insert into dept values(null, '개발');
-- insert into dept values(null, '영업');

-- insert into emp values(null, '둘리', 2);
-- insert into emp values(null, '마이콜', 3);
-- insert into emp values(null, '또치', 2);
-- insert into emp values(null, '도우넛', 3);
-- insert into emp values(null, '길동', null);

-- 예시 : 현재 회사의 직원의 이름과 부서이름을 출력하세요.
select a.name, b.name
	from emp a
    join dept b
    on a.dept_no = b.no;
    
-- left join
select a.name, ifnull(b.name, '없음')
	from emp a
    left join dept b
    on a.dept_no = b.no;
    
-- right join
select ifnull(a.name, '직원없음'), b.name
	from emp a
    right join dept b
    on a.dept_no = b.no;



