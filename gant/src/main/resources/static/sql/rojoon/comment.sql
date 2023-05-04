DROP TABLE IF EXISTS com;

CREATE TABLE com (
  num INT PRIMARY KEY AUTO_INCREMENT,
  id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
  content VARCHAR(200),
  reg_date DATE,
  comment_board_num INT REFERENCES boards(board_num) ON DELETE CASCADE,
  comment_re_lev TINYINT(1) CHECK(comment_re_lev IN (0,1,2)),
  comment_re_seq INT,
  comment_re_ref INT
);


-- 시퀀스 대신 AUTO_INCREMENT 사용
ALTER TABLE com MODIFY COLUMN num INT AUTO_INCREMENT PRIMARY KEY;


   
    
    
  