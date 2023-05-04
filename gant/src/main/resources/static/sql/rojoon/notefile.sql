DROP SEQUENCE IF EXISTS notefile_seq;
CREATE SEQUENCE notefile_seq;

DROP TABLE IF EXISTS notefile;

CREATE TABLE notefile(
    file_num INT AUTO_INCREMENT PRIMARY KEY,
    original_filename VARCHAR(50), -- original filename
    extension VARCHAR(50), -- extension
    save_folder VARCHAR(1000) -- Save path (file path + duplicate prevention file name)
);