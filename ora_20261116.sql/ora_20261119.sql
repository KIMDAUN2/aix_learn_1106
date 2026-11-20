create table stuscore (
    no number(4),
    name varchar2(50),
    school varchar2(100),
    rank number(1),
    height number(4,1),
    kor number(4,1),
    eng number(4,1),
    math number(4,1),
    total number(4,1),
    avg number(5,2),
    specialty varchar2(50)
);

-- 순차정렬
select * from stuscore
order by height asc;

-- 역순정렬
select * from stuscore
-- height,kor 역순정렬, eng 순차정렬
order by height desc, kor desc,eng asc;

select * from stuscore;

-- 이름 순으로 역순정렬
select * from stuscore
order by  name desc;

-- 학교 순으로 순차정렬, rank 역순정렬
select * from stuscore
order by school asc, rank desc;

-- employees테이블에서 입사일 기준으로 순차정렬(오름차순)을 하고
-- 출력은 사원번호,사원명,직급,입사일 컬럼 출력
select  employee_id,emp_name,job_id,hire_date from employees
order by hire_date asc;

--전체 컬럼
desc employees;

-- 사원번호 ,부서를 출력하되(employee_id,deparement_id)
-- 정렬 부서 순차정렬, 입사 역순정렬 하시오.
select employee_id,department_id,hire_date from employees
order by department_id asc, hire_date desc;

--dual 임시테이블(가상테이블)
select -1 from dual;
--select 'aaa' from dual;
select (-1*3+100-100) from dual;

-- abs: 절대값 출력
select abs(-123) from dual;
-- round : 반올림 // round(값,자리수)
select round(12.34567) from dual;

-- 평균을 소수점 2자리에서 반올림해서 출력하시오.
select kor,eng,math,kor+eng+math total,round((kor+eng+math)/3,2) avg from stuscore;

-- 반올림: round
select round ((kor+eng+math)/3,2) from stuscore;
-- 내림 : floor
select floor ((kor+eng+math)/3) from stuscore;
-- 올림 : ceil
select ceil ((kor+eng+math)/3) from stuscore;
-- 버림: trunc(특정자리수 버림)
select (kor+eng+math)/3, trunc ((kor+eng+math)/3,3) from stuscore;
-- 나머지: mod
select mod(3,2) from dual;
-- 국어 점수10점 단위로 반올림 한 값과 버림한 값/-1: 십의 자리까지 남기고 일의 자리를 정리한다.
select kor,round(kor,-1),trunc(kor,-1) from stuscore;

--1915,1921,1988,1819,1894,1910,1905,1719,1591
-- 1915,1819,1719
-- 1900,1900,1800,1700
-- dual 사용
select trunc(1915,-2) from dual;

-- 사원번호 홀수인 사원을 출력하시오.
-- 역순정렬로 출력하시오.
-- 순서(테이블->조건절->정렬)
select employee_id from employees
where mod(employee_id,2)=1
order by employee_id desc;

--(name,kor,eng,math)
-- stuscore 평균값이 80점 이상인 학생을 출력하시오.
select kor,eng,math,(kor+eng+math)total,round((kor+eng+math)/3,2) avg from stuscore
where (kor+eng+math)/3 >=80
order by round((kor+eng+math)/3,2) desc;

--stuscore no 짝수인 학생을 출력하시오
select name,no from stuscore
where mod(no,2)=0;
-- 5의 배수
select * from stuscore
where mod(no,5)=0;

select * from stuscore;

select * from board;

-- 시퀀스 : 번호가 자동으로증가, 1씩 증가 
select board_seq.nextval from dual;  --다음 번호 뽑기

select board_seq.currval from dual;  --현재 번호 확인


-- 테이블 복사와 데이터 복사를 함께 실행
create table stuscore2 as select * from stuscore;
-- 테이블구조만 복사 실행
create table stuscore3 as select * from stuscore where 1=2;

select * from stuscore3;
desc stuscore3;

insert into stuscore3 values(
board_seq.nextval, '홍길동','신림고',1,190,100,100,99,(100+100+99),
(100+100+99)/3,'python'
);

select * from stuscore3;
delete stuscore3;
commit;

-- stuscore2 시퀀스를 101 부터 시작
-- stuscore2 홍길동 학생성적을 입력해보세요
select * from stuscore2;
insert into stuscore2 values(
stuscore2_seq.nextval,'홍길동','신림고',1,180,100,100,99,229,(229/3),'python'
);

commit;

select stuscore2_seq.currval from dual;

create sequence board2_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
nocache;



-- sql 기본 select,insert,update,delete
-- 게시판 리스트 : select
-- 게시글 입력 : insert
-- 게시글  수정 : update
-- 게시글 삭제 : delete

select * from stuscore2;
select stuscore2_seq.currval from dual;
insert into stuscore2 values(
stuscore2_seq.nextval, '유관순','신림고',1,170,90,90,91,271,(271/3),'c'
);

select * from stuscore2;

update stuscore2 set name = '유관자' where no=102;

-- board형태 그대로 구조,데이터 복사해서 board2만들고,
-- 시퀀스 board2_seq 생성
-- 시작 101번부터 1개의 게시글 입력해서 출력하시오.
create table board2 as select * from board;
select * from board2;
insert into board2 (bno,id,btitle,bcontent,bgroup) values(
board2_seq.nextval,'aaa','게시글 제목','게시글을 내용입니다.',board2_seq.currval
);

--속성 : default
desc board2;
alter table board2 modify(bstep default 0);


insert into board2(bno,id,btitle,bcontent,bgroup,bfile) values(
board2_seq.nextval,'aaa','제목','내용',
board2_seq.currval,'1.jpg'
);
select * from board2;


--bno = primary key 등록
alter table board2 add primary key (bno);
desc board2;

commit;

create table board2 (
 bno number(4) primary key,
 id varchar2(50) not null,
 btitle varchar2(1000) not null,
 bcontent clob not null,
 bgroup number(4),
 bstep number(4) default 0,
 bindent number(4) default 0,
 bhit number(4) default 0,
 bdate date default sysdate,
 bfile varchar2(100)
 );
 
 -- board,board2 테이블 구조가 같음.
 -- board의 데이터를 board2로 
 insert into board2 select * from board;
 select * from board2;
 
 commit;
 
 select board2_seq.nextval from dual;
 
 -- 오라클 (숫자타입, 문자타입, 날짜타입)
 -- number, varchar, char, clob, date
 
 delete board2;
 
 commit;
 
 select * from board2;
 
 insert into board2(bno,id,btitle,bcontent,bgroup,bdate) values (
 1,'aaa','제목','내용',1,sysdate
 );
 
 select * from stuscore;
 
 drop table member;
 
 create table member (
 id varchar2(50) primary key,
 pw varchar2(100) not null,
 name varchar2(30) not null,
 nickname varchar2(30),
 tel char(12),
 gender char(6) default '남자',
 hobby varchar2(50) default '게임',
 mdate date default sysdate
 );
 
 
 select * from member;
 
create table screen (
 sno number(10) ,
 rank number(10) ,
 title varchar2(300) not null,
 "DATE" date default sysdate,
 percent number(5,2) ,
 revenue number(15) ,
 crevenue number(15),
 sales number(12),
 csales number(12)
 ); 
 
select * from screen;

drop table screen;

create table screen (
 sno number(5) ,
 rank number(5) ,
 title varchar2(100),
 sdate date,
 percent number(5,2) ,
 revenue number(15) ,
 crevenue number(15),
 sales number(10),
 csales number(10)
 ); 
 
 select * from screen;
 commit;
 
 create table screen2(
  movie_cd      VARCHAR2(20),
  movie_nm      VARCHAR2(500),
  movie_nm_en   VARCHAR2(500),
  prdt_year     VARCHAR2(4),
  open_dt       DATE,
  type_nm       VARCHAR2(50),
  prdt_stat_nm  VARCHAR2(50),
  nation_alt    VARCHAR2(300),
  genre_alt     VARCHAR2(300)
 );
 
 select * from screen2;
 commit;
 
 
 --varcahr2 와 number차이점
 -- varchar2 는 글자,기호,숫자 모양의 글자 , number계산할 수 있는 숫자