-- ex1) 현재 Fai Bale이 근무하는 부서의 전체 직원의 사번과 이름을 출력하시오.
 
-- ex1-1) 개별쿼리로 해결 -> 가능하면 하나의 쿼리로 해결
select a.dept_no
	from dept_emp a, employees b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and concat(b.first_name, ' ', b.last_name) = 'Fai Bale';
    
select a.emp_no, concat(b.first_name, ' ', b.last_name) as name
	from dept_emp a, employees b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and a.dept_no = 'd004';
    
-- ex1-2) 서브쿼리로 해결
select a.emp_no, concat(b.first_name, ' ', b.last_name) as name
	from dept_emp a, employees b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
    and a.dept_no = (
		select a.dept_no
			from dept_emp a, employees b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and concat(b.first_name, ' ', b.last_name) = 'Fai Bale'
    );
    

-- where의 조건식에 서브쿼리를 사용하고, 결과가 단일행인 경우
-- =, !=, >, <, >=, <=

-- ex2) 현재 전체 사원의 평균 연봉보다 적은 급여를 받는 사원들의 이름, 급여를 출력하시오.
select concat(b.first_name, ' ', b.last_name), a.salary
	from salaries a, employees b
    where a.emp_no = b.emp_no
    and a.to_date = '9999-01-01'
	and salary < (select avg(salary) from salaries where to_date = '9999-01-01')
order by a.salary desc;

-- where의 조건식에 서브쿼리를 사용하고, 결과가 다중행인 경우
-- in(not in)
-- any : =any (in과 동일), >any, <any, >=any, <=any, <>any (!=any)
-- all : =all, >all, <all, >=all, <=all, <>all (!=all, not in)

-- ex3) 현재 급여가 50000 이상인 직원의 이름과 급여를 출력하시오.
-- ex3-1) join
select a.first_name, b.salary
	from employees a 
    join salaries b
    on a.emp_no = b.emp_no
    where b.to_date = '9999-01-01'
	and b.salary > 50000
order by b.salary desc;

-- ex3-2) subquery : 멀티행/열
select a.first_name, b.salary
	from employees a 
    join salaries b
    on a.emp_no = b.emp_no
    where b.to_date = '9999-01-01'
	and (a.emp_no, b.salary) = any(
		select emp_no, salary from salaries where to_date = '9999-01-01' and salary > 50000
    )
 order by b.salary desc;
 
 select a.first_name, b.salary
	from employees a 
    join salaries b
    on a.emp_no = b.emp_no
    where b.to_date = '9999-01-01'
	and (a.emp_no, b.salary) in (
		select emp_no, salary from salaries where to_date = '9999-01-01' and salary > 50000
    )
 order by b.salary desc;
 
 -- ex3-3) subquery
select a.first_name, b.salary
	from employees a 
    join (
		select emp_no, salary from salaries where to_date = '9999-01-01' and salary > 50000
        ) b
    on a.emp_no = b.emp_no
 order by b.salary desc;
 
-- ex4-1) 현재 가장 적은평균급여를 출력하시오. : subquery 이용
 select min(a.avg_salary)
	from(
		select b.title, avg(a.salary) as avg_salary
			from salaries a
			join titles b
			on a.emp_no = b.emp_no
			where a.to_date = '9999-01-01'
			and  b.to_date = '9999-01-01'
		group by b.title
    ) a;


-- ex4-2) 현재 가장 적은 평균급여의 직책과, 그 평균급여를 출력하시오. : subquery 이용
select b.title, round(avg(salary)) as avg_salary
	from salaries a
		join titles b
		on a.emp_no = b.emp_no
		where a.to_date = '9999-01-01'
		and  b.to_date = '9999-01-01'
	group by b.title
	having avg_salary = (
		 select min(avg_salary)
			from(
				select b.title, round(avg(salary)) as avg_salary
					from salaries a
					join titles b
					on a.emp_no = b.emp_no
					where a.to_date = '9999-01-01'
					and  b.to_date = '9999-01-01'
				group by b.title
			) a
		);
    
 select a.title, min(a.avg_salary)
	from(
		select b.title, avg(a.salary) as avg_salary
			from salaries a
			join titles b
			on a.emp_no = b.emp_no
			where a.to_date = '9999-01-01'
			and  b.to_date = '9999-01-01'
		group by b.title
    ) a;
    
-- ex4-3) top-k : limit 이용
select b.title, avg(a.salary) as avg_salary
	from salaries a
	join titles b
	on a.emp_no = b.emp_no
	where a.to_date = '9999-01-01'
	and  b.to_date = '9999-01-01'
group by b.title
order by avg_salary asc
limit 0, 1;
    
    
-- ex5) 현재, 부서별로 최고급여를 받는 사원의 이름과 급여를 출력하시오.
-- ex5-1) from절 subquery
select a.first_name, b.dept_no, d.dept_name, c.salary
	from employees a,
		dept_emp b,
		salaries c,
		departments d,
		( select a.dept_no, max(b.salary) as max_salary
			from dept_emp a, salaries b
           where a.emp_no = b.emp_no
             and a.to_date = '9999-01-01'
             and b.to_date = '9999-01-01'
        group by a.dept_no) e
	where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
	and b.dept_no = d.dept_no
	and b.dept_no = e.dept_no
	and c.salary = e.max_salary
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
order by c.salary desc;   
    
-- ex5-2) where절 subquery
select a.first_name, b.dept_no, d.dept_name, c.salary
	from employees a,
		dept_emp b,
		salaries c,
		departments d
	where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
	and b.dept_no = d.dept_no
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
	and (b.dept_no, c.salary) in 
		(select a.dept_no, max(b.salary) as max_salary
			from dept_emp a, salaries b
			where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by a.dept_no)
order by c.salary desc;

-- ex5-3) 내가한거
select concat(a.first_name, ' ', a.last_name) as name, c.dep_no, d.dept_name, max_salary
	from employees a, salaries b, dept_emp c, departments d
	where a.emp_no = b.emp_no		-- join
	and b.emp_no = c.emp_no			-- join
	and c.dept_no = d.dept_no		-- join
	and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
	and (b.dept_no, c.salary) in
		(
		select a.dept_no, max(b.salary) as max_salary
			from dept_emp a, salaries b
			where a.emp_no = b.emp_no		
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
		group by a.dept_no
		)



    

    

    
    


