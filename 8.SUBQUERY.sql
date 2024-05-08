-- ������ ���� 
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�  -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH A.direct_manager_emp_no IS NULL
 START WITH A.EMP_NO = '1000000037'
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no
ORDER SIBLINGS BY A.emp_no DESC
;

SELECT
    emp_no,
    emp_nm,
    direct_manager_emp_no
FROM tb_emp
;


-- ������ ���� 
-- START WITH : ������ ù �ܰ踦 ��� ������ �������� ���� ����
-- CONNECT BY PRIOR �ڽ� = �θ�  -> ������ Ž��
-- CONNECT BY �ڽ� = PRIOR �θ�  -> ������ Ž��
-- ORDER SIBLINGS BY : ���� ���������� ������ ����.
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
--START WITH A.direct_manager_emp_no IS NULL
 START WITH A.EMP_NO = '1000000037'
CONNECT BY PRIOR A.direct_manager_emp_no = A.emp_no
ORDER SIBLINGS BY A.emp_no DESC
;


-- # �������� : SQL�ȿ� SQL�� ���Ե� ����
-- ## ������ �������� : ��ȸ ����� 1�� ����

-- �μ��ڵ尡 100004���� �μ��� ����� ���� ��ȸ
SELECT
        emp_no,
        emp_nm,
        dept_cd
FROM tb_emp
WHERE dept_cd = '100004'
;

-- �̳��� ���� �μ��� ��� ������� ��ȸ
-- �̳���� �μ��ڵ尡 ����̳�
-- �� �μ��ڵ�� ��� ����� ��ȸ�ض�
SELECT
        emp_no,
        emp_nm,
        dept_cd
FROM tb_emp
WHERE dept_cd =  (
        SELECT
                dept_cd
        FROM tb_emp
        WHERE emp_nm = '�̳���'
)        
;


SELECT
        dept_cd
FROM tb_emp
WHERE emp_nm = '�̳���'
;



-- ����̸��� �̰����� ����� ���� �ִ� �μ��� ������� ��ȸ
-- ������ �񱳿�����(=, <>, >, >=, <, <=)�� ������ ���������θ� ���ؾ� ��.
SELECT
        emp_no,
        emp_nm,
        dept_cd
FROM tb_emp
WHERE dept_cd =  (
        SELECT
                dept_cd
        FROM tb_emp
        WHERE emp_nm = '�̰���'
)        
;

-- 20200525�� ���� �޿��� ȸ����ü�� 20200525�� 
-- ��ü ��� �޿����� ���� ������� ����
-- (���, �̸�, �޿�������, �����޿��׼�) ��ȸ



-- ȸ����ü 2020525 ��ձ޿� ���
-- �� ��պ��� ���� ��� ��ȸ

SELECT
        E.emp_no,
        E.emp_nm,
        S.pay_de,
        S.pay_amt

FROM tb_emp E
JOIN tb_sal_his S
ON E.emp_no = S.emp_no
WHERE S.pay_de = '20200525'
      AND  S.pay_amt >= (
      SELECT
         AVG(pay_amt)
         FROM tb_sal_his
         WHERE pay_de = '20200525'
)
;

-- 20200525 ȸ����ü �޿����
SELECT
        AVG(pay_amt)
FROM tb_sal_his
WHERE pay_de = '20200525'
;


-- # ������ ��������
-- ���������� ��ȸ �Ǽ��� 0�� �̻��� ��
-- ## ������ ������
-- 1. IN : ���������� �������� �������� ����߿� �ϳ��� ��ġ�ϸ� ��
--    ex )  salary IN (200, 300, 400)
--            250 ->  200, 300, 400 �߿� �����Ƿ� false
-- 2. ANY, SOME : ���������� �������� ���������� �˻���� �� �ϳ� �̻� ��ġ�ϸ� ��
--    ex )  salary > ANY (200, 300, 400)
--            250 ->  200���� ũ�Ƿ� true
-- 3. ALL : ���������� �������� ���������� �˻������ ��� ��ġ�ϸ� ��
--    ex )  salary > ALL (200, 300, 400)
--            250 ->  200���ٴ� ũ���� 300, 400���ٴ� ũ�� �����Ƿ� false
-- 4. EXISTS : ���������� �������� ���������� ��� �� 
--				�����ϴ� ���� �ϳ��� �����ϸ� ��




SELECT
        emp_no,
        emp_nm,
        dept_cd
FROM tb_emp
WHERE dept_cd IN  (
        SELECT
                dept_cd
        FROM tb_emp
        WHERE emp_nm = '�̰���'
)        
;



-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ�
-- ����� �����ȣ�� ����̸��� �ش� ����� �ѱ������ͺ��̽���������� 
-- �߱��� �ڰ��� ������ ��ȸ

SELECT
        E.emp_no,
        E.emp_nm,
        COUNT(S.certi_cd) "�ڰ��� ����"
FROM tb_emp E

INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd IN (100001, 100002, 100003, 100004, 100005, 100006)
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;


SELECT
        E.emp_no,
        E.emp_nm,
        COUNT(S.certi_cd) "�ڰ��� ����"
FROM tb_emp E

INNER JOIN tb_emp_certi S
ON E.emp_no = S.emp_no
WHERE S.certi_cd IN (
                            SELECT certi_cd
                            FROM tb_certi
                            WHERE issue_insti_nm = '�ѱ������ͺ��̽������')
GROUP BY E.emp_no, E.emp_nm
ORDER BY E.emp_no
;


SELECT
    COUNT(DISTINCT emp_no | | emp_nm)
FROM tb_emp
;



-- # ���� �÷� ��������
--  : ���������� ��ȸ �÷��� 2�� �̻��� ��������

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� 
-- ���� �������� ����� �̸� ������ϰ� �μ��ڵ带 ��ȸ

SELECT 
    A.emp_no, A.emp_nm, A.birth_de, A.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                        SELECT 
                            dept_cd, MIN(birth_de)
                        FROM tb_emp
                        GROUP BY dept_cd
                        HAVING COUNT(*) >= 2
                    )
ORDER BY A.emp_no
;


-- �ζ��� �� ��������
-- FROM���� ���� ��������

-- �� ����� ����� �̸��� ��ձ޿������� �˰� ����
SELECT
        E.emp_no,
        E.emp_nm,
        AVG(S.pay_amt)
FROM tb_emp E
JOIN (
    SELECT emp_no, AVG(pay_amt) AS pay_avg
    FROM tb_sal_his
    GROUP BY emp_no
    ) S
ON E.emp_no = S.emp_no
ORDER BY E.emp_no
;


-- ��Į�� �������� (SELECT, INSERT, UPDATE���� ���� ��������)

-- ����� ���, �����, �μ���, �������, �����ڵ带 ��ȸ

SELECT
        E.emp_no,
        E.emp_nm,
    --   (SELECT dept_nm FROM tb_dept) D WHERE E.dept_cd = d.dept_cd) AS depta nm,
        E.birth_de,
        E.sex_cd
     --   D.dept_nm,
     --   E.birth_de,
    --    E.sex_cd
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd

;
-- EXISTS�� : ���������� �������� ���������� ��� �� 
--           �����ϴ� ���� �ϳ��� �����ϸ� ��
-- �ּҰ� ������ �������� �ٹ��ϰ� �ִ� �μ������� ��ȸ (�μ��ڵ�, �μ���)

SELECT
        dept_cd,
        dept_nm
FROM tb_dept D
WHERE EXISTS (
               SELECT
                D.dept_cd
                FROM tb_emp E
                WHERE addr LIKE '%����%'
                         AND D.dept_cd = E.dept_cd
)
;

