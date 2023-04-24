drop table vacation_condition cascade constraints purge;

CREATE TABLE vacation_condition(
	paper_num           number references vacation(paper_num) on delete cascade,
	reference_person	varchar2(15) references members(id) on delete cascade, --참조자 아이디
	condition	        varchar2(8) check (condition in ('승인','거절','대기')) -- 결재상태	
);


