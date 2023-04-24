//8시~6시 : 20개 (9시:18 , 9시30분:19, 10시:20 ~ 18시30분:21)
//자원,날짜별 예약 가능,불가 여부확인 테이블
CREATE TABLE ReservationCheck (
  num INT REFERENCES Reservation(num) ON DELETE CASCADE,
  resource_name VARCHAR(30),
  day VARCHAR(12),
  reserved_time INT
);
select * from ReservationCheck;
drop table ReservationCheck;