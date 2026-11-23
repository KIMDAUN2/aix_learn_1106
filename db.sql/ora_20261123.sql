-- -----------------------------sysdate,add_months
select * from member;

select sysdate from dual;

select mdate from member;
select sysdate-mdate from member;

select mdate,add_months(mdate,10),add_months(mdate,-10) from member;
-- 현재 가입날짜가 10개월 이상 된 사람들을 출력하시오.
select mdate,add_months(sysdate,-10) from member;

select mdate,add_months(sysdate,-10) from member
where mdate <= add_months(sysdate,-10);

-- ---------------------------------------trunc,between
-- mdate컬럼확인
select mdate from member;

-- mdate 그달의 첫째일, 마지막일을 출력하시오.
-- trunc
select mdate, add_months(mdate,1),
trunc(add_months(mdate,1),'mm') , last_day(mdate) from member;

-- 간격차이
select round(months_between(sysdate,mdate),2) from member;

-- 가입한지 8개월 째 되는 회원을 출력하시오.
select name,mdate,add_months(sysdate-8) from member;
select mdate,trunc(months_between(sysdate,mdate)) from member
where trunc(months_between(sysdate,mdate)) =8;
-9개월째
select name,mdate,round(months_between(sysdate,mdate),1),round(months_between(sysdate,mdate)) from member
where round(months_between(sysdate,mdate)) =9;


-- ----------------------------------------------next_day
-- 다다음주 목요일 출력
select next_day(sysdate,'목') from dual;   --이번주목요일
select next_day(next_day(sysdate,'목'),'목') from dual;


-- ------------------------------------------------to_char,to_date
-- 년도-월-일 시:분:초 로 출력
select sysdate from dual;
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss day') from member;

select * from employees;

-- 190번대(190~199) 까지 salary(월급),년봉,원화연봉을 출력
-- 천단위표시,원화년봉은 원화표시로 출력
select trunc(employee_id,-1) from employees
where trunc(employee_id,-1)=190;

select employee_id from employees
where employee_id >=190 and employee_id<=199;

select employee_id,
to_char(salary,'999,999') as salary1,
to_char(salary*12,'999,999') as ysalary,
to_char(salary*12*1420,'L999,999,999')
from employees
where employee_id between 190 and 199;



-- -------------------------------------------------------------------------
select * from gallerylist;

--galmodifiedtime
--날짜포맷으로 변경하시오.

------------------------------선생님예시
-- 1. 문자타입을 날짜타입으로 변경
select galmodifiedtime, to_date(galmodifiedtime,'yyyy-mm-dd hh24:mi:ss') from gallerylist;
---------------------------------
-- 1. 새로운 컬럼 추가
alter table gallerylist add(galmodifiedtime1 date);
-- 2. 확인
select * from gallerylist;
-- 3. 날짜타입에 날짜데이터추가
update gallerylist
set galmodifiedtime1 = to_date(galmodifiedtime,'yyyymmddhh24miss');
-- 4. 바꾸려던 컬럼 삭제
alter table gallerylist
drop column galmodifiedtime;
-- 5. 새로운컬럼을 기존컬럼이름으로 변경
alter table gallerylist
rename column galmodifiedtime1 to galmodifiedtime;
-- 6. 컬럼 순서변경
-- insivble: 숨김
alter table gallerylist modify galPhotographyMonth invisible;
alter table gallerylist modify galPhotographyLocation invisible;
alter table gallerylist modify galPhotographer invisible;
alter table gallerylist modify galSearchKeyword invisible;
-- visible : 다시 보이기
alter table gallerylist modify galPhotographyMonth visible;
alter table gallerylist modify galPhotographyLocation visible;
alter table gallerylist modify galPhotographer visible;
alter table gallerylist modify galSearchKeyword visible;
-- 컬럼타입확인
desc gallerylist;
commit;


-- 문자열에서 원하는 위치부터 원하는 길이만큼 잘라내는 함수
-- substr(문자열, 시작위치, 길이)
select substr(galmodifiedtime,0,8) from gallerylist;
select to)date(substr(galmodifiedtime,0,8),'yyyy-mm-dd') from gallerylist;


-- 문자열 20,000 / 문자열11,900 =8,100 으로 출력하시오.
-- 숫자로 변경 후 빼기를 한 후 결과값을 출력하시오.
select to_number('20,000','999,999'),  -- 문자열을 숫자로 변경
to_number('11,900','999,999'),
to_char(to_number('20,000','999,999')- to_number('11,900','999,999'),'999,999')
from dual;


-- is_null(null값 찾기)
select emp_name,commission_pct from employees
where commission_pct is null;
-- nvl(commission_pct,0) (null값을 다른값으로 바꿔주는 함수)
select salary+salary*nvl(commission_pct,0),salary,nvl(commission_pct,0) from employees;

--ceo
--manager_id : number
--문자로 변경은 to_char
select manager_id, nvl(to_char(manager_id),'ceo') from employees;




-- 그룹함수 : count,sum,avg,max,min
--그룹함수는 단일그룹과 함께 사용할 수 없음
-- count 
-- null 값은 개수로 출력 안됨
--commission_pct null 사람이 몇명인지 출력
select count(*) from employees
where commission_pct is null;
-- avg,sum,max
select * from stuscore;
select avg(kor) from stuscore;
select avg(eng) from stuscore;
select sum(math) from stuscore;
select max(kor) from stuscore;
-- max,min
select max(salary),min(salary) from employees;
 
-- 년봉이 가장 높은 사람의 이름을 출력하시오.
-- 단일컬럼과 그룹함수를 함께 사용할 수 없음.
select * from employees
where salary=(select max(salary) from employees);

-- 평균월급보다 작게 받는 사원수를 출력하시오.
select avg(salary) from employees;

select count(*) from employees
where salary<(select avg(salary) from employees);

select count(*) from employees;

-- stuscore, kor최대값,최소값,평균,합계
select max(kor),min(kor),avg(kor),sum(kor) from stuscore;
-- 국어점수 가장 적게 받은 학생을 출력하시오.
select * from stuscore
where kor=(select min(kor) from stuscore); 

-- 문자열 이어붙이기
select name||school from stuscore;
select concat(name,school) from stuscore;

-- like : 지정한 패턴과 일치하는지 비교하는 연산자
-- stuscore m이 들어간 학생을 모두 출력하시오.
select count(*) from stuscore
where name like '%m%' or name like '%M%';

select count(*) from stuscore
where lower(name) like '%m%';

-- 3번재 m이 들어간 학생을 출력하시오.
select * from stuscore
where lower(name) like '__m%';

-- lower(): 소문자, upper():대문자, initcap(): 첫글자대문자

select email,lower(email),initcap(email) from employees;

-- lpad(왼쪽을 지정한 길이만큼 채움),rpad(오른쪽을 지정한 길이만큼 채움)
-- lpad(문자열, 전체길이, '채울문자')
select kor,lpad(kor,5,'0') from stuscore;
select kor,rpad(kor,5,'*') from stuscore;

select galcontentid from gallerylist;
select galcontentid,length(galcontentid) from gallerylist;
select galcontentid,rpad(galcontentid,9,'*') from gallerylist;
--1번째자리부터 5번째 자리까지 문자 놔두고,7자리중 나머지 *
select galcontentid,rpad(substr(galcontentid,0,5),7,'*') from gallerylist;

--
select * from gallerylist;

select * from employees;
-- email 뒤에 2자리를 *로 출력하시오
select email from employees;
select email,length(email)from employees;
select email,rpad(substr(email,0,length(email)-2),length(email),'*') from employees;

select email,substr(email,1,2) from employees;

select * from member;

-- 220-***-9788 
select tel from member;
select
substr(tel,1,4)||'***'||substr(tel,8,length(tel)) as marktel
from member;


-- ltrim,rtrim : trim
-- 공백제거,특정문자제거
select '     aaa1111',ltrim('    aaa111')from dual;
select '20261101',ltrim('20261101','2026') from dual;
select '0001101',ltrim('000110100','0'),rtrim('0001101','0') from dual;

--replace : 가운데 문자까지 지울 때
select replace('000110100','0','')from dual;


-- length() : 문자열의 길이 출력
select emp_name,length(emp_name) from employees;

-- member
create table member2 as select * from member;
select * from member2;

create table member3 as select * from member where 1=2;

select * from member3;

-- 구조가 member테이블과 같을 때,insert 명령어를 통해 입력가능
insert into member3 select * from member;
commit;

desc member;

-- member 컬럼명이 다름.
create table member4(
mid varchar2(50) not null,
mname varchar2(30) not null,
mgender char(6)
);


insert into member4 (mid,mname,mgender) select id,name,gender from member;

-- 테이블구조복사, 데이터복사(member2)
-- 테이블구조만 복사(member3)
-- 테이블 생성 후 , 데이터 복사(member4)
-- 컬럼이 다르지만, 타입이 같은 테이블에 일부 컬럼을 복사(member5)

create table member5 as select id,pw,name from member;

select * from member5;

select * from employees;

---------------------------------------------
CREATE TABLE BOOK (
    BNO NUMBER PRIMARY KEY,          -- 도서번호
    BTITLE VARCHAR2(200) NOT NULL,   --도서명
    BAUTHOR VARCHAR2(100),           --저자
    BPUBLISHER VARCHAR2(100),        -- 출판사
    BPRICE NUMBER(10) NOT NULL,      --판매가격
    BDISCOUNT NUMBER(5,2) DEFAULT 0, --할인율
    BSTOCK NUMBER(5) DEFAULT 0,      --재고수량
    BCATEGORY VARCHAR2(50),          -- 도서분류
    BDATE DATE,                      --출판일
    BREGDATE DATE DEFAULT SYSDATE,   -- 상품등록일
    updateDATE DATE DEFAULT SYSDATE, -- 상품수정일
    thimage varchar2(500),           -- 썸네일이미지
    mainimage varchar2(500),         -- 메인이미지
    fileimage varchar2(500),         -- 파일첨부이미지
    search varchar2(1000)            -- 검색어
);

-- 현재 월과 같은 월에 등록된 회원을 출력하시오.
select * from member;
select to_char(sysdate,'mm') from dual;
select mdate from member
where to_char(sysdate,'mm') = to_char(mdate,'mm');

-- 컬럼추가,수정,삭제,타입변경
select * from stuscore;
-- 컬럼추가
alter table stuscore add sturank number(3);

-- 컬럼수정
alter table stuscore modify(total varchar2(30));
alter table stuscore modify(total number(4,1));
desc stuscore;
--컬럼안에 데이터가 변경이 가능한 형태여야 가능
--alter table stuscore modify(specialty number(5));
--alter table stuscore modify(height varchar2(50));

desc board3;
select * from board3;
alter table board3 modify(bstep varchar2(4));
-- null값으로 변경 하고 위에 bstep 타입변경 가능
update board3 set bstep= null;
commit;

-- 컬럼삭제
alter table stuscore drop column sturank;
desc stuscore;

-- rank컬럼 추가
alter table stuscore add rank number(4);

-- 컬럼이름변경
alter table stuscore rename column rank to srank;



--무결성 제약조건
--not null:null 허용하지 않는다(중복가능)
--unique: 중복된 값을 허용하지 않는다.(null값은 허용)
--primary key: null을 허용하지 않고, 중복이 가능하지 않다
--foreign key: 참조되는 테이블의 컬럼의 값이 존재하면 허용
--check : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값을 허용한다.

create table mem(
id varchar2(50) primary key,
pw varchar2(100) not null,
name varchar2(20) unique,
gender varchar2(6) check(gender in('남자','여자')),
mdate date default sysdate,
mfile varchar2(10)
);

alter table mem add age number(5,2) check(age between 0 and 200);

desc mem;

insert into mem values(
'fff','1111','','여자',sysdate,'',100);

select * from mem;

select * from screen;
-- 제약조건 변경,삭제
alter table screen add primary key(sno);
alter table screen drop constraint SYS_C008396;

select * from mem;
alter table mem drop constraint SYS_C008393;
alter table mem add constraint mem_pk_id primary key(id);

-- foreign key 등록하려면,
-- 우선 다른 테이블에서 primary key 등록이 되어 있어야 가능
select * from mem;

select * from board2;
select bno from board2
order by bno;

-- 1-20 : id-aaa
-- 21-40: bbb, 41-60:ccc, 61-80:ddd, 81-100:eee
update board set id = 'aaa'
where bno between 1 and 20;
update board set id = 'bbb'
where bno between 21 and 40;
update board set id = 'ccc'
where bno between 41 and 60;
update board set id = 'ddd'
where bno between 61 and 800;
update board set id = 'eee'
where bno between 81 and 100;

select * from board order by bno;
commit;

-- foreign key 변경설정
alter table board add constraint board_fk_id foreign key(id)
references mem(id);

select * from board;
select * from mem;

insert into board values(
101,'ddd','게시글 제목','게시글 내용',101,0,0,0,sysdate,'');

select * from board2;

create table member2 as select * from member;

drop table member2;
-- 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다 라는 오류로
-- 삭제 불가
drop table mem;
