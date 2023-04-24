create table filebox ( -- 파일 보관함 작성
p_no number references project(p_no) on delete cascade, --프로젝트 번호
file_num number primary key, --파일 번호
id varchar2(15) references members(id) on delete cascade, --파일 업로더
upload_date varchar2(10) default to_char(sysdate,'YYYY/MM/DD') --올린 날짜
);
drop table filebox cascade constraints purge