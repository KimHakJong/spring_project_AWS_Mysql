create table project (
p_no NUMBER primary key,
p_hostid VARCHAR2(15) references members(id) on delete cascade,
p_name VARCHAR2(50),
p_sdate VARCHAR2(10),
p_edate VARCHAR2(10),
p_mids VARCHAR2(100),
p_mnames VARCHAR2(100),
p_content VARCHAR2(1000),
p_situation VARCHAR2(30),
p_percent NUMBER(3)
);
select * from project;
drop table project;