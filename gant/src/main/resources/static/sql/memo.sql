CREATE TABLE memo (
  num NUMBER PRIMARY KEY,
  id VARCHAR2(15) REFERENCES members(id) ON DELETE CASCADE,
  subject VARCHAR2(30),
  content VARCHAR2(3000),
  background VARCHAR2(100),
  color VARCHAR2(20),
  update_date VARCHAR2(14) DEFAULT TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS'),
);
select * from memo;
drop table memo;

