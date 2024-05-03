
-- ����� ���, �̸�, �μ���ȣ, �μ��� ��ȸ
SELECT
        emp_no, 
        emp_nm, 
        dept_cd
FROM tb_emp
;

SELECT
        dept_cd,
        dept_nm
FROM tb_dept
;   

-- �ΰ��� ���̺��� �����Ͱ� �ʿ��ҋ� => ����

SELECT
       tb_emp.emp_no, 
        tb_emp.emp_nm, 
        tb_dept.dept_cd,
        tb_dept.dept_nm
FROM tb_emp, tb_dept
WHERE tb_emp.dept_cd = tb_dept.dept_cd
;

SELECT
        emp_no, 
        emp_nm, 
        dept_cd
FROM tb_emp
;


-- ���� ���� �׽�Ʈ ������
CREATE TABLE TEST_A (
    id NUMBER(10) PRIMARY KEY
    , content VARCHAR2(200)
);
CREATE TABLE TEST_B (
    b_id NUMBER(10) PRIMARY KEY
    , reply VARCHAR2(100)
    , a_id NUMBER(10)
);



INSERT INTO TEST_A  VALUES (1, 'aaa');
INSERT INTO TEST_A  VALUES (2, 'bbb');
INSERT INTO TEST_A  VALUES (3, 'ccc');

INSERT INTO TEST_B  VALUES (1, '������', 1);
INSERT INTO TEST_B  VALUES (2, '������', 1);
INSERT INTO TEST_B  VALUES (3, '������', 2);
INSERT INTO TEST_B  VALUES (4, '������', 3);


-- ������ ������ ���ϱ� ����
-- Cartesian production : product ��� ��
-- Cross Join : ������ ��� ����� ���� ��Ī�Ͽ� ��ȸ

SELECT * FROM test_a;
SELECT * FROM test_b;


--INNER JOIN
--�� ���̺� ���� �����÷��� �̿��Ͽ�
-- ���谡 �ִ� �����͸� ��Ī�Ͽ� ����
SELECT
        *
FROM test_a, test_b
WHERE test_a.id = test_b.a_id
;



SELECT
      E.emp_no,
      E.emp_nm,
      E.addr,
      E.dept_cd,
      D.dept_cd,
      D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd   -- ���� ������ ���͸� inner
;


-- ����� �����ȣ�� ����� �ڰ������� ��ȸ
-- ����� �����ȣ�� ������ ����� �ڰ������� ��ȸ
SELECT
    E.emp_no,
    E.emp_nm,
    D.dept_nm,
    E.sex_cd,
    EC.certi_cd,
    C.certi_nm,
    EC.acqu_de
FROM tb_emp E 
JOIN tb_emp_certi EC 
ON E.emp_no = EC.emp_no
JOIN tb_certi C 
ON EC.certi_cd = C.certi_cd
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
WHERE D.dept_cd IN (100004, 100006)
        AND EC.acqu_de >= '20180101'
;


-- �μ����� �� �ڰ��� ��� ������ ��ȸ
SELECT
        dept_cd,
        dept_nm,
        COUNT(EC.certi_cd)
FROM tb_dept D, tb_emp.certi EC, tb_emp C
WHERE E.dept_cd = D. dept_cd
        AND e.emp_no + EC.emp_no;
GROUP BY D.dept_Ccd D.dept_nm
ORDER BY D.dept_cd
;

-- ���νÿ� ��� ����� �����ȣ, �����, �ּ�, �μ����� ��ȸ�ϰ� �ʹ�

SELECT
        E.emp_no,
        E.emp_nm,
        E.addr,
        E.dept_cd,
        D.dept_nm
FROM tb_emp E 
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
where E.addr LIKE '%����%'
--    AND E.dept_cd = D.dept_cd ���� ������ ON����  FROM�� �޸� ��� JOIN
    AND E.emp_nm LIKE '��%'
;



-- 1980���� ������� ���, �����, �μ���, 
-- �ڰ�����, ������� ��ȸ
SELECT
       E.emp_no, E.emp_nm , D.dept_nm, C.certi_nm, EC.acqu_de 
FROM tb_emp E 
JOIN tb_dept D 
ON E.dept_cd = D.dept_cd
JOIN tb_emp_certi EC
ON E.emp_no = EC.emp_no
JOIN tb_certi C
ON  C.certi_cd = EC.certi_cd
WHERE  E.birth_de BETWEEN '19800101' AND '19891231'
;
--������ �־�?(?)


-- INNER ������ �� ���̺� ����
-- ���������Ͱ� �ִ� ��쿡�� ���
-- � ���θ�ȸ���� �Ѱǵ� �ֹ����� ���� ���


 --               ��           ��           

-- SELECT [DISTINCT] { ���̸� .... } 
-- FROM  ���̺� �Ǵ� �� �̸�
-- JOIN  ���̺� �Ǵ� �� �̸�     (�߰� ���̺��� �ʿ��� ���)
-- ON    ���� ����
--WHERE ��ȸ ����
-- GROUP BY  ���� �׷�ȭ
-- HAVING    �׷�ȭ ����
-- ORDER BY  ������ �� [ASC | DESC];


-- ���� ������ �Ȱɸ� ī�׽þ� ���� �������


-- # CROSS JOIN

SELECT
    *
FROM test_a 
CROSS JOIN test_b     -- ũ�ν����� ������ ���� �� �ٵ�
;





-- # NATURAL JOIN
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� �ڵ����� ���������� �����ϴ� ����Դϴ�.
-- 2. ��, �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� �÷��� ã�� INNER������ �����մϴ�.
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, 
--    ALIAS�� ���̺���� �ڵ� ���� �÷� �տ� ǥ���ϸ� �ȵ˴ϴ�.
-- 4. SELECT * ������ ����ϸ�, ���� �÷��� ���տ��� �ѹ��� ǥ��˴ϴ�.
-- 5. ���� �÷��� n�� �̻��̸� ���� ������ n���� ó���˴ϴ�.

-- ��� ���̺�� �μ� ���̺��� ���� (���, �����, �μ��ڵ�, �μ���)

SELECT 
   -- A.emp_no, A.emp_nm, dept_cd, B.dept_nm
   *
   -- NATURAL JOIN�� �����÷� �ѹ��� ����ϱ� ���� �ĺ��� B�̷��� ����
FROM tb_emp A
NATURAL JOIN tb_dept B
-- ON A.dept_cd = B.dept_cd
;




SELECT
    *
FROM test_a  A
INNER JOIN test_b    B 
ON A.id = B.a_id
;

SELECT
    *
FROM test_a  A
NATURAL JOIN test_b    B 

;



