create table f_fileinfo (  -- 파일 보관함의 파일정보
file_num number references filebox(file_num) on delete cascade, --파일번호
file_name varchar2(100), --파일명
extension varchar2(4), --확장자
included_folder_num number references f_folder(folder_num) on delete cascade,-- 폴더 번호(해당 폴더 번호 하위에 파일생성)
file_save_path varchar2(3000) --파일저장경로
);

drop table f_fileinfo