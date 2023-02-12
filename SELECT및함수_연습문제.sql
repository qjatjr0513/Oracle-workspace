--1. JOB ���̺��� ��� ���� ��ȸ
SELECT *
FROM JOB;
--2. JOB ���̺��� ���� �̸� ��ȸ
SELECT 
    job_name
FROM JOB;
--3. DEPARTMENT ���̺��� ��� ���� ��ȸ
SELECT *
FROM DEPARTMENT;
--4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT
    emp_name,
    email,
    phone,
    hire_date
FROM EMPLOYEE;
--5. EMPLOYEE���̺��� �����, ��� �̸�, ���� ��ȸ
SELECT 
    hire_date,
    emp_name,
    salary
FROM EMPLOYEE;
--6. EMPLOYEE���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT 
    emp_name,
    salary * 12 AS "����",
    (salary +(salary * NVL(bonus, 0)))*12 AS "�Ѽ��ɾ�",
    (salary +(salary * NVL(bonus, 0)))*12 - (salary * 12 *0.03) AS "�Ǽ��ɾ�"
FROM EMPLOYEE;

--7. EMPLOYEE���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT 
    emp_name,
    salary,
    hire_date,
    phone
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

--8. EMPLOYEE���̺��� �Ǽ��ɾ�(6�� ����)�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT 
    emp_name,
    salary,
    (salary +(salary * NVL(bonus, 0)))*12 - (salary * 12 *0.03) AS "�Ǽ��ɾ�",
    hire_date
FROM EMPLOYEE
WHERE (salary +(salary * NVL(bonus, 0)))*12 - (salary * 12 *0.03) >= 50000000;
--9. EMPLOYEE���̺� ������ 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';
--10. EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� ��
-- ������� 02�� 1�� 1�Ϻ��� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT 
    emp_name,
    dept_code,
    hire_date
FROM EMPLOYEE
WHERE DEPT_CODE IN('D9', 'D5') AND HIRE_DATE < '02/01/01';

--11. EMPLOYEE���̺� ������� 90/01/01 ~ 01/01/01�� ����� ��ü ������ ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

--12. EMPLOYEE���̺��� �̸� ���� '��'���� ������ ����� �̸� ��ȸ
SELECT 
    emp_name
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';

--13. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT 
    emp_name,
    phone
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--14. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4���̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
-- ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____$_%' ESCAPE '$' AND 
DEPT_CODE IN('D9', 'D6') AND 
HIRE_DATE BETWEEN '90/01/01' AND '00/12/01' 
AND SALARY >= 2700000;

--15. EMPLOYEE���̺��� ��� ��� ������ �ֹι�ȣ�� �̿��Ͽ� ����, ����, ���� ��ȸ
SELECT 
    emp_name,
    SUBSTR(emp_no,1,2) AS "����",
    SUBSTR(emp_no,3,2) AS "����",
    SUBSTR(emp_no,5,2) AS "����"
FROM EMPLOYEE;

--16. EMPLOYEE���̺��� �����, �ֹι�ȣ ��ȸ (��, �ֹι�ȣ�� ������ϸ� ���̰� �ϰ�, '-'���� ���� '*'�� �ٲٱ�)
SELECT
    emp_name,
    RPAD(SUBSTR(emp_no,1,7),14, '*') AS "�ֹι�ȣ"
FROM EMPLOYEE;

--17. EMPLOYEE���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- (��, �� ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ǵ��� �ϰ� ��� ����(����), ����� �ǵ��� ó��)
SELECT
    emp_name,
    FLOOR(ABS(hire_date - SYSDATE)) AS "�ٹ��ϼ�1",
    FLOOR(SYSDATE - hire_date) AS "�ٹ��ϼ�2"
FROM EMPLOYEE;

--18. EMPLOYEE���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID, 2) = '1';

--19. EMPLOYEE���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
-- ����⵵ - �Ի�⵵ >= 20
SELECT *
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE) >= 20;

SELECT *
FROM EMPLOYEE
WHERE MONTHS_BETWEEN(SYSDATE, HIRE_DATE) >= 240;
--WHERE ADD_MONTHS(HIRE_DATE, 240) < SYSDATE;

--20. EMPLOYEE ���̺��� �����, �޿� ��ȸ (��, �޿��� '\9,000,000' �������� ǥ��)
SELECT 
    emp_name,
    TO_CHAR(salary, 'L9,999,999') AS "�޿�"
FROM EMPLOYEE;

--21. EMPLOYEE���̺��� ���� ��, �μ��ڵ�, �������, ����(��) ��ȸ
--(��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ� �ϸ�
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���)
SELECT
    emp_name,
    dept_code,
    TO_CHAR(TO_DATE(SUBSTR(emp_no, 1, 6)), 'YY"��" MM"��" DD"��"') AS "�������",
    EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,2),'RR')) AS "����"
FROM EMPLOYEE;
--22. EMPLOYEE���̺��� �μ��ڵ尡 D5, D6, D9�� ����� ��ȸ�ϵ� D5�� �ѹ���, D6�� ��ȹ��, D9�� �����η� ó��
-- (��, �μ��ڵ� ������������ ����)
SELECT 
    emp_name,
    dept_code,
    CASE WHEN dept_code = 'D5' THEN '�ѹ���'
         WHEN dept_code = 'D6' THEN '��ȹ��'
         WHEN dept_code = 'D9' THEN '������'
    END
FROM EMPLOYEE
ORDER BY DEPT_CODE;

SELECT
    emp_name,
    DECODE(dept_code, 'D5', '�ѹ���', 'D6', '��ȹ��', 'D9', '������') AS "�μ�"
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5', 'D6', 'D9')
ORDER BY DEPT_CODE;
--23. EMPLOYEE���̺��� ����� 201���� �����, �ֹι�ȣ ���ڸ�, �ֹι�ȣ ���ڸ�, 
-- �ֹι�ȣ ���ڸ��� ���ڸ��� �� ��ȸ
SELECT 
    emp_name,
    SUBSTR(emp_no, 1, 6) AS "�ֹι�ȣ ���ڸ�",
    SUBSTR(emp_no, 8, 14) AS "�ֹι�ȣ ���ڸ�",
   TO_NUMBER(SUBSTR(emp_no, 1, 6)+ SUBSTR(emp_no, 8, 14)) AS "�ֹι�ȣ(��,��) ��"
FROM EMPLOYEE
WHERE EMP_ID = '201';

--24. EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� �� ��ȸ
SELECT 
    SUM((SALARY+SALARY*NVL(BONUS, 0))*12) AS "�� ����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--25. EMPLOYEE���̺��� �������� �Ի��Ϸκ��� �⵵�� ������ �� �⵵�� �Ի� �ο��� ��ȸ
-- ��ü ���� ��, 2001��, 2002��, 2003��, 2004��
SELECT 
    COUNT(*) AS "��ü ���� ��",
    COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2001', 1)) AS "2001��",
    COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2002', 2)) AS "2002��",
    COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2003', 3)) AS "2003��",
    COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE),'2004', 4)) AS "2004��"
FROM EMPLOYEE;

SELECT 
    COUNT(*) AS "��ü ���� ��",
    COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = 2001 THEN 123 END) AS "2001��",
    COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = 2002 THEN 123 END) AS "2002��",
    COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = 2003 THEN 123 END) AS "2003��",
    COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = 2004 THEN 123 END) AS "2004��"
FROM EMPLOYEE;