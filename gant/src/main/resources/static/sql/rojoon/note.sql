drop sequence note_seq; --쪽지 시퀀스삭제
create sequence note_seq; --쪽지 시퀀스생성	
	

DROP TABLE note CASCADE CONSTRAINTS;


CREATE TABLE note(
    id	            varchar2(15) references members(id) on delete cascade, -- id (작성자)
	to_id	        varchar2(300), --id을 "," 을 기준으로 나눈다.
    note_num	    number PRIMARY KEY,
	subject	     	varchar2(300),
	content	     	varchar2(4000),
	write_date	  	varchar2(10)  default to_char(SYSDATE, 'YYYY/MM/DD'), --작성일
	delete_num      number references note_delete(delete_num) on delete cascade,
	file_num         number 
);
