//종류별 자원 목록, 최대 인원 수 테이블
CREATE TABLE ReservationItem (
  type VARCHAR(20),
  resource_name VARCHAR(30),
  max_person INT
);
select * from ReservationItem
drop table ReservationItem
