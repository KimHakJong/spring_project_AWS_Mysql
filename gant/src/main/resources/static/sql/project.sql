CREATE TABLE project (
  p_no INT primary key,
  p_hostid VARCHAR(15) references members(id) on delete cascade,
  p_name VARCHAR(50),
  p_sdate VARCHAR(10),
  p_edate VARCHAR(10),
  p_mids VARCHAR(100),
  p_mnames VARCHAR(100),
  p_content VARCHAR(1000),
  p_situation VARCHAR(30),
  p_percent INT(3)
);

select * from project;
drop table project;