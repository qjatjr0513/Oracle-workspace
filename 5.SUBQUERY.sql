/*
    <SUBQUERY (��������)>
    
    �ϳ��� �ֵ� SQL(SELECT, CREATE, INSERT, UPDATE, ...)�ȿ� ���Ե� �� �ϳ��� SELECT ��.
    
    ���� SQL���� ���ؼ� '����' ������ �ϴ� SELECT��.
    -> �ַ� ������(WHERE, HAVING)�ȿ��� ���δ�.
    
*/
--���ö����� ���� �μ��� �����.
-- 1) ���ö����� �μ���ȣ ã��.
SELECT
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME = '���ö';

--2) �μ��ڵ尡 'D9'�λ�� ã��
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
--�δܰ� ��ġ��
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '���ö');

--��ü ����� ��� �޿����� �� ���� �޿��� �ް� �ִ� ������� ���, �̸� �����ڵ� ��ȸ.

--1) �켱������ ��ü ����� ��� �޿��� ���ϱ�
SELECT
    FLOOR(AVG(SALARY))
FROM EMPLOYEE;
-- 2) �޿��� "��ձ޿�"�̻��� ����� ��ȸ
SELECT
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE
WHERE SALARY >= 3047662; 
--�δܰ踦 �ϳ��� ���������� ��ġ��
SELECT
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE); 

/*
    �������� ����
    ���������� ������ ������� ���� � �̳Ŀ� ���� �з���.
    - ������ (���Ͽ�) �������� : ���������� ������ ������� ������ 1���϶�(��ĭ�� �÷������� ���� ��)
    - ������ (���Ͽ�) �������� : ���������� ������ ������� ���� ���� ��
    - (������) ���߿� �������� : ���������� ������ ������� ���� ���϶�
    - ������ ���߿� �������� : ���������� ������ ������� ������ ������ �϶�
    
    -> ���������� ����(���� ���)�� ���� ��� ������ �����ڰ� �޶���.
*/

/*
    1. ������ (���Ͽ�) �������� (SINGLE ROW SUBQUERY)
    ���������� ��ȸ ������� ������ 1���϶�
    
    �Ϲ� ������ ��밡��(=, !=, >=, <=, > <, ..)
*/
-- 1. �� ������ ��� �޿����� �� ���� �޴� ������� �����, �����ڵ�, �޿� ��ȸ
SELECT
    emp_name, 
    job_code,
    salary
FROM EMPLOYEE
WHERE SALARY < (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

-- 2. ���� �޿��� �޴� ����� ���, �����, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT
    emp_id,
    emp_name,
    job_code,
    salary,
    hire_date
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--3. ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- ���ö ����� �޿����� �� ���� �޴� ������� ���, �̸�, �μ���, �޿� ��ȸ
--����Ŭ ���� ����.
SELECT
    emp_id,
    emp_name,
    dept_title,
    salary
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '���ö')
AND DEPT_CODE = DEPT_ID(+);

--ANSI ����
SELECT
    emp_id,
    emp_name,
    dept_title,
    salary
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '���ö');

-- �μ��� �޿� ���� ���� ū �μ� �ϳ����� ��ȸ �μ��ڵ�, �μ��� �޿��� ��.
-- 1) �� �μ��� �޿� �� ���ϱ� + ���� ū ���� ã��.
SELECT
    dept_code,
    SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT
    MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 1�ܰ踦 ���� �������� �����. 
SELECT 
    dept_code,
    dept_title,
    SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))FROM EMPLOYEE GROUP BY DEPT_CODE);

/*
    2. ������ ��������(MULTI ROW SUBQUERY)
    ���������� ��ȸ ������� �������� ���
    
    -IN(10, 20, 30) �������� : �������� ����� �߿��� �ϳ��� ��ġ�ϴ� ���� �ִٸ� / NOT IN ���ٸ�
    - > ANY(10, 20, 30) �������� : �������� ����� �߿��� "�ϳ���" Ŭ ���
                                ��, �������� ����� �߿��� ���� ���� ������ Ŭ ���
    - < ANY(10, 20, 30) �������� : �������� ����� �߿��� "�ϳ���" ���� ���
                            ��, �������� ����� �߿��� ���� ū ������ ���� ���
                            
    - > ALL (10, 20, 30) �������� : �������� ������� "���"�� ���� Ŭ ���
                                    ��, �������� ����� �߿��� ���� ū ������ Ŭ ���
    - < ALL (10, 20, 30) �������� : �������� ������� "���"�� ���� ���� ���
                                ��, �������� ����� �߿��� ���� ���� ������ �� ���� ���
*/
-- �� �μ��� �ְ� �޿��� �޴� ����� �̸�, �����ڵ�, �޿���ȸ.
-- 1) �� �μ����� �ְ�޿� ��ȸ(������, ���Ͽ�)
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) ���� �޿��� �������� ����� ��ȸ
SELECT
    *
FROM EMPLOYEE
 WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-- ���� �� �������� �ϳ��� ��ġ��
SELECT
    *
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)FROM EMPLOYEE GROUP BY DEPT_CODE);

-- 1. ������ �Ǵ� ����� ����� ���� �μ��� ������� ��ȸ�Ͻÿ� (�����, �μ��ڵ�, �޿�)
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('������', '�����'));
-- 2. �̿��� �Ǵ� �ϵ��� ����� ���� ������ ������� ��ȸ�Ͻÿ�(�����, �����ڵ�, �μ��ڵ�, �޿�)
SELECT
    emp_name,
    job_code,
    dept_code,
    salary
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '�̿���' OR EMP_NAME = '�ϵ���');

-- ��� < �븮 < ���� < ���� < ����
-- �븮 �����ӿ��� �ұ��ϰ�, ���� ������ �޿����� ���� �޴� ����� ��ȸ(���, ���޸�, �޿�)
-- 1) ���� ������ �޿��� ��ȸ -> ������, ���Ͽ�
SELECT
    salary
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE 
WHERE J.JOB_NAME = '����';
-- 2) �� �޿��麸�� "�ϳ���" ���� �޿��� �ִٸ� �� ������ ��ȸ.(�븮���޸�)
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E
LEFT JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '�븮' AND
SALARY >= ANY(2200000, 2500000, 3760000);

-- 3)�� �� �ܰ踦 ��ġ��
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E
LEFT JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '�븮' AND
SALARY >= ANY(SELECT salary FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE WHERE J.JOB_NAME = '����');

-- ���� �����ӿ��� �ұ��ϰ� "���" ���������� �޿����ٵ� �� ���� �޴� ���� ��ȸ(���, �̸�, ���޸�, �޿�)
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����' AND SALARY >= ALL(SELECT salary FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME = '����');

SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '����' AND SALARY > ALL(SELECT salary FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME = '����');

/*
    3. (������) ���߿� ��������.
    �������� ��ȸ ����� ���� ����������, ������ �÷��� ������ �������� ���.
*/
--������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش�Ǵ� ����� ��ȸ(�����, �μ��ڵ�, �����ڵ�, �����)
-- 1) ������ ����� �μ��ڵ�� �����ڵ� ���� ��ȸ.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- 2) �μ��ڵ尡 D5�̰�, �����ڵ尡 J5�� ������� ��ȸ.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE = 'J5';

-- 3) �� ������� ������ ������ �������������� ��ġ��
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT dept_code FROM EMPLOYEE WHERE EMP_NAME = '������')
AND JOB_CODE = (SELECT job_code FROM EMPLOYEE WHERE EMP_NAME = '������');

-- 4) ������ ���߿� ���������� �ٲٱ�.
-- [ǥ����] (���� ��� �÷�1, ���� ��� �÷�2 ) = (���� ��1, ���� �� 2 => �������� �������� ����)
-- ���� ���� ������ ���������.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '������');

-- �ڳ��� ����� ���� �����ڵ�, ���� �������� ���� ������� ���, �̸�, �����ڵ�, ������ ��ȸ.
-- ���߿� ���������� �ۼ�
SELECT 
    emp_id,
    emp_name,
    job_code,
    manager_id
FROM EMPLOYEE
WHERE(JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '�ڳ���');

/*
    4. ������ ���� �� 
    �������� ��ȸ ����� ������ �������� ���
*/
-- �� ���޺� �ּұ޿��� �޴� ����� ��ȸ(���, �̸�, �����ڵ�, �޿�)
--1) �� ���޺� �ּ� �޿��� ��ȸ.
SELECT
    job_code,
    MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) ���� ��ϵ��� ��ġ�ϴ� ���.
-- 2-1) OR ������ Ȱ��.
SELECT
    emp_id, 
    emp_name,
    job_code,
    salary
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) = ('J2', 3700000)
    OR (JOB_CODE, SALARY) = ('J7', 1380000)
    OR (JOB_CODE, SALARY) = ('J3', 3400000)
    OR (JOB_CODE, SALARY) = ('J6', 2000000)
    OR (JOB_CODE, SALARY) = ('J5', 2200000)
    OR (JOB_CODE, SALARY) = ('J1', 8000000)
    OR (JOB_CODE, SALARY) = ('J4', 1550000);
--2) IN ������ Ȱ��
SELECT
    emp_id, 
    emp_name,
    job_code,
    salary
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT job_code, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);

--�� �μ��� �ְ�޿��� �޴� ����� ��ȸ(���, �̸�, �μ��ڵ�, �޿�)
-- �μ��� ���� ��� ���� �̶�� �μ��� �����ؼ� ��ȸ
-- 1) �� �μ��� �ְ� �޿� ��ȸ
SELECT 
    NVL(DEPT_CODE, '����'),
    MAX(SALARY) 
FROM EMPLOYEE 
GROUP BY DEPT_CODE;

--2) ���� ������ �����ϴ� ��� �߸���
SELECT
    emp_id,
    emp_name,
    NVL(dept_code, '����'),
    salary
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '����'), SALARY) IN(
    ('����', 2890000),
    ('D1', 3660000), 
    ('D9', 8000000), 
    ('D5', 3760000), 
    ('D6', 3900000), 
    ('D2', 2490000), 
    ('D8', 2550000)
);
    
-- 3) ������ ���߿� ���������� ����
SELECT
    emp_id,
    emp_name,
    NVL(dept_code, '����'),
    salary
FROM EMPLOYEE
WHERE (NVL(dept_code, '����'), SALARY) IN(SELECT NVL(DEPT_CODE, '����'), MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);

/*
    5. �ζ��� ��(INLINE VIEW)
    FROM���� ���������� �����ϴ°�.
    
    ���������� ������ ���(RESULTSET)�� ���̺� ��� ����ϴ¹��.
*/
--���ʽ� ���� ������ 3000���� �̻��� ������� ���, �̸�, ���ʽ����� ����, �μ��ڵ带 ��ȸ.
SELECT
    emp_id,
    emp_name,
    (salary+(salary*NVL(bonus,0))) *12 AS "���ʽ� ���� ����",
    dept_code
FROM EMPLOYEE
WHERE (salary+(salary*NVL(bonus,0))) *12 >= 30000000;
--�ζ��� �並 ��� : ����� ��󳻱�(���ʽ����Կ����� 3000���� �̻��� ������߿�)
SELECT
    emp_name
FROM (
        SELECT
            emp_id,
            emp_name,
            (salary+(salary*NVL(bonus,0))) *12 AS "���ʽ� ���� ����",
             dept_code,
             job_code
        FROM EMPLOYEE
        WHERE (salary+(salary*NVL(bonus,0))) *12 >= 30000000
    )B
WHERE B.DEPT_CODE IS NULL;
--WHERE B.JOB_CODE = 'J1';

--�ζ��κ並 �ַ� ����ϴ� ��
-- TOP-N �м� : �����ͺ��̽� �� �ִ� �ڷ��� �ֻ��� N���� �ڷḦ �������� ����ϴ� ���.

-- �� �����߿� �޿��� ������� ���� 5��(����, �����, �޿�)
-- *ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT
    ROWNUM,
    emp_name,
    salary
FROM EMPLOYEE -- 1
--WHERE ROWNUM <= 5 -- 2
ORDER BY SALARY DESC;

-- �ذ� ��� : ORDER BY�� ������ ���̺��� ������ ROWNUM ������ �ο��� 5������� �߸�.
SELECT
    ROWNUM,
    emp_name,
    salary
FROM(
        SELECT *
        FROM EMPLOYEE
        ORDER BY SALARY DESC
    )
WHERE ROWNUM <= 5;

-- �� �μ��� ��ձ޿��� ���� 3���� �μ��� �μ��ڵ�, ��� �޿� ��ȸ.
-- 1)�� �μ��� ��� �޿� ���ϱ�
SELECT 
    FLOOR(AVG(salary))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 2) �� �μ��� ��ձ޿� ����
SELECT 
    dept_code,
    FLOOR(AVG(salary))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY FLOOR(AVG(salary)) DESC;
-- 3) ���� ���� �μ� 3�� �߸���
SELECT
    ROWNUM,
    --dept_code,
    --"FLOOR(AVG(SALARY))" --1�� ��� �������� ����
    --"��ձ޿�" --21�ä� ��� ����
    E.* -- 3�� ���
FROM(
       SELECT 
        dept_code,
        FLOOR(AVG(SALARY)) --AS "��ձ޿�"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY FLOOR(AVG(SALARY)) DESC
    )E
WHERE ROWNUM <= 3;
-- ROWNUM �÷��� �̿��ؼ� ������ �ű�� �ִ�.
-- �ٸ�, ������ ���� ���� ���¿����� ������ �ű�� �ǹ̰� �����Ƿ�
-- �� ���� �� �����ű�⸦ �ؾ��Ѵ�. -> �켱������ �ζ��κ�� ORDER BY ������ �ϰ�, ������������ ������ ���δ�.

--���� �ֱٿ� �Ի��� 5�� ��ȸ(�����, �޿�, �Ի���)
-- �Ի��� ���� �̷� ~ ����(��������), ���� �ο��� 5��
SELECT
    ROWNUM,
    E.* -- �ζ��κ信�� *�� ����Ϸ��� �ݵ�� ��Ī�� �ο��Ǿ��־����.
FROM(
    SELECT
        emp_name,
        salary,
        hire_date
    FROM EMPLOYEE
    ORDER BY HIRE_DATE DESC
) E
WHERE ROWNUM <= 5;

/*
    6. ���� �ű�� �Լ�(WINDOW FUNCTION)
    RANK() OVER(���� ����) : ���� 1���� 3�̶�� �ϸ� �� ���� ������ 4���� �ϰڴ�.
    DENSE_RANK() OVER(���ı���) : ���� 1���� 3�̶�� �ϸ� �� ���� ������ 2���� �ϰڴ�.
    
    ���� ���� : ORDER BY ��(���ı��� �÷���, ��������/��������), NULL FIRST/LAST�� ���Ұ�.
    
    SELECT�������� �������.
*/
-- ������� �޿��� ���� ������� �Űܼ� �����, �޿�, ���� ��ȸ : RANK() OVER
SELECT
    emp_name,
    salary,
    RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;

-- ������� �޿��� ���� ������� �Űܼ� �����, �޿�, ���� ��ȸ : DENSE_RANK() OVER
SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;

SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 5;

--�ζ��κ並 ���� �ذᰡ��.
-- 1)RANK�Լ��� ������ �ű�� (���ı��� �Ϸ�)
SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
FROM EMPLOYEE;
-- 2) ���� ����� ���� ��ȸ
SELECT
    E.*
FROM(
    SELECT
        emp_name,
        salary,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "����"
    FROM EMPLOYEE
)E
WHERE ���� <= 5;