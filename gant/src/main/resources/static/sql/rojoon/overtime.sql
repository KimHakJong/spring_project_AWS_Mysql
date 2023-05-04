DROP TABLE IF EXISTS overtime;

CREATE TABLE overtime (
    id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE, --id
    paper_num INT PRIMARY KEY, -- document number
    over_time VARCHAR(8), -- overtime
    overtime_content VARCHAR(2000), -- work content
    overtime_reason VARCHAR(2000), --reason
    overtime_date VARCHAR(8), --workday
    reference_person VARCHAR(500), -- Display in the form of reference (id,id,id..)
    `condition` VARCHAR(8) CHECK (`condition` IN ('Approved', 'Rejected', 'Waiting')), -- Payment status
    write_date VARCHAR(10) DEFAULT DATE_FORMAT(NOW(), '%Y/%m/%d') NOT NULL, --write date
    classification VARCHAR(30) DEFAULT 'overtime application' --document type
);
