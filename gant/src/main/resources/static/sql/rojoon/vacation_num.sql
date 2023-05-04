DROP TABLE IF EXISTS vacation_num;

CREATE TABLE vacation_num(
    id varchar(15) references members(id) on delete cascade,
    vacation_num int
);

DELETE FROM vacation_num;

SELECT * FROM vacation_num;
