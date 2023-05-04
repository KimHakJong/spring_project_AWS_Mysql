DROP TABLE IF EXISTS note_delete;
DROP SEQUENCE IF EXISTS note_delete_seq;

CREATE TABLE note_delete(
  delete_num INT AUTO_INCREMENT PRIMARY KEY,
  kind VARCHAR(4) CHECK(kind IN ('from','to')), 
  delete_table VARCHAR(3) CHECK(delete_table IN ('yes','no')), 
  delete_date VARCHAR(8)
);

ALTER TABLE note_delete AUTO_INCREMENT = 1;
