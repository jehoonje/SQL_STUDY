
-- 사원의 사번, 이름, 부서번호, 부서명 조회
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

-- 두가지 테이블에서 데이터가 필요할떄 => 조인

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


-- 조인 기초 테스트 데이터
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

INSERT INTO TEST_B  VALUES (1, 'ㄱㄱㄱ', 1);
INSERT INTO TEST_B  VALUES (2, 'ㄴㄴㄴ', 1);
INSERT INTO TEST_B  VALUES (3, 'ㄷㄷㄷ', 2);
INSERT INTO TEST_B  VALUES (4, 'ㄹㄹㄹ', 3);


-- 조인의 원리는 곱하기 연산
-- Cartesian production : product 라고 함
-- Cross Join : 가능한 모든 경우의 수를 매칭하여 조회

SELECT * FROM test_a;
SELECT * FROM test_b;


--INNER JOIN
--두 테이블 간에 연관컬럼을 이용하여
-- 관계가 있는 데이터를 매칭하여 조인
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
WHERE E.dept_cd = D.dept_cd   -- 같은 조건을 필터링 inner
;


-- 사원의 사원번호와 취득한 자격증명을 조회
-- 사원의 사원번호와 사원명과 취득한 자격증명을 조회
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


-- 부서별로 총 자격증 취득 개수를 조회
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

-- 용인시에 사는 사원의 사원번호, 사원명, 주소, 부서명을 조회하고 싶다

SELECT
        E.emp_no,
        E.emp_nm,
        E.addr,
        E.dept_cd,
        D.dept_nm
FROM tb_emp E 
JOIN tb_dept D
ON E.dept_cd = D.dept_cd
where E.addr LIKE '%용인%'
--    AND E.dept_cd = D.dept_cd 조인 조건을 ON으로  FROM에 콤마 대신 JOIN
    AND E.emp_nm LIKE '김%'
;