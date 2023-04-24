drop table todolist cascade constraints purge;

create table todolist(
board_num number primary key,
p_no number references project(p_no) on delete cascade,
board_id varchar2(30) references members(id) on delete cascade, --현재 로그인아이디 
board_r_id varchar2(200), --받는사람 아이디 
board_subject varchar2(300),
board_content varchar2(4000),
deadline varchar2(20),
state varchar2(10) --현재 상태
);


    
   





    
   