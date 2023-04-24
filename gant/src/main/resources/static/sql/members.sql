CREATE TABLE members (
  admin VARCHAR(5) CHECK (admin IN ('true','false')),
  id VARCHAR(15) PRIMARY KEY,
  password VARCHAR(60),
  name VARCHAR(15),
  jumin VARCHAR(14),
  phone_num VARCHAR(13),
  email VARCHAR(30),
  post INT(5),
  address VARCHAR(100),
  department VARCHAR(15),
  position VARCHAR(10),
  profileimg VARCHAR(30),
  hiredate VARCHAR(8) DEFAULT (DATE_FORMAT(CURRENT_DATE, '%Y%m%d')) not null,
  auth VARCHAR(50) NOT NULL
);

select * from members;

