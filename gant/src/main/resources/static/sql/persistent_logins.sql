drop table persistent_logins cascade constraints purge;

create table persistent_logins(
username varchar(64) not null,
series   varchar(64) PRIMARY KEY, --���,�������� ��Ű�� ������ ������
token    varchar(64) not null, -- �������� ������ �ִ� ��Ű�� ���� ������ ������
last_used timestamp not null --���� �ֽ� �ڵ� �α��� �ð�
);


