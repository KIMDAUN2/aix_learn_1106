drop table board;

drop table board2;

drop table stuscore;


create table board(
bno number(4) primary key,
id varchar2(50) not null,
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);

select * from employees;

-- select board_seq.nextval from employees;
-- nextval 1씩 증가
-- currval 현재 시퀀스 번호가 몇번인지 알려줌.
select board_seq.nextval from dual;
select board_seq.currval from dual;

select * from board;
insert into board values(
board_seq.nextval,'aaa','게시글제목','게시글내용',
board_seq.currval,0,0,0,sysdate,'1.jpg'
);

insert into board (bno,id,btitle,bcontent,bgroup,bfile) values(
board_seq.nextval,'aaa','게시글제목2','게시글내용2',
board_seq.currval,'2.jpg'
);

-- select, insert, update, delete / commit,rollback

rollback;
select * from board;

-- 테이블구성, 테이블데이터 모두 복사
create table board2 as select * from board;

-- 테이블구성만 복사
create table board3 as select * from board where 1=2;

drop table board;
drop table board2;
drop table board3;

-- board테이블 생성후 board.csv파일을 import하시오.
-- board2-데이터까지 복사해서 생성,board3-구조만 복사 생성하시오.
-- stu2.xlsx 관련된 stuscore테이블을 생성하고 파일을 import하시오.
create table board3 as select * from board where 1=2;

-- students.xls 파일을 students테이블을 생성해서 import하시오.
-- member테이블 생성하시오.


create table stuscore (
    no number(4) primary key,
    name varchar2(50) not null,
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

create table gallerylist (
    gno number(12) primary key,
    galContentId varchar2(8) not null,
    galContentTypeId varchar2(10),
    galTitle varchar2(100),
    galWebImageUrl varchar2(100),
    galCreatedtime varchar2(100),
    galModifiedtime varchar2(100),
    galPhotographyMonth varchar2(30),
    galPhotographyLocation varchar2(100),
    galPhotographer varchar2(100),
    galSearchKeyword varchar2(1000)
);

drop table gallerylist;





select * from stuscore;

-- order by asc, desc
select * from stuscore
order by rank, height asc,kor desc;


-- 숫자함수
-- abs : 절대값
select abs(-10) from dual;

-- round():반올림, ceil():올림,floor():버림,trunc():자르기
select 100/6 from dual;
-- 소수점 자리수
select round(100/6,2) from dual;
-- floor,ceil 소수점 첫째자리에서 계산
select round(1978,-1) from dual;

select floor(100/6) from dual;
select ceil(100/3) from dual;

select * from stuscore;

select round(kor,-1) from stuscore;

select kor,trunc(kor,-1),round(kor,-1) from stuscore;

-- select trunc(bdate,1) from board;

select mod(23,2) from dual;

-- stuscore 홀수학생만 출력하시오.
select * from stuscore
where mod(rank,2)=1;

select * from stuscore
where rank=1 or rank=3;

select * from stuscore
where rank in(1,3);


-- 형변환 : number,varchar2,char,clob,date
-- last_day
select sysdate-365,sysdate,last_day(sysdate+365) from dual;

-- 명령어를 조합해서 사용가능
select mdate as 가입일,round(sysdate-mdate,2) from member;

select mdate,to_char(mdate,'yyyymmdd') from member;

-- round():반올림
select mdate,round(mdate,'month') from member;
select mdate,round(mdate,'year') from member;

-- 날짜형태
select mdate,to_char(mdate,'yyyy-mm-dd hh:mi:ss') from member;

select * from board3;
select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board3;
insert into board3 values(
1,'aaa','게시글제목','게시글내용',1,0,0,0,sysdate,'1.jpg'
);

-- 날짜: 숫자함수 - round,trunc
-- 월기준 : month,mon,mm
-- 년도기준 : year,yyyy
select mdate,last_day(mdate),trunc(mdate,'month'),round(mdate,'mon') from member;
select mdate,last_day(mdate),trunc(mdate,'year'),round(mdate,'year') from member;
select mdate,trunc(mdate,'yyyy') from member;

select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board3;

-- 요일기준 - trunc:해당기간 일요일날짜로 변경,  round:수요일기준으로 반올림
-- hh,mi,ss 기준으로 trunc,round 사용
select mdate,trunc(mdate,'day') from member;
select sysdate,trunc(sysdate,'day'),round(sysdate,'day') from dual;

-- months_between : 날짜와날짜사이 개월수
select mdate,sysdate,months_between(sysdate,mdate) from member;

select mdate,sysdate,trunc(months_between(sysdate,mdate)) from member
where months_between(sysdate,mdate)<=6;

-- add_months : 개월 추가
-- 1년후 첫째일, 마지막일을 출력하시오.
select mdate,add_months(mdate,12),
trunc(add_months(mdate,12),'mm'),last_day(add_months(mdate,12))
from member;

-- 금요일이면 이전 일요일날짜로 이동
select trunc(sysdate,'day'),sysdate,round(sysdate,'day') from dual;

-- 다가오는 요일의 날짜를 리턴
select next_day(sysdate,'토요일')from dual;
-- 일요일마다 행사가 있어요.다음번 일요일은 언제일까요?
select next_day(next_day(sysdate,'일요일'),'일요일') from dual;

-- 날짜와 날짜의 사이 계산
select (sysdate-(sysdate-1)) from dual;

select sysdate-mdate from member;

--trunc() : 1일자를 알려줌
--round() : 15일 기준으로 이전은 1일, 이후는 다음달 1일
--last_day: 마지막 날짜를 알려줌

--varchar2 타입 -> to_date()
--에러 : select '2026-11-20'+1 from dual;
select '2026-11-20' from dual;
select to_date('2026-11-20') from dual;
select to_date('galcreatedtime') from gallerylist;
select galcreatedtime from gallerylist;

--substr 함수
-- 'abcdef'[0:2]
-- substr함수를 사용해서 날짜부분만 추출 후, 날짜 타입으로 변경
select to_date(substr(galcreatedtime,1,8))+1 from gallerylist;

select substr('abcdsfg',1,5) from dual;

select galcreatedtime from gallerylist;

select trunc(to_date(substr(galcreatedtime,1,8)),'month') from gallerylist;
select last_day(to_date(substr(galcreatedtime,1,8))) from gallerylist;

-- 2026-11-20 12:34:12
select bdate from board3;
select to_char(bdate,'yyyy-mm-dd hh:mi:ss day') from board3;

select * from board3;

insert into board3 values(
2,'aaa','222게시글','222내용',2,0,0,0,sysdate,'2.jpg'
);

commit;

-- yyyy/mm/dd hh24:mi:ss day
select * from board3;
select to_char(bdate,'yyyy-mm-dd hh24:mi:ss day') from board3;

--년,월 출력
select to_char(mdate,'yyyy-mm') from member;
- 월 출력
select to_char(mdate,'mm') from member;
--가입일이 7월인 사람만 출력
select mdate from member
where to_char(mdate,'mm') = '07';


--1990년대 입사한 사람을 출력하시오.
--2000년대 입사한 사람을 출력하시오.
select hire_date from employees;
select emp_name,hire_date,to_char(hire_date,'yyyy')from employees
where substr(to_char(hire_date, 'yyyy'),0,2) = '20';

select trunc(sysdate,'year') from dual;

--kor 40점대 ,60점 대, 80점 대에 있는 사람을 출력하시오.
select * from stuscore;