CREATE TABLE f_folder (
  p_no int REFERENCES project(p_no) ON DELETE CASCADE, -- 프로젝트 번호
  folder_num int PRIMARY KEY, -- 폴더 번호
  folder_name varchar(50), -- 폴더명
  folder_path varchar(3000) -- 폴더 경로
);
drop table f_folder cascade constraints purge
