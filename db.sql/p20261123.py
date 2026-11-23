# 날짜 관련 복습할 부분
select * from member;

#현재 가입날짜가 10개월 이상된 회원들을 출력하시오.

select sysdate from dual;

select mdate from member;
select sysdate-mdate from member;

select mdate,add_months(mdate,10),add_months(mdate,-10)
from member;

# 현재 가입날짜가 10개월 이상된 회원들을 출력하시오.
select mdate,add_months(sysdate,-10) from member;

select mdate,add_months(sysdate,-10)
from member
where mdate >= add_months(sysdate,-10);

# mdate컬럼을 확인
select mdate from member;

# mdate 그달의 첫째일, 마지막일을 출력하시오.
# 26/01/01, 26/01/31
# trunc
select mdate,add_months(mdate,1),
trunc(add_months(mdate,1),‘mm’),last_day(mdate) from member;



select round(months_between(sysdate,mdate),2) from member;

# 가입한지 8개월째 되는 회원을 출력하시오.
# 8.1,8.2.....8.9 8개월째는 회원
select mdate,add_months(sysdate,-8) from member;
select name,mdate,trunc(months_between(sysdate,mdate)) from member
where trunc(months_between(sysdate,mdate))=8;
select name,mdate,round(months_between(sysdate,mdate),1),round(months_between(sysdate,mdate)) from member
where round(months_between(sysdate,mdate))=9;

# 다다음주 목요일 출력하시오.
select next_day(next_day(sysdate,‘목’),‘목’) from dual;

# 년도-월-일 시:분:초 로 출력하시오.
select sysdate from dual;

select to_char(mdate,‘yyyy-mm-dd hh24:mi:ss day’) from member;



select * from employees;

# 190번대(190-199) 까지 salary(월급),년봉,원화년봉을 출력하는데
# 천단위표시, 원화년봉은 원화표시를 출력하시오.

select trunc(employee_id,-1) from employees
where trunc(employee_id,-1)=190;

select employee_id from employees
where employee_id>=190 and employee_id<=199;

select employee_id,
to_char(salary,‘$999,999’) as salary1,
to_char(salary*12,‘$999,999’) as ysalary,
to_char(salary*12*1420,‘L999,999,999’ )
from employees
where employee_id between 190 and 199;



select * from gallerylist;

-- galmodifiedtime
-- 날짜포맷으로 변경하시오.

-- 문자타입을 날짜타입으로 변경
select
galmodifiedtime,
to_date(galmodifiedtime,‘yyyy-mm-dd hh24:mi:ss’) from gallerylist;

-- 컬럼추가
alter table gallerylist add (galmodifiedtime2 date);

-- 날짜타입에 날짜데이터추가
update gallerylist
set galmodifiedtime2 = to_date(galmodifiedtime,‘yyyy-mm-dd hh24:mi:ss’);
commit;

-- 기존컬럼삭제
alter table gallerylist drop column galmodifiedtime;

-- 컬럼이름변경
alter table gallerylist rename column galmodifiedtime2 to galmodifiedtime;

desc gallerylist;
-- 컬럼순서변경
-- 컬럼임시숨김
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
-- 컬럼보이기
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;
alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;

desc gallerylist;





select
substr(galmodifiedtime,0,8) from gallerylist;
select to_date(substr(galmodifiedtime,0,8),‘yyyy-mm-dd’) from gallerylist;