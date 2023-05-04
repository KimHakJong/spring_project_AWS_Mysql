DROP TABLE IF EXISTS note CASCADE;

DROP SEQUENCE IF EXISTS note_seq;

CREATE SEQUENCE note_seq;

CREATE TABLE note(
    note_num INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
    to_id VARCHAR(300),
    subject VARCHAR(300),
    content VARCHAR(4000),
    write_date VARCHAR(10) DEFAULT DATE_FORMAT(NOW(), '%Y/%m/%d'),
    delete_num INT REFERENCES note_delete(delete_num) ON DELETE CASCADE,
    file_num INT
);
