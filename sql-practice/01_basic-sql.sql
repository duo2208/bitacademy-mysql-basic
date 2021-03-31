-- pet table 생성
create table pets(
name varchar(20),
owner varchar(20),
species varchar(20),
gender char(1),
birth date,
death date
);

-- table scheme 확인
desc pets;

-- insert
insert into pets values('키키', '교님', '요크셔테리어', '여', '2021-01-01', null);
insert into pets(name, owner, species, gender, birth) values('폰펫', '이지민', '허스키', '여', '2021-03-30');
insert into pets values('별이', '정서영', '말티즈', '남', '2018-01-01', null);

-- select
select * from pets;
select name, birth from pets order by birth desc;
select count(death) from pets;
select count(*) from pets where death is not null;

-- update
update pets set species='포메라니안' where name='폰펫';

-- delete 
delete from pets where death is not null

