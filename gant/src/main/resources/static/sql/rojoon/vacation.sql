
DROP TABLE IF EXISTS vacation;


CREATE TABLE vacation (
    id VARCHAR(15),
    paper_num INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    vacation_date INT,
    division VARCHAR(30),
    emergency VARCHAR(13),
    details VARCHAR(2000),
    reference_person VARCHAR(500),
    `condition` ENUM('승인','거절','대기'),
    write_date DATE DEFAULT CURRENT_DATE,
    classification VARCHAR(30) DEFAULT 'leave request',
    FOREIGN KEY (id) REFERENCES members(id) ON DELETE CASCADE
);


