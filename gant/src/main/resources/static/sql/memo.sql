CREATE TABLE memo (
  num INT PRIMARY KEY,
  id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
  subject VARCHAR(30),
  content VARCHAR(3000),
  background VARCHAR(100),
  color VARCHAR(20),
  update_date VARCHAR(14) DEFAULT (DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'))
);

select * from memo;
drop table memo;