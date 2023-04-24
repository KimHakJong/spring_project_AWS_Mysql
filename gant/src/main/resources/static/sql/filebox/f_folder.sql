create table f_folder (  -- 파일 보관함의 폴더정보
p_no number references project(p_no) on delete cascade, --프로젝트 번호
folder_num number primary key, --폴더 번호
folder_name varchar2(50), --폴더명
folder_path varchar2(3000) --폴더경로
);
drop table f_folder cascade constraints purge
