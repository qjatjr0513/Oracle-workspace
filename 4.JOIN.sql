/*
    <JOIN>
    
    두개 이상의 테이블에서 데이터를 같이 조회하고자 할때 사용되는 구문 => SELECT문 이용
    조회 결과는 하나의 결과물(RESULT SET)으로 나옴.
    
    JOIN을 하는 이유?
    관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음.
    사원정보는 사원테이블, 직급정보는 직급테이블, 등등 -> 중복을 최소화시키기 위해.
    => 즉, JOIN 구문을 이용해서 여러개 테이블 간의 "관계"를 맺어서 같이 조회해야함.
    => 단, 무작정 JOIN을 하는것이 아니라 테이블 간에 "연결고리"에 해당되는 컬럼을 매칭시켜서 조회해야함.
    
    문법상 분류 :JOIN은 크게 "오라클 전용구문"과 ANSI(미국 국립 표준 협회) 구문으로 나뉘어짐.
    
    개념상 분류
            오라클 전용 구문                   |       ANSI 구문(오라클 + 다른 DBMS)
            등가조인(EQUAL JOIN)              |           내부조인(INNER JOIN) -> JOIN USING/ON
            ------------------------------------------------------------------------------------------
            포괄조인                          |          외부조인(OUTER JOIN) -> JOIN USING
            LEFT OUTER JOIN                  |           왼쪽외부조인(LEFT OUTER JOIN)
            RIGHT OUTER JOIN                 |          오른쪽외부조인(RIGHT OUTER JOIN) 
                                                        전체 외부 조인(FULL OUTER JOIN): 오라클에선 사용불가.
            --------------------------------------------------------------------------------------------
            카테시안 곱(CATESIAN PRODUCT)      |             교차 조인(CROSS JOIN)
            --------------------------------------------------------------------------------------------
            자체 조인(SELF JOIN)
            비등가 조인(NON EQUAL JOIN)
            --------------------------------------------------------------------------------------------
                                        다중 조인 테이블
    
*/
-- 사원테이블에서 부서 명까지 알고싶은 경우?
-- 1단계 사원테이블에서 부서코드 조회.
SELECT
    emp_id,
    emp_name,
    dept_code
FROM EMPLOYEE;

SELECT
    DEPT_ID,
    DEPT_TITLE
FROM DEPARTMENT;

--전체 사원들의 사번, 사원명, 직급코드까지만 알때 직급 명까지 알아내고자 한다면?
SELECT
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE;

SELECT
    job_code,
    job_name
FROM JOB;

--> 조인을 통해서 연결고리에 해당되는 컬럼들만 제대로 매칭시키면 하나의 RESULTSET으로 조회가능해진다.

/*
    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
    연결시키고자 하는 컬럼의 값이 "일치하는 행들만"조인되서 조회.
    (==일치하지 않는 값들은 결과에서 제외)
    => 동등비교연산자 = ("일치한다"라는 조건을 제시함)
    
    [표현법]
    등가조인(오라클구문)
    SELECT 조회하고자하는 컬럼명들 나열
    FROM 조인하고자하는 테이블명들 나열
    WHERE 연결할 컬럼에 대한 조건을 제시(=)
    
    내부조인(ANSI 구문) : ON구문
    SELECT 조회하고자 하는 컬럼명들 나열
    FROM 조인하고자하는 테이블명 1개 제시
    JOIN 조인하고자하는 테이블명 1개만 제시 ON(연결할 컬럼에 대한 조건을 제시 (=))
    
    내부조인(ANSI 구문) : USING 구문 => 단, 연결할 컬럼명이 동일한 경우에만 씀.
    SELECT 조회하고자 하는 컬럼명들 나열
    FROM 조인하고자하는 테이블명 1개 제시
    JOIN 조인한 테이블명 1개만 제시 USING(연결한 컬럼명 1개 제시)
    
    +만약에 연결한 컬럼명이 동일한데 USING구문을 사용하지 않는 경우 반드시,
    명시적으로 테이블명 OR 테이블의 별칭을 작성해서 어느 테이블의 컬럼인지 알려줘야함.
*/

--오라클 전용구문

--1) 전체 사원들의 사번, 사원명, 부서코드, 부서명까지 알아보기.
-- FROM 절에 조회하고자하는 테이블들을 나열 ,를 이용해서 나열하고
--WHERE 절에 매칭시킬 컬럼명에 대한 조건을 제시
SELECT 
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하지 않는 데이터들은 조회되지 않음(NULL)
--> 두개 이상의 테이블들을 조인할때 일치하는 값이 없는 행이 결과에서 제외되었다.
SELECT
    emp_id ,
    emp_name,
    e.job_code,
    job_name
FROM EMPLOYEE e, JOB j -- 각 테이블마다 별칭을 붙여서 사용하는 방법도 있음.
WHERE e.JOB_CODE = j.JOB_CODE; 
-- column ambiguously defined -> 확실히 어떤 테이블의 컬럼인지를 다 명시해줘야함.

--ANSI 구문.
--FROM 절 뒤에 기준테이블을 1개만 제시.
-- 그 뒤에 JOIN 절에서 같이 조회하고자하는 테이블 기술, 또한 매칭시킬 컬럼에 대한 조건도 같이 기술.
--USING 구문 / ON 구문.

SELECT
    emp_id,
    emp_name,
    dept_code,
    dept_title
FROM EMPLOYEE
/*INNER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- INNER는 생략가능.

SELECT
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);
-- USING 구문 : 컬럼명이 동일한 경우에만 사용 가능, 동일한 컬럼명 하나만 써주면 알아서 매칭 시켜줌(AMBIGUIOUSLY 발생 X)

SELECT
    emp_id,
    emp_name,
    E.job_code,
    job_name
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE;

--[참고] 자연조인(NATURAL JOIN) : 등가조인 방법중 하나
-- => 동일한 타입과 이름을 가진 컬럼을 조인 조건으로 이용하는 방법.
SELECT 
    emp_id,
    emp_name,
    job_code,
    job_name
FROM EMPLOYEE
NATURAL JOIN JOB;
-- 두개의 테이블을 제시했는데 운좋게도 두개의 테이블에 일치하는 컬럼이 딱 하나 유일하게 존재해서 가능함.
-- -> 자연조인을 씀으로써 알아서 매칭되서 조인됨.

-- 직급이 대리인 사원들의 정보를 조회(사번, 사원명, 월급, 직급명)
SELECT 
    emp_id, 
    emp_name, 
    salary,
    job_name
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND JOB_NAME = '대리';

--ANSI구문으로 출력.
SELECT 
    E.emp_id, 
    E.emp_name, 
    E.salary,
    J.job_name
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE J.JOB_NAME = '대리';

SELECT 
    emp_id, 
    emp_name, 
    salary,
    job_name
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';
-------------------------------------------------------------------------------------
-- 1. 부서가 인사관리부인 사원들의 사번, 사원명, 보너스를 조회
--> 오라클 전용 구문  
SELECT
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE, DEPARTMENT 
WHERE DEPT_CODE = DEPT_ID 
AND DEPT_TITLE = '인사관리부';

--> ANSI 구문
SELECT
    emp_id,
    emp_name,
    bonus
FROM EMPLOYEE 
JOIN DEPARTMENT  ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';
-- 2. 부서가 총무부가 아닌 사원들의 사번, 사원명, 급여, 입사일 조회.
--> 오라클 전용 구문
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND DEPT_TITLE != '총무부';
--> ANSI 구문
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE != '총무부';
-- 3. 보너스를 받는 사원들의 사번, 보너스, 부서명 조회
--> 오라클 전용 구문
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID 
AND BONUS IS NOT NULL;
--> ANSI 구문
SELECT
    emp_id,
    emp_name,
    bonus,
    dept_title
FROM EMPLOYEE 
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE BONUS IS NOT NULL;
-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAK_NAME) 조회
SELECT * FROM DEPARTMENT; --LOCATION_ID
SELECT * FROM LOCATION; -- LOCATION_CODE
--> 오라클 전용 구문
SELECT 
    DEPT_ID,
    DEPT_TITLE,
    LOCAL_CODE,
    LOCAL_NAME
FROM DEPARTMENT, LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;
--> ANSI 구문
SELECT 
    DEPT_ID,
    DEPT_TITLE,
    LOCAL_CODE,
    LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION  ON(LOCATION_ID = LOCAL_CODE);

-- 등가조인/ 내부조인 : 일치하지 않은 행은 제외되고 조회가됨.

------------------------------------------------------------------------

--전체 사원들의 사원명, 급여, 부서명
SELECT 
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--DEPT_CODE가 NULL인 두명의 사원은 조회되지 않음.

/*
    2. 포괄조인 / 외부조인(OUTER JOIN)
    
    테이블간의 JOIN시에 "일치하지 않은 행도" 포함시켜줌.
    단, 반드시 LEFT/ RIGHT를 지정해야한다. => 기준이되는 테이블을 지정해준다.
    
    일치하는행 + 기준이되는 테이블을 기준으로 일치하지 않는 행도 포함시켜서조회시켜줌.
*/
--1) LEFT OUTER JOIN : 두 테이블중에 왼편에 기술된 테이블을 기준으로 JOIN
--                        즉, 뭐가 되었든 간에 왼편에 기술된 테이블의 데이터는 무조건 조회.

--ANSI구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE LEFT /*OUTER*/ JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--EMPLOYEE 테이블을 기준으로 조회했기 때문에, EMPLOYEE에 존재하는 데이터는 일치하든 일치하지 않든 다 조회하게끔한다.

-- 오라클 전용 구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);
-- 내가 기준으로 삼을 테이블의 컬럼명이 아닌, 반대 테이블의 컬럼명에 (+)를 붙여준다.

--2) RIGHT OUTER JOIN : 두 테이블의 오른편에 기술된 테이블을 기준테이블로 삼겠다.
--                      즉, 뭐가되었든 오른편에 기술한 테이블 데이터는 모두 가져오겠다.

-- ANSI 구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
RIGHT OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--오라클 구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;

--3) FULL OUTER JOIN : 두 테이블의 모든 행을 조회
--일치하는 행들 + LEFT OUTER JOIN 기준 새롭게 추가된 행 + RIGHT OUTER JOIN 기준 새롭게 추가된 행들
--ANSI 구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

--오라클 전용 구문
SELECT
    emp_name,
    salary,
    dept_title
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- 오라클 전용 구문에서는 FULL OUTER JOIN은 사용불가
/*
    3. 카테시안의 곱 (CARTESIAN PRODUCT) / 교차조인(CROSS JOIN)
    
    모든 테이블의 각 행들이 서로서로 매핑된 데이터 조회됨(곱집합)
    두 테이블 행들이 모두 곱해진 행들의 조합이 출력됨.
    
    --> 각 N개, M개의 행을 가진 데이터들의 카테시안곱의 결과는 N*M행
    --> 모든 경우의 수를 다 따져서 조회하겠다.
    --> 방대한 데이터를 출력(과부하의 위험이 있음)
*/
--오라클 전용 구문
SELECT
    emp_name,
    dept_title
FROM EMPLOYEE, DEPARTMENT; -- 23 * 9 = 207행 조회

-- ANSI 구문
SELECT
    emp_name,
    dept_title
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; -- 23 * 9 = 207행 조회

-- 카테시안 곱의 경우 : WHERE절에 기술하는 조인 조건이 잘못되었거나 , 아예 없을 경우 발생함.

/*
    4. 비등가 조인(NON EQUAL JOIN)
    '=' (등호)를 사용하지 않는 조인문 -> 다른 비교 연산자를 써서 조인하겠다. (>, <, >=, <=, BETWEEN A AND B)
    => 지정한 컬럼값들이 일치하는 경우가 아니라 "범위"에 포함되는 경우 매칭해서 조회하겠다.
    
    EX) 등가 조인 => '='으로 일치하는 경우만 조회
        비등가 조인 => '='가 아닌 다른 비교연산자들로 '범위'에 포함되는 경우를 조회.
*/
-- 사원명, 급여
SELECT
    emp_name,
    salary
FROM EMPLOYEE;

--SAL_GRADE 테이블 조회
SELECT *
FROM SAL_GRADE;

--사원명, 급여, 급여등급
--> 오라클 전용구문.
SELECT
    emp_name,
    salary,
    S.sal_level
FROM EMPLOYEE E, SAL_GRADE S
--WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;

--ANSI 구문
SELECT
    emp_name,
    salary,
    e.sal_level
FROM EMPLOYEE e
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);

-- USING 구문은 등가조인에서만 컬럼명이 동일한 경우만 사용가능하다. -> 비등가 조인은 ON 구문만 사용한다.

/*
    5. 자체조인 (SELF JOIN)
    
    같은테이블끼리 조인하는 경우
    즉, 자기 자신의 테이블과 다시 조인을 맺겠다.
    => 자체 조인의 경우 테이블에 반드시 별칭을 붙여줘야한다.(서로 다른테이블인것 처럼 조인시키기 위함)
*/
SELECT * FROM EMPLOYEE E; --사원에 대한 정보를 도출용 테이블
SELECT * FROM EMPLOYEE M; --사수에 대한 정보를 도출용 테이블

-- 오라클구문
-- 사원의 사번, 사원명, 사수의 사번, 사수명
SELECT
    E.emp_id AS "사번",
    E.emp_name AS "사원명",
    E.manager_id AS "사수의 사번",
    M.emp_name AS "사수명"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-- ANSI 구문
SELECT
    E.emp_id AS "사번",
    E.emp_name AS "사원명",
    E.manager_id AS "사수사번",
    M.emp_name AS "사수명"
FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

/*
    <다중 JOIN>
    3개 이상의 테이블을 조인해서 조회하겠다.
    => 조인순서가 중요.
*/
-- 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE; --EMP_ID, EMP_NAME DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT; -- DEPT_ID
SELECT * FROM JOB; -- JOB_CODE

--오라클 구문
SELECT
    emp_id AS "사번", 
    emp_name AS "사원명",
    dept_title AS "부서명", 
    job_name AS "직급명"
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE E.DEPT_CODE = DEPT_ID(+) AND E.JOB_CODE = J.JOB_CODE(+);

-- ANSI 구문
SELECT
    emp_id AS "사번", 
    emp_name AS "사원명",
    dept_title AS "부서명", 
    job_name AS "직급명"
FROM EMPLOYEE E
LEFT OUTER JOIN DEPARTMENT ON(E.DEPT_CODE = DEPT_ID)
LEFT OUTER JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);






