/*
    <SELECT>
    �����͸� ��ȸ�ϰų� �˻��� �� ����ϴ� ��ɾ�.
    
    - RESULT SET : SELECT ������ ���� ��ȸ�� �������� ������� �ǹ�.
                    ��, ��ȭ�� �ൿ�� ����.
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� �÷���, �÷���2, �÷���3 .....
    FROM ���̺��;
*/

-- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿� �÷��� ��ȸ
SELECT 
    EMP_ID AS emp_id, -- �÷����� �ҹ��ڷ� �ۼ��ϴ� ������ �ڹٷ� �Ѱ��ֱ� ���Ѱ�
    EMP_NAME AS emp_name,
    SALARY AS salary
FROM EMPLOYEE;
-- ��ɾ�, Ű����, �÷���, ���̺���� ��ҹ��ڸ� ������ ����.
-- �ҹ��ڷ� �ص� ����, �� �÷��� �����ϰ� �빮�ڷ� �ۼ��ϴ� ���� ������.

SELECT * FROM EMPLOYEE;
-- COLUMN

-- EMPLOYEE���̺��� ��ü ������� �̸�, �̸��� �޴�����ȣ�� ��ȸ.
SELECT
    emp_name,
    email,
    phone
FROM EMPLOYEE;

--------------����---------------
--1. JOB���̺��� ��� �÷� ��ȸ
--��� 1.
SELECT * 
FROM JOB;
--��� 2.
SELECT 
    job_code,
    job_name
FROM JOB;

--2. JOB���̺��� ���޸� �÷��� ��ȸ
SELECT 
    job_name
FROM JOB;

--3. DEPARTMENT ���̺��� ��� �÷� ��ȸ
SELECT * FROM DEPARTMENT;

--4. EMPLOYEE ���̺��� ������, �̸���, ��ȭ��ȣ, �Ի��� �÷��� ��ȸ.
SELECT
    emp_name,
    email, 
    phone, 
    hire_date --�ǹ̸� �˼��ְ� �ۼ�
FROM EMPLOYEE;

--5. EMPLOYEE ���̺��� �Ի���, ������, �޿� �÷�����ȸ
SELECT
    hire_date,
    emp_name,
    salary
FROM EMPLOYEE;

/*
    <�÷����� ���� �������>
    ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT ���� �������(+-/*)�� ����ؼ� ����� ��ȸ�� �� �ִ�.
*/
-- EMPLOYEE ���̺�� ���� ������, ����, ����.(���� * 12)
SELECT 
    emp_name,
    salary,
    salary * 12 AS "����"
FROM EMPLOYEE;

-- EMPLOYEE ���̺�� ���� ������, ����, ���ʽ�, ���ʽ��� ���Ե� ����(== (���� +���ʽ�*����)*12)
SELECT
    emp_name,
    salary,
    bonus,
    (salary + bonus*salary)*12 
FROM EMPLOYEE;
-- ������� �������� NULL���� ������ ��� ��������� ��������� NULL�� �ȴ�.

-- EMOLOYEE���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���� ��¥ - �Ի���) ��ȸ
-- DATE Ÿ�Գ����� ������ ����(DATE -> ��, ��, ��, ��, ��, ��)
-- ���ó�¥ : SYSDATE
SELECT
    emp_name,
    hire_date,
    SYSDATE "����ð�",
    SYSDATE - HIRE_DATE "�ٹ��ϼ�"
FROM EMPLOYEE;

/*
    <Į���� ��Ī �ο��ϱ�>
    [ǥ����]
    1. �÷��� AS ��Ī
    2. �÷��� AS "��Ī"  --> ���������� �̰� ���
    3. �÷��� ��Ī
    4. �÷��� "��Ī"
    
    AS�� ���̵� �Ⱥ��̵� ���� ��Ī�� Ư�����ڳ� ���Ⱑ ���Եɽ� �ݵ�� ""�� ��� ǥ����.
*/
--EMPLOYEE ���̺�κ��� ������, ����, ���� -> ����(���ʽ� ������)
SELECT
    emp_name,
    salary AS �޿�,
    bonus AS ���ʽ�,
    salary *12 AS "����(���ʽ� ������)"
FROM EMPLOYEE;

--EMPLOYEE ���̺�κ��� ������, ���� -> �޿�(��), ���ʽ�, ���ʽ��� ���Ե� ���� -> "���ʽ��� ���Ե� ����"
SELECT
    emp_name,
    salary AS "�޿�(��)",
    bonus AS ���ʽ�,
    (salary + bonus * salary)*12 AS "���ʽ��� ���Ե� ����"
FROM EMPLOYEE;

/*
    <���ͷ�>
    ���Ƿ� ������ ���ڿ�('')�� SELECT���� ����ϸ�
    ���� �� ���̺� �����ϴ� ������ó�� ��ȸ�� ������.
*/
SELECT 1 AS ����, '��' AS ���ڿ�, 0.4 AS �Ǽ�
FROM DUAL; --DUAL�� ����Ŭ���� �����ϴ� �ӽ� ���̺�

SELECT SYSDATE
FROM DUAL;
-- DUAL�� �ӽ����̺�.

-- EMPLOYEE ���̺�κ��� ���, �����, �޿�, ����(��) ��ȸ�ϱ�
SELECT
    emp_id,
    emp_name,
    salary,
    '��' AS ����
FROM EMPLOYEE;
--SELECT���� ������ ���ͷ� ���� ��ȸ����� RESULTSET�� ����࿡ �ݺ������� ��µȴ�.

/*
    <���Ῥ����>
    ���������� ��ġ �ϳ��� �÷��ΰ� ó�� �����ϰų�, �÷����� ���ͷ��� ������ �� �ֵ��� ���ִ� ������.
*/
-- EMPLOYEE�� ���, �̸�, �޿��� �����̺�� ��ȸ.
SELECT
    emp_id || 
    emp_name ||
    salary
FROM EMPLOYEE;

-- �÷����� ���ͷ��� ����.
-- ooo ����� ������ 00000000�� �Դϴ�.
SELECT 
    emp_name || ' ����� ������ '|| salary || '�� �Դϴ�.'
FROM EMPLOYEE;

/*
    <DISTINCT>
    ��ȸ�ϰ��� �ϴ� Į���� �ߺ��� ���� �� �ѹ��� ��ȸ�ϰ��� �Ҷ� ���.
    �ش� Į���� �տ� ���.
    
    [ǥ����]
    DISTINCT �÷���
    (��, SECLECT���� DISTINCT ������ �� �Ѱ��� �����ϴ�)
*/
-- EMPLOYEE ���̺��� �μ��ڵ�鸸 ��ȸ
SELECT 
    DISTINCT dept_code
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����ڵ�鸸 ��ȸ
SELECT
    DISTINCT job_code
FROM EMPLOYEE;
--DEPT_CODE, JOB_CODE���� ��Ʈ�� ��� �ߺ� �Ǻ�
SELECT 
  DISTINCT  dept_code,job_code
FROM EMPLOYEE;
------------------------------------------------------

/*
    <WHERE ��>
    ��ȸ�ϰ��� �ϴ� ���̺� Ư�� ������ �����ؼ�
    �� ���ǿ� �����ϴ� �����͵鸸 ��ȸ�ϰ��� �Ҷ� ����ϴ� ����.
    
    [ǥ����]
    SELECT ��ȸ�ϰ��� �ϴ� Į����, ....
    FROM ���̺��
    WHERE ���ǽ�;
    
    �������
    FROM -> WHERE -> SELECT
    ���ǽĿ� ��밡���� �����ڵ�
    1. ��Һ񱳿����� -> >, <, >=, <=
    2. ����񱳿����� -> =, !=
*/
-- EMPLOYEE ���̺�κ��� �޿��� 400���� �̻��� ����� ��ȸ�ϱ�.
SELECT *
FROM EMPLOYEE
WHERE SALARY >=4000000;

--EMPLOYEE���̺�κ��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ� �޿� ��ȸ
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE���̺��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ� �޿� ��ȸ
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE <> 'D9';
WHERE DEPT_CODE ^= 'D9';

--------------- �ǽ����� ------------------
--1.EMPLOYEE ���̺��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ.
SELECT
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE ���̺��� ���� �ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
SELECT
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE ���̺��� ���� �������� ������� ���, �̸�, �Ի��� ��ȸ
SELECT 
    emp_id,
    emp_name,
    hire_date
FROM EMPLOYEE
WHERE ENT_YN ='Y';

--4. EMPLOYEE ���̺��� ����(�޿� * 12)�� 5000���� �̻��� ������� �̸�, �޿�, ����, �Ի��� ��ȸ
SELECT 
    emp_name,
    salary,
    (salary * 12) AS "����",
    hire_date
FROM EMPLOYEE
WHERE (salary * 12) >= 50000000;
--> SELECT ������ �ο��� ��Ī�� WHERE������ ����� �� ����.

/*
    <��������>
    �������� ������ ���� �� ���
    
    AND(�ڹ� : &&), OR(�ڹ� : ||)
    AND : ~ �̸鼭, �׸���
    OR : ~�̰ų�, �Ǵ�
*/
-- EMPLOYEE���� �μ��ڵ尡 D9�̸鼭 �޿��� 500���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ.
SELECT 
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;
--�μ��ڵ尡 D6�̰ų� �޿��� 300���� �̻��� ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT
    emp_name, 
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 30000000;

--�޿��� 350���� �̻��̰�, 600���� ������ ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT
    emp_name,
    emp_id,
    salary,
    job_code
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000; 

/*
    <BETWEEN AND>
    �� �̻� �� ������ ������ ���� ������ �����Ҷ� ���.
    
    [ǥ����]
    ���� ��� �÷��� BETWEEN ���Ѱ� AND ���Ѱ�
*/
SELECT
    emp_name,
    emp_id,
    salary,
    job_code
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000; 
--�޿��� 350���� �̸��̰�, 600���� �ʰ��� ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT
    emp_name,
    emp_id,
    salary,
    dept_code
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--�ڹٿ��� !(������������) ���� �ǹ̴�. (NOT�� �÷��� �յڿ� �ۼ� ����)

--�Ի����� '90/01/01' ~ '03/01/01'�� ������� ��� Į����ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
--�Ի����� '90/01/01' ~ '03/01/01'�� �ƴ� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

/*
    <LIKE 'Ư������'>
    ���ϰ��� �ϴ� �÷����� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
    
    [ǥ����]
    ���� ��� �÷��� LIKE 'Ư������'
    
    -�ɼ� : Ư������ �κп� ���ϵ�ī���� '%', '_'�� ������ ������ �� �ִ�.
    '%' : 0���� �̻�.
          ���� ��� �÷��� LIKE '����%' => �÷��� �߿� '����'�� �����ϴ� ���� ��ȸ
          ���� ��� �÷��� LIKE '%����' => �÷��� �߿� '����'�� ������ ���� ��ȸ
          ���� ��� �÷��� LIKE '%����%' => �÷��� �߿� '����'�� ���ԵǴ� ���� ��ȸ
          
    '_' : 1����
          �񱳴�� �÷� �� LIKE '_����' => �ش� �÷��� �߿� '����'�տ� ������ 1���ڰ� �����ϴ� ��� ��ȸ
          �񱳴�� �÷� �� LIKE '__����' => �ش� �÷��� �߿� '����'�տ� ������ 2���ڰ� �����ϴ� ��� ��ȸ
*/
--���� ������ ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT 
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

-- �̸��߿� �ϰ� ���Ե� ������� �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT
    emp_name,
    emp_no,
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸�����ȸ.
SELECT
    emp_id,
    emp_name,
    phone,
    email
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--�̸� ��� ���ڰ� '��'�� ������� ��� �÷�
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';
--�̸����� _�� �ձ��ڰ� 3������ ����� ���, �̸�, �̸���
SELECT
    emp_id,
    emp_name,
    email
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';
-- ���ͷ� ���� _�ΰ��
--���ϵ� ī��� ���ǰ� �ִ� ���ڿ� �÷����� ������ ��� ����� ��ȸ�� �ȵ�(���ϵ� ī��� �ν��ϱ� ����)
--���� � ������ ������ϴµ�, ���� �����ͷ� ����ϰ����ϴ� �� ��(_ , %)�տ� ������ ���ϵ� ī�带 �����ϰ�
--ESCAPE OPTION�� ����ؾ���.

--------------------------------------------------------------------------------
--1. �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
SELECT
    emp_name,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--2. ��ȭ��ȣ�� ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ ��ȸ
SELECT 
    emp_name,
    phone
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--3. DEPARTMENT ���̺��� �ؿܿ����� ���õ� �μ����� ��� �÷� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '�ؿܿ���%';

/*
    <IS NULL>
    �ش� ���� NULL���� �����ش�.
    
    [ǥ����]
    �񱳴�� �÷� IS NULL : �÷����� NULL�� ���
    �񱳴�� �÷� IS NOT NULL : �÷��� NULL�� �ƴ� ���
*/
--���ʽ��� ���� �ʴ� ����� ��, ���ʽ����� NULL�� ���, �̸�, �޿�, ���ʽ�
SELECT
    emp_id
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE BONUS IS NULL;

--����� ���� ������� �����, ������(������ ���), �μ��ڵ� ��ȸ
SELECT
    emp_name,
    manager_id,
    dept_code
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--����� ����, �μ���ġ�� ���� ���� ������� ��� �÷� ��ȸ
SELECT 
    *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- �μ���ġ�� �����ʾ�����, ���ʽ��� �޴� ����� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN>
    �� ��� �÷����� ���� ������ ��ϵ� �߿� �ϳ��� ��ġ�ϴ� ���� �ִ��� �Ǵ�.
    
    [ǥ����]
    �񱳴�� �÷� IN(��1, ��2, ��3 ....)
*/
--�μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸�, �μ��ڵ�, �޿�
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D8', 'D5');
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; 

--���� �ڵ尡 J1�̰ų� J3�̰ų� �Ǵ� J4�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN('J1', 'J3', 'J4');

--���� ������ ��� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE NOT JOB_CODE IN('J1', 'J3', 'J4');

/*
    <������ �켱����>
    0. ()
    1. ���������
    2. ���Ῥ����
    3. �񱳿�����
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND(��������)
    8. OR(��������)
*/

--�����ڵ尡 J7�̰ų� J2�� ������� �޿��� 200���� �̻��� ������� ��� �÷� ��ȸ.
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE ='J2') AND SALARY >= 2000000;
--OR�����ں��� AND �����ڰ� �׻���� �����.
--OR������ ���� �����Ű�� �ʹٸ� ()�� �����ֱ�.

---------------------�ǽ�����-----------------------
-- 1. ����� ����, �μ���ġ�� ���� ���� ������� (�����, �����ȣ, �μ��ڵ�)��ȸ
SELECT
    emp_name,
    manager_id,
    dept_code
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- 2. ����(���ʽ� ������)�� 3000���� �̻��̰�, ���ʽ��� ���� �ʴ� ������� (���, �����, �޿�, ���ʽ�) ��ȸ
SELECT
    emp_id,
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE BONUS IS NULL AND (SALARY * 12) >= 30000000;
-- 3. �Ի����� '95/01/01' �̻��̰� �μ���ġ�� ���� �������(���, �����, �Ի���, �μ��ڵ�) ��ȸ
SELECT
    emp_id,
    emp_name, 
    hire_date,
    dept_code
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;
-- 4. �޿��� 200���� �̻� 500���� �����̰� �Ի����� '01/01/01'�̻��̰� ���ʽ��� ���� �ʴ� ������� 
--(���, �����, �޿�, �Ի���, ���ʽ�)��ȸ
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date,
    bonus
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;
--5. ���ʽ����� ������ NULL�� �ƴϰ� �̸��� �ϰ� ���ԵǾ��ִ� �������(���, �����, �޿�, ���ʽ����� ����)��ȸ
--������ ��Ī �ο�
SELECT
    emp_id,
    emp_name,
    salary,
    (salary + bonus * salary)*12 AS ����
FROM EMPLOYEE
WHERE (salary + bonus * salary)*12 IS NOT NULL AND EMP_NAME LIKE '%��%';
------------------------------------------------------------------------
/*
    <ORDER BY ��>
    SELECT�� ���� �������� �����ϴ� ���� �Ӹ� �ƴ϶� ���� �������� ����Ǵ� ����.
    ���� ��ȸ�� ������鿡 ���ؼ� ���� ������ �����ִ� ����
    
    [ǥ����]
    SELECT �÷�1, �÷�2
    FROM ���̺��
    WHERE ������
    ORDER BY [���ı������� ������� �ϴ� �÷���/ ��Ī/ �÷�����] [ASC/DESC][NULLS FIRST/NULLS LAST]
    
        �������� / ��������
        -ASC : ��������(������ �⺻��)
        -DESC : ��������
        
        �����ϰ��� �ϴ� �÷����� NULL�� �ִ� ���
        -NULLS FIRST : �ش� NULL������ ������ ��ġ�ϰڴ�. (�������� �����ΰ�� �⺻��)
        -NULLS LAST : �ش� NULL������ �ڷ� ��ġ�ϰڴ�. (�������� �����ΰ�� �⺻��)
*/
--������ ���� ����� ���� �����ϰ� ������.(��������)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

--���� ��������
SELECT *
FROM EMPLOYEE
ORDER BY SALARY ASC;

-- ���ʽ� ���� ����
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; --ASC (��������) && NULL LAST �⺻��.
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- DESC (��������) && NULL FIRST �⺻��.
ORDER BY BONUS DESC NULLS LAST, SALARY, EMP_ID DESC; 
--> ù��°�� ������ ���ı����� �÷����� ������ ���, �ι�° ���ı����� ������ �ٽ� ����

-- ���� ���� �������� ����
SELECT 
    emp_name,
    salary,
    (salary * 12) "����"
FROM EMPLOYEE
--ORDER BY "����" ASC; --ORDER BY�� �������� ����Ǳ� ������ ���� ��밡��
--ORDER BY (salary * 12) ASC;
ORDER BY 3; -- �÷� ������ ��� �����ϴ�.

--ORDER BY�� ���ڻӸ� �ƴ϶�, ���ڿ�, ��¥ � ���ؼ��� ���� �����ϴ�!





