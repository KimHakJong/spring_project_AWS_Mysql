//계정당 하루 6시간 예약가능(30분당 1개씩 차감)
//예약가능횟수 할당 테이블
CREATE TABLE ReservationCount (
  id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
  possible INT DEFAULT 12
);
select * from ReservationCount;
drop table ReservationCount;