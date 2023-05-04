DROP TABLE IF EXISTS board_deletefile;

CREATE TABLE board_deletefile (
    board_file VARCHAR(50),
    reg_date DATE DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$
CREATE TRIGGER save_board_deletefile
AFTER UPDATE OR DELETE
ON boards
FOR EACH ROW
BEGIN
    IF OLD.board_file IS NOT NULL THEN
        IF OLD.board_file != NEW.board_file OR NEW.board_file IS NULL THEN
            INSERT INTO board_deletefile (board_file)
            VALUES (OLD.board_file);
        END IF;
    END IF;
END$$
DELIMITER ;




    
   