drop table boards cascade constraints purge;


CREATE TABLE BOARDS(
BOARD_NUM        NUMBER PRIMARY KEY,           --글 번호
BOARD_NAME       VARCHAR2(30) references members(id) on delete cascade,  --작성자 
BOARD_PASS       VARCHAR2 (30),    --비밀번호
BOARD_SUBJECT    VARCHAR2 (300),   --제목
BOARD_CONTENT    VARCHAR2 (4000), --내용
BOARD_FILE      VARCHAR2(50),     --침부될 파일 명(가공)
BOARD_ORIGINAL  VARCHAR2(50),     --침부파일명
BOARD_RE_REF     NUMBER,    -- 답변 글 작성시 참조되는 글의 번호
BOARD_RE_LEV     NUMBER,    -- 답변 글의 깊이
BOARD_RE_SEQ     NUMBER,    -- 답변 글의 순서 
BOARD_READCOUNT  NUMBER,    -- 글이 조회수
BOARD_DATE       VARCHAR2(10) default to_char(SYSDATE, 'YYYY/MM/DD') not null, -- 글작성날짜
BOARD_LIKE       NUMBER, -- 좋아요수
BOARD_NOTICE     VARCHAR2(5) check (BOARD_NOTICE in ('true','false')), -- 공지사항글이면 true 아니면 false
fontColor        VARCHAR2(15), -- 게시판 글 색
fontSize         VARCHAR2(15), -- 게시판 글 사이즈
fontWeight       NUMBER   -- 게시판 글 굵기
);







    
   





    
   