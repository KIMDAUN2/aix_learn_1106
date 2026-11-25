--무결성 제약조건
--not null:null 허용하지 않는다(중복가능)
--unique: 중복된 값을 허용하지 않는다.(null값은 허용)
--primary key: null을 허용하지 않고, 중복이 가능하지 않다
--foreign key: 참조되는 테이블의 컬럼의 값이 존재하면 허용
--check : 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값을 허용한다.

board
primary key : bno
foreign key : id
- on delete cascade
- on delete set null

mem
primary key : id


drop table board2;
drop table board3;

-- fk키 삭제후 pk를 삭제할수 있음
alter table board drop constraint board_fk_id;
alter table mem drop constraint mem_pk_id;

--pk,fk 설정,해제
--fk : on delete cascade, on delete set null


-- fk가 삭제가 되면, 아이디를 삭제해도, board bbb라는 아이디가 존재.
-- on delete cascade : 부모데이터 삭제시, 자식데이터 모두 삭제
-- on delete set null : 부모데이터 삭제시, 자식데이터는 null
-- mem aaa아이디를 삭제하면, board에 있는 aaa 컬럼을 모두 삭제됨.
alter table mem add constraint mem_pk_id primary key (id);
-- on delete cascade 설정됨.
alter table board add foreign key (id)
references mem (id) on delete cascade;
-- 삭제
alter table board drop constraint SYS_C008405;
-- on delete set null
alter table board add foreign key (id)
references mem (id) on delete set null;

-- board null허용설정
alter table board modify id VARCHAR2(50) null;

delete mem where id='ccc';
select * from mem;
select * from board;
delete mem where id='ccc';
insert into mem values(
'aabbcc','1111','홍홍홍','여자',sysdate,null,20
);
commit;
-- ------------------------------------------------------------------------
drop table board;

create table board as select * from board2;

desc board;

alter table board modify id varchar2(50) null;

drop table mem;
create table mem as select * from member;

alter table mem modify pw null;
alter table mem modify name null;


select * from mem;
select * from board;

update mem set id='aaa' where id ='Channa';
update mem set id='bbb' where id ='Tremain';
update mem set id='ccc' where id ='Lulu';
update mem set id='ddd' where id ='Sawyer';
update mem set id='eee' where id ='Dasya';
commit;


-- 제약조건(pk,fk,not null,check,unique)
-- mem pk - 추가 add
alter table mem add constraint mem_pk_id primary key (id);

select * from mem;
--check제약조건을 변경
alter table mem modify gender check(gender in ('남자','여자'));

select * from mem;
-- check 제약조건은 해당 체크내용으로만 입력이 가능
insert into mem values(
'fff','1111','홍길동','길순스','010-111-1111','여자','게임',sysdate);
commit;

-- fk등록 -add
-- 부모키를 삭제하려면,자식의 모든 아이디를 삭제해야 부모키를 삭제할 수 있음
-- on delete restricted : 기본값
-- on delete cascade : 부모 삭제시,자식 모두 삭제
-- on delete null : 부모 삭제시 , 자식 모두 null로 대체
alter table board add constraint boardmem_fk_id foreign key (id)
references mem (id);


-- 부모 aaa를 삭제하려면, 자식의 aaa와 연고나된 모든 것을 삭제해야 함.
delete mem where id='aaa';
delete board where id='aaa';
delete mem where id='bbb';
commit;

-- on delete cascade : 부모삭제시 자식도 모두 삭제
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key(id)
references mem (id) on delete cascade;

-- on delete set null : 부모삭제시 자식값 null
alter table board drop constraint boardmem_fk_id;
alter table board add constraint boardmem_fk_id foreign key(id)
references mem (id) on delete set null;


select * from mem;
delete mem where id='ccc';
select * from board;

drop table board;
drop table mem;





-- mem테이블id변경 후 delete해보기
-----------------------------------------------------------------------
-- board,mem 테이블 생성
-- mem - id:pk, gender:check
create table board as select * from board2;
create table mem as select * from member;

alter table mem modify pw null;
alter table mem modify name null;

alter table mem add constraint mem_pk_id primary key (id);
alter table mem modify gender check(gender in('남자','여자'));

insert into mem values(
'ddd','1111','홍길종','길동스','010-111-1111','남자','게임',sysdate
);

select * from mem;

--board -id:fk, on delete 
-- on delete restricted : 기본값
-- on delete cascade : 부모 삭제시,자식 모두 삭제
-- on delete set null : 부모 삭제시 , 자식 모두 null로 대체

alter table board add constraint boardmem_fk_id foreign key (id)
references mem (id);