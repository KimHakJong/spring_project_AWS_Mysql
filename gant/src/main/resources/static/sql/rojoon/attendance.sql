CREATE TABLE attendance(
id                 varchar2(15) references members(id) on delete cascade, --아이디
startTime          varchar2(8),       --출근시간
endTime              varchar2(8),       --퇴근시간
overTime          varchar2(8),       --초과근무시간
work_today          varchar2(8),       --오늘 근무시간
work_week          varchar2(8),       --주간 근무시간
work_date          varchar2(8),     -- 출근일 ex) 20220203
checkbutton         varchar2(5) check (checkbutton in ('true','false')) -- 출근 퇴근 버튼 클릭시 체크 / true일때 출근버튼 비활성화상태 , false일때 퇴근버튼 비활성화 상태
);

drop table attendance cascade constraints purge;

delete from attendance;

select * from attendance;