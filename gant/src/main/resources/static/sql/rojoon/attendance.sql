CREATE TABLE attendance (
    id varchar(15) references members(id) on delete cascade,
    startTime varchar(8),
    endTime varchar(8),
    overTime varchar(8),
    work_today varchar(8),
    work_week varchar(8),
    work_date varchar(8),
    checkbutton varchar(5) check (checkbutton in ('true','false'))
);

DROP TABLE IF EXISTS attendance;

