drop sequence note_delete_seq; --쪽지휴지통 시퀀스삭제
create sequence note_delete_seq; --쪽지휴지통 시퀀스생성	


drop table note_delete CASCADE CONSTRAINTS;


CREATE TABLE note_delete(
	delete_num      number PRIMARY KEY,
	kind          varchar2(4) check (kind in ('from','to')), --보낸쪽지테이블이면"from" 받은 쪽지 테이블이면 "to"
	delete_table  varchar2(3) check (delete_table in ('yes','no')), -- 휴지통 버리기를 선택했다면"yes" 선택하지 않았다면 "no"
	delete_date   varchar2(8) -- 만약 휴지버리기를 시작했다면 "20230203" 형태로 날짜가 삽입된다. 만약 버리기를 취소했다면 다시 공백을 넣는다. 버리기 날짜를 기준으로 일주일 뒤에 테이블은 삭제된다.
	);

