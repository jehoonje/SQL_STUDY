

-- Ʈ�����

CREATE TABLE student (
        id number primary key,
        name VARCHAR2(100),
        age NUMBER
);


INSERT INTO student VALUES (1, '��ö��', 15);
INSERT INTO student VALUES (2, 'ȫ�浿', 16);


ROLLBACK;
SELECT * FROM student;
TRUNCATE TABLE STUDENT;

COMMIT;

INSERT INTO student VALUES (3, '�����', 12);

ROLLBACK;


-- ���� ��ü
UPDATE tb_account
SET  balance = balance - 5000
WHERE name = '�ڿ���';

UPDATE tb_account
SET  balance = balance + 5000
WHERE name = '��ö��';

COMMIT;

DELETE FROM student;
