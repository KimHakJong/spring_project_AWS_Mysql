//예약추가,수정,조회
CREATE TABLE Reservation (
  num INT PRIMARY KEY,
  id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
  purpose VARCHAR(35),
  names VARCHAR(100),
  type VARCHAR(20),
  resource_name VARCHAR(30),
  day VARCHAR(10),
  start_time VARCHAR(6),
  end_time VARCHAR(6)
);
select * from Reservation;
drop table Reservation cascade constraints purge;