-- 출근 퇴근시간을 기록하는 테이블이다.

CREATE TABLE commute_record(
id                 varchar2(15) references members(id) on delete cascade, --아이디
startTime          varchar2(8),       --출근시간
endTime            varchar2(8),       --퇴근시간
work_date          varchar2(8),     -- 출근일 ex) 20220203
work_today          varchar2(8)       --총 근무시간
);

drop table commute_record cascade constraints purge;



