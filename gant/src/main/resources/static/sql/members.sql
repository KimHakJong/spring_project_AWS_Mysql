CREATE TABLE members (
  admin VARCHAR2(5) CHECK (admin IN ('true','false')),
  id VARCHAR2(15) PRIMARY KEY,
  password VARCHAR2(60),  --암호화를 하면 password가 60자 필요합니다.
  name VARCHAR2(15),
  jumin VARCHAR2(14),
  phone_num VARCHAR2(13),
  email VARCHAR2(30),
  post NUMBER(5),
  address VARCHAR2(100),
  department VARCHAR2(15),
  position VARCHAR2(10),
  profileimg VARCHAR2(30),
  hiredate VARCHAR2(8) DEFAULT (TO_CHAR(SYSDATE, 'YYYYMMDD')) NOT NULL,
  auth VARCHAR2(50) NOT NULL --회원의 role(권한)을 저장하는 곳으로 기본값은 'ROLE_MEMBER' 입니다.
);

select * from members;

