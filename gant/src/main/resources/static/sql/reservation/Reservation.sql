//예약추가,수정,조회
create table Reservation(
num number primary key,
id varchar2(15) references members(id) on delete cascade,
purpose varchar2(35),
names varchar2(100),
type varchar2(20),
resource_name varchar2(30),
day varchar2(10),
start_time varchar2(6),
end_time varchar2(6)
);

select * from Reservation;
drop table Reservation cascade constraints purge;