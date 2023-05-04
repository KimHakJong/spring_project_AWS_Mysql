DROP TABLE IF EXISTS overtime_condition;

CREATE TABLE overtime_condition(
paper_num INT REFERENCES overtime(paper_num) ON DELETE CASCADE,
reference_person VARCHAR(15) REFERENCES members(id),
condition ENUM('승인', '거절', '대기') -- 결재상태
);
