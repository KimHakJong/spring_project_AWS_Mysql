drop table com cascade constraints purge;

--답변글 테이블 
CREATE TABLE com(
num               NUMBER primary key,--댓글 번호        
id                varchar2(15) references members(id) on delete cascade,     
content           VARCHAR2 (200), 
reg_date          date,
comment_board_num NUMBER references boards(board_num) on delete cascade, --comm 테이블이 참조하는 보드 글번호
comment_re_lev    NUMBER(1) check(comment_re_lev in (0,1,2)), -- 원문이면 0 답글이면 1 답글의 답글은 2
comment_re_seq    NUMBER, -- 답변댓글의 순서
comment_re_ref    NUMBER -- 원문은 자신 댓글번호 , 답글이면 원문 댓글 번호
);

-- 게시판 글이 삭제되면 참조하는 댓글도 삭제됩니다.


drop sequence comm_seq; --시퀀스삭제
create sequence comm_seq; --시퀀스생성


   
    
    
  