drop table board_deletefile purge;

CREATE TABLE board_deletefile(
board_file  VARCHAR2(50), 
reg_date    date default sysdate      
);


create or replace trigger save_board_deletefile
after update or delete
on boards
 for each row
 begin
 if(:old.board_file is not null) then
  if(:old.board_file != :new.board_file or :new.board_file is null ) then
   insert into board_deletefile
   (board_file)
   values(:old.board_file);
  end if;
 end if;
end;
/




    
   