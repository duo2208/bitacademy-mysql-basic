-- 예제1 : salaries 테이블에서 현재 전체 직원의 급여 평균과 최고급여를 출력
select avg(salary) as avg, max(salary) as max
	from salaries
    where to_date = '9999-01-01';
    
-- 예제2 : salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총합계를 출력  
select emp_no, avg(salary) as avg, sum(salary) as sum
	from salaries
    where emp_no = 10060;
    
-- 예제3 : 이 예제 직원의 최저 임금을 받은 시기와 최대 임금을 받은 시기를 각 각 출력해보세요.
-- select 절에 집계함수가 있으면, 다른 컬럼은 올 수 없다.
-- 따라서 시기는 join 혹은 서브쿼리를 통해서 구해야 한다.

-- 예제4 : dept_emp 테이블에서 d008에 현재 근무하는 인원 수는?
select count(*)
	from dept_emp
    where dept_no = 'd008' and to_date = '9999-01-01';
    
-- 예제5 : 각 사원별로 평균연봉 출럭
select emp_no, avg(salary) as avg_salary
	from salaries
    group by emp_no
    order by avg_salary desc;
    
-- 예제6 : salaries 테이블에서 현재 전체 직원별로 평균급여가 35000 이상인 직원의 평균 급여를 큰 순서로 출력하라.
-- group by 이후에 where절을 다시 쓸 수가 없다 => having을 사용해야함.
select emp_no, avg(salary) as avg_salary
	from salaries
    where to_date = '9999-01-01'
    group by emp_no
    having avg_salary > 35000
    order by avg_salary desc;
    
-- 예제7 : 사원별로 몇 번의 직책 변경이 있었는지 조회하시오.
select emp_no, count(*) as change_titles
	from titles
    group by emp_no;
    
-- 예제8 : 현재 근속중인 직원수를 직책별로 구하되,  직원수가 100명 이상인 직책만 출력하시오.
select title, count(*) as cnt
	from titles
    where to_date = '9999-01-01'
    group by title
	having cnt > 100
    order by cnt desc;
    
    
    
    