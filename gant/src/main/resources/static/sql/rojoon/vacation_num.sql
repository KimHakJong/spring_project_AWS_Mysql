drop table vacation_num cascade constraints purge;


CREATE TABLE vacation_num(
id	             varchar2(15) references members(id) on delete cascade, --	아이디
vacation_num	 number	--휴가갯수
);

delete from vacation_num;

select * from vacation_num;

