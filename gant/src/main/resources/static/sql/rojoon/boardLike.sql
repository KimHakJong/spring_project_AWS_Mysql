CREATE TABLE boardLike (
    id VARCHAR(15) REFERENCES members(id) ON DELETE CASCADE,
    board_num INT(5) REFERENCES boards(board_num) ON DELETE CASCADE,
    like_check VARCHAR(5) CHECK (like_check IN ('true', 'false'))
);

DROP TABLE IF EXISTS boardLike;
