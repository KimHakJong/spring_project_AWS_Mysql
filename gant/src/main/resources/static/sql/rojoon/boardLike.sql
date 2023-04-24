drop table boardLike cascade constraints purge;

CREATE TABLE boardLike(
id  varchar2(15) references members(id) on delete cascade, --아이디
board_num number(5) references boards(board_num) on delete cascade, --boards에 게시글 번호
like_check varchar(5) check (like_check in ('true','false')) -- true면 추천 체크 ,false면 미체크/취소 
);

select * from boardLike;