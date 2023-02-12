--1. 70년대 생(1970~1979) 중 여자이면서 전씨인 사원의 이름과 주민번호, 부서 명, 직급 조회
-- 오라클 전용 구문
SELECT
    emp_name,
    emp_no,
    dept_title,
    job_name
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE (DEPT_CODE = DEPT_ID) AND (E.JOB_CODE = J.JOB_CODE)
AND EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,6))) BETWEEN '1970' AND '1979'
AND EMP_NAME LIKE '전%' AND TO_NUMBER(SUBSTR(EMP_NO,8,1)) IN (2,4);

--ANSI 구문
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
AND EMP_NAME LIKE '전%' AND TO_NUMBER(SUBSTR(EMP_NO,8,1)) IN (2,4);

--2. 나이 상 가장 막내의 사원 코드, 사원 명, 나이, 부서 명, 직급 명 조회
SELECT
    dept_code,
    emp_id,
    emp_name,
    EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,6))) AS "나이",
    dept_title,
    job_name
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
LEFT JOIN JOB J USING(JOB_CODE)
WHERE (EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,2), 'RR'))) = (SELECT MIN(EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(emp_no,1,2), 'RR'))) FROM EMPLOYEE);
-- 현재년도 - 내가 태어난 년도 ->
--3. 이름에 ‘형’이 들어가는 사원의 사원 코드, 사원 명, 직급 조회
SELECT
    emp_id,
    emp_name,
    job_name
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE EMP_NAME LIKE ('%형%');
    
--4. 부서코드가 D5이거나 D6인 사원의 사원 명, 직급 명, 부서 코드, 부서 명 조회
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
--5. 보너스를 받는 사원의 사원 명, 부서 명, 지역 명 조회
SELECT
    emp_name,
    bonus,
    dept_title,
    local_name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;
--6. 사원 명, 직급 명, 부서 명, 지역 명 조회
SELECT
    emp_name,
    job_name,
    dept_title,
    local_name
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
--7. 한국이나 일본에서 근무 중인 사원의 사원 명, 부서 명, 지역 명, 국가 명 조회
SELECT 
    emp_name,
    dept_title,
    local_name,
    national_name
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국', '일본')
AND ENT_YN = 'N';
--8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
SELECT 
    E2.emp_name,
    E.dept_code,
    E.emp_name
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE E2 ON E.DEPT_CODE = E2.DEPT_CODE
WHERE E.EMP_NAME != E2.EMP_NAME
ORDER BY E2.EMP_NAME;
--9. 보너스가 없고 직급 코드가 J4이거나 J7인 사원의 이름, 직급 명, 급여 조회(NVL 이용)
SELECT 
    emp_name,
    job_name,
    salary
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE NVL(BONUS, 0) = 0 AND JOB_CODE IN('J4', 'J7');
    
--10. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서 명, 직급, 입사일, 순위 조회
SELECT
    E.*
FROM(
    SELECT
        emp_id,
        emp_name,
        dept_title,
        job_name,
        hire_date,
        RANK() OVER(ORDER BY (SALARY+SALARY*NVL(BONUS,0))*12 DESC) AS "순위"
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
    )E
WHERE "순위" <= 5;
--11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회

--11-1. JOIN과 HAVING 사용
SELECT
    SUM(SALARY)
FROM EMPLOYEE;
SELECT
        dept_title,
        SUM(salary) AS "부서별 급여 합계"
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) 
GROUP BY DEPT_TITLE
HAVING SUM(salary) > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);
--11-2. 인라인 뷰 사용
SELECT
    E.*
FROM(
    SELECT
        dept_title,
        SUM(salary) AS "급여합계"
    FROM EMPLOYEE 
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID) 
    GROUP BY DEPT_TITLE

)E
WHERE E.급여합계 > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);
--12. 부서 명과 부서 별 급여 합계 조회
SELECT
    dept_title,
    SUM(SALARY) AS "부서별 급여 합계"
FROM EMPLOYEE 
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE;

SELECT --9
    dept_title,
    SUM(SALARY) AS "부서별 급여 합계"
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




