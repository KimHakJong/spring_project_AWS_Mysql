drop table note_to CASCADE CONSTRAINTS;

CREATE TABLE note_to(
	note_num	     number,
	id	             varchar2(15) references members(id), -- 보낸사람 id
	to_id	         varchar2(15) references members(id) on delete cascade, --보내는사람 id
	read_check 		varchar2(5)  check (read_check in ('true','false')), -- true 쪽지 읽음 , false 쪽지 안읽음
    subject	    	varchar2(300),
	content	     	varchar2(4000),
	write_date	 	varchar2(10)  default to_char(SYSDATE, 'YYYY/MM/DD'),
	delete_num       number references note_delete(delete_num) on delete cascade,
	file_num         number 
	);

