drop sequence notefile_seq; --쪽지파일 시퀀스삭제
create sequence notefile_seq; --쪽지파일 시퀀스생성

drop table notefile CASCADE CONSTRAINTS;

CREATE TABLE notefile(
	file_num       number PRIMARY KEY,
	original_filename 	varchar2(50), -- 오리지널 파일이름
	extension		 varchar2(50), -- 확장자
	save_folder		 varchar2(1000) -- 저장경로 (파일경로 + 중복방지파일명)
);

