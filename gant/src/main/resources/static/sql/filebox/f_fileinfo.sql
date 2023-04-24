CREATE TABLE f_fileinfo (
  file_num int REFERENCES filebox(file_num) ON DELETE CASCADE, -- 파일 번호
  file_name varchar(100), -- 파일명
  extension varchar(4), -- 확장자
  included_folder_num int REFERENCES f_folder(folder_num) ON DELETE CASCADE, -- 폴더 번호 (해당 폴더 번호 하위에 파일 생성)
  file_save_path varchar(3000) -- 파일 저장 경로
);
drop table f_fileinfo