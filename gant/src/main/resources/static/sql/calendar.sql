drop table calendar cascade constraints purge;
drop table members cascade constraints purge;
drop table project cascade constraints purge;

create table calendar(
id  varchar2(100), 
allday varchar2(15) default 'true',
startday varchar2(30),
endday varchar2(30),
name varchar2(30) references members(id) on delete cascade,
title varchar2(2000)
);

create table pcalendar(
id  varchar2(100), 
p_no number references project(p_no) on delete cascade, 
hostid varchar2(15),  --host도 admin 권한을 가진다
allday varchar2(15) default 'true',
startday varchar2(30),
endday varchar2(30),
name varchar2(30) references members(id) on delete cascade,
title varchar2(2000)
);

insert into calendar values('admin', 'true', 'true', '2023-03-20', '2023-03-21', '프로젝트', '프로젝트 기간');  
insert into members values('true','asd12345','12345678','박길동','811111-1111111','
010-1111-1111','1@1.com','22222','서울시 종로구','인사부','대리',null,'20230201');