drop table persistent_logins cascade constraints purge;

create table persistent_logins(
username varchar2(64) not null,
series   varchar2(64) PRIMARY KEY, --���,�������� ��Ű�� ������ ������
token    varchar2(64) not null, -- �������� ������ �ִ� ��Ű�� ���� ������ ������
last_used timestamp not null --���� �ֽ� �ڵ� �α��� �ð�
);


