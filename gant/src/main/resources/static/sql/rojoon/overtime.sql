drop sequence paper_seq; --전자결재 시퀀스삭제
create sequence paper_seq; --시퀀스생성

drop table overtime cascade constraints purge;

CREATE TABLE overtime(
id                 varchar2(15) references members(id) on delete cascade, --아이디
paper_num 	      number PRIMARY KEY, -- 문서번호
over_time	      varchar2(8), -- 초과근무시간
overtime_content  varchar2(2000), -- 작업내용
overtime_reason	  varchar2(2000), --사유
overtime_date	  varchar2(8), --근무일자
reference_person  varchar2(500), -- 참조자 (id,id,id..)형식으로 표시
condition	      varchar2(8)  check (condition in ('승인','거절','대기')), -- 결재상태
write_date	      varchar2(10)  default to_char(SYSDATE, 'YYYY/MM/DD') not null , --작성일
classification	  varchar2(30) default '초과근무신청서' --서류종류
);

