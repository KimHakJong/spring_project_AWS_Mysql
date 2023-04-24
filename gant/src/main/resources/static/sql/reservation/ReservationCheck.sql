//8시~6시 : 20개 (9시:18 , 9시30분:19, 10시:20 ~ 18시30분:21)
//자원,날짜별 예약 가능,불가 여부확인 테이블
create table ReservationCheck(
num number references Reservation(num) on delete cascade,
resource_name varchar2(30),
day varchar2(12),
reserved_time number
);

select * from ReservationCheck;
drop table ReservationCheck;