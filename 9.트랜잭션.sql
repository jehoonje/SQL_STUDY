

-- Æ®·£Àè¼Ç

CREATE TABLE student (
        id number primary key,
        name VARCHAR2(100),
        age NUMBER
);


INSERT INTO student VALUES (1, '±èÃ¶¼ö', 15);
INSERT INTO student VALUES (2, 'È«±æµ¿', 16);


ROLLBACK;
SELECT * FROM student;
TRUNCATE TABLE STUDENT;

COMMIT;

INSERT INTO student VALUES (3, 'µµ¿ì³Ê', 12);

ROLLBACK;


-- °èÁÂ ÀÌÃ¼
UPDATE tb_account
SET  balance = balance - 5000
WHERE name = '¹Ú¿µÈñ';

UPDATE tb_account
SET  balance = balance + 5000
WHERE name = '±èÃ¶¼ö';

COMMIT;

DELETE FROM student;
