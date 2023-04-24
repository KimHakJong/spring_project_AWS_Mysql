//계정당 하루 6시간 예약가능(30분당 1개씩 차감)
//예약가능횟수 할당 테이블
create table ReservationCount(
id varchar2(15)  references members(id) on delete cascade,
possible number default 12
);

select * from ReservationCount;
drop table ReservationCount;