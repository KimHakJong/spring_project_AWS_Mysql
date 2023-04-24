drop table vacation cascade constraints purge;


CREATE TABLE vacation (
id                 varchar2(15) references members(id) on delete cascade, --아이디
paper_num	       number PRIMARY KEY, -- 문서번호
start_date       varchar2(8), --휴가 시작일
end_date	       varchar2(8), --휴가 종료일
vacation_date      number, -- 휴가일수
division	       varchar2(30), -- 구분(휴가 종류)
emergency 	      varchar2(13), --비상연락망
details	           varchar2(2000), --세부사항
reference_person   varchar2(500), -- 참조자 (id,id,id..)형식으로 표시
condition	       varchar2(8)  check (condition in ('승인','거절','대기')), -- 결재상태
write_date	       varchar2(10)  default to_char(SYSDATE, 'YYYY/MM/DD') not null , --작성일
classification 	  varchar2(30) default '휴가신청서'	
);



