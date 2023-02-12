/*
    OBJECT
    �����ͺ��̽��� �̷�� ������ ��������
    
    OBJECT ����
    - TABLE, USER, VIEW, SEQUENCE, INDEX, FUNCTION, TRIGGER, PROCEDURE ...
    
    <VIEW ��>
    SELECT���� �����صѼ� �ִ� ��ü
    (���� ���� �� SELECT���� VIEW�� �����صθ� �Ź� �� SELECT���� �ٽ� ����� �ʿ䰡 ����)
    -> ��ȸ�� �ӽ� ���̺� ���� ����(���� �����Ͱ� ��������� ����)
    
*/
--------------�ǽ�����-----------------------
-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻÿ�.
--����Ŭ���뱸��
SELECT
    emp_no,
    emp_name,
    dept_title,
    salary,
    national_name,
    job_name
FROM EMPLOYEE E, DEPARTMENT D, NATIONAL N, LOCATION L, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID AND D.LOCATION_ID = L.LOCAL_CODE AND N.NATIONAL_CODE = L.NATIONAL_CODE AND E.JOB_CODE = J.JOB_CODE
AND N.NATIONAL_NAME = '�ѱ�';

--ANSI����
SELECT
    emp_no,
    emp_name,
    dept_title,
    salary,
    national_name,
    job_name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
JOIN NATIONAL N ON N.NATIONAL_CODE = L.NATIONAL_CODE
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE N.NATIONAL_NAME = '�ѱ�';

/*
    1. VIEW ���� ���
    
    [ǥ����]
    CREATE VIEW ���
    AS ��������;
    
    CREATE OR REPLACE VIEW ���
    AS ��������;
    => �� ������ ������ �ߺ��� �̸��� �䰡 ���ٸ� ���Ӱ� �䰡 �����ǰ�
        ������ �ߺ��� �̸��� �䰡 �ִٸ� �ش� �� �̸��� �並 �����Ѵ�.(OR REPLACE�� ��������)
*/
CREATE VIEW VW_EMPLOYEE
AS 
    SELECT
        emp_no,
        emp_name,
        dept_title,
        salary,
        national_name,
        job_name
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN NATIONAL N ON N.NATIONAL_CODE = L.NATIONAL_CODE
    JOIN JOB J USING(JOB_CODE);
--insufficient privileges(���� ����� ����)
--���� KH������ �� ���������� ��� ������ �߻��Ѵ�.

--���Ѻο��� �����ڰ������� ����.
GRANT CREATE VIEW TO KH;

SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�Ϻ�';
-- �ٹ����� ���þ��̰� ������� ���, �̸�, ���޸�, ���ʽ�
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';
-- VW_EMPLOYEE�信 ���� BONUS��� �÷��� �������� �ʱ� ������ �����߻�.

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS 
    SELECT
        emp_id,
        emp_name,
        dept_title,
        salary,
        national_name,
        job_name,
        bonus
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
    JOIN LOCATION L ON D.LOCATION_ID = L.LOCAL_CODE
    JOIN NATIONAL N ON N.NATIONAL_CODE = L.NATIONAL_CODE
    JOIN JOB J USING(JOB_CODE);

SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    BONUS
FROM VW_EMPLOYEE;
-- �信 ���� Į���� ��ȸ�ؿ����� �Ѵٸ� ���Ӱ� ��������.

-- ��� ������ �������̺� => ���������� �����͸� �����ϰ� ������ ����.
-- (�ܼ��� �������� TEXT������ ����Ǿ��ִ�.)
-- ����) �� ������ ���� : USER_VIEWS;
SELECT * FROM USER_VIEWS;

/*
    �� �÷��� ��Ī�ο�
    �������� �κп� SELECT���� �Լ���, ���������� ����Ǿ� �ִ� ��� �ݵ��! ��Ī����.
*/

-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT ���� VIEW�� ����
-- VW_EMP_JOB
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT
    emp_id,
    emp_name,
    job_name AS "���޸�",
    DECODE(SUBSTR(emp_no, 8,1), '1', '��', '2', '��') AS "����" ,
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS "�ٹ����"
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- must name this expression with a column alias

SELECT
    EMP_NAME,
    ���޸�,
    ����,
    �ٹ����
FROM VW_EMP_JOB;

-- ��Ī �ο��ϴ� �Ǵٸ� ���(��, ����÷��� ���ؼ� ��Ī�� �ϳ��ϳ� �� ����ؾ���)
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����)
AS SELECT
    emp_id,
    emp_name,
    job_name,
    DECODE(SUBSTR(emp_no, 8,1), '1', '��', '2', '��'),
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

SELECT 
    ���, �����, �ٹ����
FROM VW_EMP_JOB
WHERE ���� = '��' AND �ٹ���� >= 20;

-- CREATE, ALTER, DROP
DROP VIEW VW_EMP_JOB;

SELECT * FROM USER_VIEWS;

-- INSERT, UPDATE, DELETE
/*
    * ������ �並 �̿��ؼ� DML ���
    
    ���ǻ��� : �並 ���ؼ� �����ϰ� �ȴٸ�, 
    ���� �����Ͱ� ����ִ� �������� ���̺�(���̽����̺�)���� ��������� ����ȴ�.
*/

CREATE VIEW VW_JOB
AS SELECT * FROM JOB;

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

--1. �信 INSERT
INSERT INTO VW_JOB
VALUES('J8', '����');

-- ���̽� ���̺��� JOB���� ���� INSERT �Ǿ���.
-- VW_JOB �信 JOB_CODE = J8�� JOB_NAME = '�˹�'�� ������Ʈ
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

/*
    DML�� ������ ��� : ���������� �̿��ؼ� ������ ���̺��� ������ ó������ �����ϰ��� �� ���.
    
    DML�� �ȵǴ� ��� : �ѹ��� ó���� �� ��� �Ұ���.
*/
-- 1) �信 ���ǵǾ� ���� ���� Į���� �����ϴ� ���.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME FROM JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME)
VALUES('J8', '����'); -- ���� �߻�

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7'; -- ���� �߻�

-- 2) �信 ���ǵǾ����� ���� Į���߿� ���̽����̺� �� NOT NULL ���������� ���ǵ� ���.
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAEM FROM JOB;

-- INSERT
INSERT INTO VW_JOB
VALUES('����'); -- JOB ���̺� (NULL, '����')�� ���ԵǷ��� �ߴ�(����)

--UPDATE(����)
UPDATE VW_JOB
SET JOB_NAME = '����'
WHERE JOB_NAME = '���';

ROLLBACK;

-- DELETE(������� ������ FOREIN KEY ���������� �ɷ��ְ�, �ڽ����̺��� �����Ѵٸ� �����߻�)
DELETE FROM VW_JOB
WHERE JOB_NAME = '�븮';

--3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ� �ִ� ���� ���.
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 AS "����" FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;

--INSERT
INSERT INTO VW_EMP_SAL VALUES(400, 'ȫ�浿', 3000000, 36000000);
--virtual column not allowed here(����Į���� INSERT�� ����� �� ����.)

-- UPDATE 
UPDATE VW_EMP_SAL
SET SALARY =  8000000
-- ���� = 96000000
--WHERE EMP_ID = '202'
WHERE ���� = 96000000 -- �� ����ü�� �߰��ϴ°��� �Ұ����ϳ�, �ش� Į���� ������������ ��밡���ϴ�.
;

-- 4) �׷��Լ� Ȥ�� GROUP BY���� ���Ե� ���.
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) AS "�հ�", FLOOR(AVG(SALARY)) AS "��ձ޿�" FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT * FROM VW_GROUPDEPT;

-- INSERT 
INSERT INTO VW_GROUPDEPT VALUES('D3', 8000000, 4000000); -- ����

-- UPDATE, DELETE ��� ��������.
UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE �հ� = 6986240;

-- 5) DISTINCT ������ ���Ե� ���.
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE FROM EMPLOYEE;

SELECT * FROM VW_DT_JOB;

--INSERT, UPDATE, DELETE ���ϵ� ������.

-- 6) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���.
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

SELECT * FROM VW_JOINEMP;

--INSERT
INSERT INTO VW_JOINEMP VALUES(300, 'ȫ�浿', '�ѹ���'); --����
-- cannot modify more than one base table through a join view

-- �̸� �����
UPDATE VW_JOINEMP
SET EMP_NAME = 'ȫ�浿'
WHERE EMP_ID = 200;

-- �μ� �����
UPDATE VW_JOINEMP
SET DEPT_TITLE = '������ȹ��'
WHERE EMP_ID = 200; -- ����
-- cannot modify a column which maps to a non key-preserved table(�����̵Ǵ� )

-- DELETE
DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '�ѹ���';

ROLLBACK;

-- VIEW���� ��� ������ �ɼǵ�
-- 1. OR REPLACE


--2. FORCE / NOFORCE �ɼ� : �������̺��� ��� VIEW�� ���� ������ �� �ְ� ���ִ� �ɼ�.
-- CREATE OR REPLACE NOFORCE (�⺻��)
CREATE FORCE VIEW V_FORCETEST
AS SELECT A, B, C FROM NOTHINGTEST;

SELECT * FROM V_FORCETEST; -- �����߻�

CREATE TABLE NOTHINGTEST(
    A NUMBER,
    B NUMBER,
    C NUMBER
);

SELECT * FROM V_FORCETEST; --����X

-- 3. WITH CHECK OPTION
--SELECT���� WHERE������ ����� �÷��� �������� ���ϰ� �ϴ� �ɼ�.
CREATE OR REPLACE NOFORCE VIEW V_CHECKOPTION
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH CHECK OPTION;
    
SELECT * FROM V_CHECKOPTION;

UPDATE V_CHECKOPTION
SET DEPT_CODE = 'D6'
WHERE EMP_ID = 215;
--view WITH CHECK OPTION where-clause violation
UPDATE V_CHECKOPTION
SET SALARY = 8000000
WHERE EMP_ID = 215; --����

ROLLBACK;
-- 4) WITH READ ONLY
-- VIEW ��ü�� �������� ���ϰ� �����ϴ� �ɼ�.
CREATE OR REPLACE VIEW V_READ
AS SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5' WITH READ ONLY;
    
UPDATE V_READ SET SALARY = 0;
-- cannot perform a DML operation on a read-only view