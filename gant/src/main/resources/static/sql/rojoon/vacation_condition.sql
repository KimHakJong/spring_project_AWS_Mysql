DROP TABLE IF EXISTS vacation_condition;

CREATE TABLE vacation_condition (
    paper_num INT,
    reference_person VARCHAR(15),
    `condition` ENUM('승인','거절','대기'),
    FOREIGN KEY (paper_num) REFERENCES vacation(paper_num) ON DELETE CASCADE,
    FOREIGN KEY (reference_person) REFERENCES members(id) ON DELETE CASCADE
);

