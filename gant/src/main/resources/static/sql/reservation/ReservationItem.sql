//종류별 자원 목록, 최대 인원 수 테이블
create table ReservationItem(
type varchar2(20),
resource_name varchar2(30),
max_person number
);
select * from ReservationItem
drop table ReservationItem
