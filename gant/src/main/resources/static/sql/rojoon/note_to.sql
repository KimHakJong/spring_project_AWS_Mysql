DROP TABLE IF EXISTS note_to;

CREATE TABLE note_to(
note_num INT AUTO_INCREMENT PRIMARY KEY,
id VARCHAR(15) REFERENCES members(id),
to_id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
read_check ENUM('true', 'false'),
subject VARCHAR(300),
content VARCHAR(4000),
write_date DATE DEFAULT CURRENT_DATE,
delete_num INT REFERENCES note_delete(delete_num) ON DELETE CASCADE,
file_num INT
);
