CREATE TABLE filebox (
  p_no INT REFERENCES project(p_no) ON DELETE CASCADE,
  file_num INT PRIMARY KEY,
  id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
  upload_date DATE DEFAULT (DATE_FORMAT(NOW(),'%Y/%m/%d'))
);

drop table filebox cascade constraints purge