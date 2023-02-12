--1. 70��� ��(1970~1979) �� �����̸鼭 ������ ����� �̸��� �ֹι�ȣ, �μ� ��, ���� ��ȸ
-- ����Ŭ ���� ����
SELECT
    emp_name,
    emp_no,
    dept_title,
    job_name
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE (DEPT_CODE = DEPT_ID) AND (E.JOB_CODE = J.JOB_CODE)
AND EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,6))) BETWEEN '1970' AND '1979'
AND EMP_NAME LIKE '��%' AND TO_NUMBER(SUBSTR(EMP_NO,8,1)) IN (2,4);

--ANSI ����
SELECT
    emp_name,
    emp_no,
    dept_title,
    job_name
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID
LEFT JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE 
--EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,6))) BETWEEN 1970 AND 1979
--SUBSTR(emp_no,1,6) > = 70 AND SUBSTR(emp_no,1,6) <= 79
SUBSTR(emp_no,1,1) = '7' 
AND EMP_NAME LIKE '��%' AND TO_NUMBER(SUBSTR(EMP_NO,8,1)) IN (2,4);

--2. ���� �� ���� ������ ��� �ڵ�, ��� ��, ����, �μ� ��, ���� �� ��ȸ
SELECT
    dept_code,
    emp_id,
    emp_name,
    EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,6))) AS "����",
    dept_title,
    job_name
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN JOB J USING(JOB_CODE)
WHERE (EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,2), 'RR'))) = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,2), 'RR'))) FROM EMPLOYEE);
-- ����⵵ - ���� �¾ �⵵ ->
--3. �̸��� �������� ���� ����� ��� �ڵ�, ��� ��, ���� ��ȸ
SELECT
    emp_id,
    emp_name,
    job_name
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE ('%��%');
    
--4. �μ��ڵ尡 D5�̰ų� D6�� ����� ��� ��, ���� ��, �μ� �ڵ�, �μ� �� ��ȸ
SELECT
    emp_name,
    job_name,
    dept_code,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE DEPT_CODE IN('D5', 'D6')
ORDER BY EMP_ID;
--5. ���ʽ��� �޴� ����� ��� ��, �μ� ��, ���� �� ��ȸ
SELECT
    emp_name,
    bonus,
    dept_title,
    local_name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;
--6. ��� ��, ���� ��, �μ� ��, ���� �� ��ȸ
SELECT
    emp_name,
    job_name,
    dept_title,
    local_name
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
--7. �ѱ��̳� �Ϻ����� �ٹ� ���� ����� ��� ��, �μ� ��, ���� ��, ���� �� ��ȸ
SELECT 
    emp_name,
    dept_title,
    local_name,
    national_name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('�ѱ�', '�Ϻ�')
AND ENT_YN = 'N';
--8. �� ����� ���� �μ����� ���ϴ� ����� �̸� ��ȸ
SELECT 
    E2.emp_name,
    E.dept_code,
    E.emp_name
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE E2 ON E.DEPT_CODE = E2.DEPT_CODE
WHERE E.EMP_NAME != E2.EMP_NAME
ORDER BY E2.EMP_NAME;
--9. ���ʽ��� ���� ���� �ڵ尡 J4�̰ų� J7�� ����� �̸�, ���� ��, �޿� ��ȸ(NVL �̿�)
SELECT 
    emp_name,
    job_name,
    salary
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND JOB_CODE IN('J4', 'J7');
    
--10. ���ʽ� ������ ������ ���� 5���� ���, �̸�, �μ� ��, ����, �Ի���, ���� ��ȸ
SELECT
    E.*
FROM(
    SELECT
        emp_id,
        emp_name,
        dept_title,
        job_name,
        hire_date,
        RANK() OVER(ORDER BY (SALARY+SALARY*NVL(BONUS,0))*12 DESC) AS "����"
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    )E
WHERE "����" <= 5;
--11. �μ� �� �޿� �հ谡 ��ü �޿� �� ���� 20%���� ���� �μ��� �μ� ��, �μ� �� �޿� �հ� ��ȸ

--11-1. JOIN�� HAVING ���
SELECT
    SUM(SALARY)
FROM EMPLOYEE;
SELECT
        dept_title,
        SUM(salary) AS "�μ��� �޿� �հ�"
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(salary) > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);
--11-2. �ζ��� �� ���
SELECT
    E.*
FROM(
    SELECT
        dept_title,
        SUM(salary) AS "�޿��հ�"
    FROM EMPLOYEE 
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) 
    GROUP BY DEPT_TITLE

)E
WHERE E.�޿��հ� > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);
--12. �μ� ��� �μ� �� �޿� �հ� ��ȸ
SELECT
    dept_title,
    SUM(SALARY) AS "�μ��� �޿� �հ�"
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

SELECT --9
    dept_title,
    SUM(SALARY) AS "�μ��� �޿� �հ�"
FROM ( --1
        SELECT * --4
        FROM EMPLOYEE --2
        WHERE DEPT_CODE = 'D9' --3
        )E
LEFT JOIN DEPARTMENT D ON E.DEPT_CODE = D.DEPT_ID --5
WHERE DEPT_CODE = 'D9' --6
GROUP BY DEPT_TITLE --7
HAVING SUM(SALARY) >= 2000000 --8
ORDER BY 1; --10




