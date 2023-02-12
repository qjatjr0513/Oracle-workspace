/*
    <SUBQUERY (서브쿼리)>
    
    하나의 주된 SQL(SELECT, CREATE, INSERT, UPDATE, ...)안에 포함된 또 하나의 SELECT 문.
    
    메인 SQL문을 위해서 '보조' 역할을 하는 SELECT문.
    -> 주로 조건절(WHERE, HAVING)안에서 쓰인다.
    
*/
--노옹철사원과 같은 부서인 사원들.
-- 1) 노옹철사원의 부서번호 찾기.
SELECT
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

--2) 부서코드가 'D9'인사원 찾기
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';
--두단계 합치기
SELECT
    *
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

--전체 사원의 평균 급여보다 더 많은 급여를 받고 있는 사원들의 사번, 이름 직급코드 조회.

--1) 우선적으로 전체 사원의 평균 급여를 구하기
SELECT
    FLOOR(AVG(SALARY))
FROM EMPLOYEE;
-- 2) 급여가 "평균급여"이상인 사원들 조회
SELECT
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE
WHERE SALARY >= 3047662; 
--두단계를 하나의 쿼리문으로 합치기
SELECT
    emp_id,
    emp_name,
    job_code
FROM EMPLOYEE
WHERE SALARY >= (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE); 

/*
    서브쿼리 구분
    서브쿼리를 수행한 결과값이 몇행 몇열 이냐에 따라서 분류됨.
    - 단일행 (단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 오로지 1개일때(한칸의 컬럼값으로 나올 때)
    - 다중행 (단일열) 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 행일 때
    - (단일행) 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러 열일때
    - 다중행 다중열 서브쿼리 : 서브쿼리를 수행한 결과값이 여러행 여러열 일때
    
    -> 서브쿼리의 구분(열과 행수)에 따라 사용 가능한 연산자가 달라짐.
*/

/*
    1. 단일행 (단일열) 서브쿼리 (SINGLE ROW SUBQUERY)
    서브쿼리의 조회 결과값이 오로지 1개일때
    
    일반 연산자 사용가능(=, !=, >=, <=, > <, ..)
*/
-- 1. 전 직원의 평균 급여보다 더 적게 받는 사원들의 사원명, 직급코드, 급여 조회
SELECT
    emp_name, 
    job_code,
    salary
FROM EMPLOYEE
WHERE SALARY < (SELECT FLOOR(AVG(SALARY)) FROM EMPLOYEE);

-- 2. 최저 급여를 받는 사원의 사번, 사원명, 직급코드, 급여, 입사일 조회
SELECT
    emp_id,
    emp_name,
    job_code,
    salary,
    hire_date
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

--3. 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서코드, 급여 조회
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 노옹철 사원의 급여보다 더 많이 받는 사원들의 사번, 이름, 부서명, 급여 조회
--오라클 전용 구문.
SELECT
    emp_id,
    emp_name,
    dept_title,
    salary
FROM EMPLOYEE, DEPARTMENT
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '노옹철')
AND DEPT_CODE = DEPT_ID(+);

--ANSI 구문
SELECT
    emp_id,
    emp_name,
    dept_title,
    salary
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE SALARY > (SELECT salary FROM EMPLOYEE WHERE EMP_NAME = '노옹철');

-- 부서별 급여 합이 가장 큰 부서 하나만을 조회 부서코드, 부서명 급여의 합.
-- 1) 각 부서별 급여 합 구하기 + 가장 큰 합을 찾기.
SELECT
    dept_code,
    SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT
    MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 1단계를 토대로 서브쿼리 만들기. 
SELECT 
    dept_code,
    dept_title,
    SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))FROM EMPLOYEE GROUP BY DEPT_CODE);

/*
    2. 다중행 서브쿼리(MULTI ROW SUBQUERY)
    서브쿼리의 조회 결과값이 여러행일 경우
    
    -IN(10, 20, 30) 서브쿼리 : 여러개의 결과값 중에서 하나라도 일치하는 것이 있다면 / NOT IN 없다면
    - > ANY(10, 20, 30) 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 클 경우
                                즉, 여러개의 결과값 중에서 가장 작은 값보다 클 경우
    - < ANY(10, 20, 30) 서브쿼리 : 여러개의 결과값 중에서 "하나라도" 작을 경우
                            즉, 여러개의 결과값 중에서 가장 큰 값보다 작을 경우
                            
    - > ALL (10, 20, 30) 서브쿼리 : 여러개의 결과값의 "모든"값 보다 클 경우
                                    즉, 여러개의 결과값 중에서 가장 큰 값보다 클 경우
    - < ALL (10, 20, 30) 서브쿼리 : 여러개의 결과값의 "모든"값 보다 작을 경우
                                즉, 여러개의 결과값 중에서 가장 작은 값보다 더 작을 경우
*/
-- 각 부서별 최고 급여를 받는 사원의 이름, 직급코드, 급여조회.
-- 1) 각 부서별로 최고급여 조회(여러행, 단일열)
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 위의 급여를 바탕으로 사원들 조회
SELECT
    *
FROM EMPLOYEE
 WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000, 2550000);

-- 위의 두 쿼리문을 하나로 합치기
SELECT
    *
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)FROM EMPLOYEE GROUP BY DEPT_CODE);

-- 1. 선동일 또는 유재식 사원과 같은 부서인 사원들을 조회하시오 (사원명, 부서코드, 급여)
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN(SELECT DEPT_CODE FROM EMPLOYEE WHERE EMP_NAME IN('선동일', '유재식'));
-- 2. 이오리 또는 하동운 사원과 같은 직급인 사원들을 조회하시오(사원명, 직급코드, 부서코드, 급여)
SELECT
    emp_name,
    job_code,
    dept_code,
    salary
FROM EMPLOYEE
WHERE JOB_CODE IN(SELECT JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '이오리' OR EMP_NAME = '하동운');

-- 사원 < 대리 < 과장 < 차장 < 부장
-- 대리 직급임에도 불구하고, 과장 직급의 급여보다 많이 받는 사원들 조회(사번, 직급명, 급여)
-- 1) 과장 직급의 급여들 조회 -> 다중행, 단일열
SELECT
    salary
FROM EMPLOYEE E
JOIN JOB J ON E.JOB_CODE = J.JOB_CODE 
WHERE J.JOB_NAME = '과장';
-- 2) 위 급여들보다 "하나라도" 높은 급여가 있다면 그 직원들 조회.(대리직급만)
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E
LEFT JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '대리' AND
SALARY >= ANY(2200000, 2500000, 3760000);

-- 3)위 두 단계를 합치기
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E
LEFT JOIN JOB J ON E.JOB_CODE = J.JOB_CODE
WHERE JOB_NAME = '대리' AND
SALARY >= ANY(SELECT salary FROM EMPLOYEE E JOIN JOB J ON E.JOB_CODE = J.JOB_CODE WHERE J.JOB_NAME = '과장');

-- 과장 직급임에도 불구하고 "모든" 차장직급의 급여보다도 더 많이 받는 직원 조회(사번, 이름, 직급명, 급여)
SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장' AND SALARY >= ALL(SELECT salary FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME = '차장');

SELECT
    emp_id,
    emp_name,
    job_name,
    salary
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME = '과장' AND SALARY > ALL(SELECT salary FROM EMPLOYEE JOIN JOB USING(JOB_CODE) WHERE JOB_NAME = '차장');

/*
    3. (단일행) 다중열 서브쿼리.
    서브쿼리 조회 결과가 같은 한행이지만, 나열된 컬럼의 갯수가 여러개일 경우.
*/
--하이유 사원과 같은 부서코드, 같은 직급코드에 해당되는 사원들 조회(사원명, 부서코드, 직급코드, 고용일)
-- 1) 하이유 사원의 부서코드와 직급코드 먼저 조회.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME = '하이유';

-- 2) 부서코드가 D5이고, 직급코드가 J5인 사원들을 조회.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND JOB_CODE = 'J5';

-- 3) 위 내용들을 가지고 단일행 서브쿼리문으로 합치기
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT dept_code FROM EMPLOYEE WHERE EMP_NAME = '하이유')
AND JOB_CODE = (SELECT job_code FROM EMPLOYEE WHERE EMP_NAME = '하이유');

-- 4) 단일행 다중열 서브쿼리로 바꾸기.
-- [표현법] (비교할 대상 컬럼1, 비교할 대상 컬럼2 ) = (비교할 값1, 비교할 값 2 => 서브쿼리 형식으로 제시)
-- 비교한 값의 순서를 맞춰줘야함.
SELECT
    emp_name,
    dept_code,
    job_code,
    hire_date
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE FROM EMPLOYEE WHERE EMP_NAME = '하이유');

-- 박나라 사원과 같은 직급코드, 같은 사수사번을 가진 사원들의 사번, 이름, 직급코드, 사수사번 조회.
-- 다중열 서브쿼리로 작성
SELECT 
    emp_id,
    emp_name,
    job_code,
    manager_id
FROM EMPLOYEE
WHERE(JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID FROM EMPLOYEE WHERE EMP_NAME = '박나라');

/*
    4. 다중행 다중 열 
    서브쿼리 조회 결과가 여러행 여러열인 경우
*/
-- 각 직급별 최소급여를 받는 사원들 조회(사번, 이름, 직급코드, 급여)
--1) 각 직급별 최소 급여를 조회.
SELECT
    job_code,
    MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 위의 목록들중 일치하는 사원.
-- 2-1) OR 연산자 활용.
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
--2) IN 연산자 활용
SELECT
    emp_id, 
    emp_name,
    job_code,
    salary
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT job_code, MIN(SALARY) FROM EMPLOYEE GROUP BY JOB_CODE);

--각 부서별 최고급여를 받는 사원들 조회(사번, 이름, 부서코드, 급여)
-- 부서가 없을 경우 없음 이라는 부서로 통일해서 조회
-- 1) 각 부서별 최고 급여 조회
SELECT 
    NVL(DEPT_CODE, '없음'),
    MAX(SALARY) 
FROM EMPLOYEE 
GROUP BY DEPT_CODE;

--2) 위의 조건을 만족하는 사원 추리기
SELECT
    emp_id,
    emp_name,
    NVL(dept_code, '없음'),
    salary
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE, '없음'), SALARY) IN(
    ('없음', 2890000),
    ('D1', 3660000), 
    ('D9', 8000000), 
    ('D5', 3760000), 
    ('D6', 3900000), 
    ('D2', 2490000), 
    ('D8', 2550000)
);
    
-- 3) 다중행 다중열 서브쿼리로 변경
SELECT
    emp_id,
    emp_name,
    NVL(dept_code, '없음'),
    salary
FROM EMPLOYEE
WHERE (NVL(dept_code, '없음'), SALARY) IN(SELECT NVL(DEPT_CODE, '없음'), MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);

/*
    5. 인라인 뷰(INLINE VIEW)
    FROM절에 서브쿼리를 제시하는것.
    
    서브쿼리를 수행한 결과(RESULTSET)을 테이블 대신 사용하는방법.
*/
--보너스 포함 연봉이 3000만원 이상인 사원들의 사번, 이름, 보너스포함 연봉, 부서코드를 조회.
SELECT
    emp_id,
    emp_name,
    (salary+(salary*NVL(bonus,0))) *12 AS "보너스 포함 연봉",
    dept_code
FROM EMPLOYEE
WHERE (salary+(salary*NVL(bonus,0))) *12 >= 30000000;
--인라인 뷰를 사용 : 사원명만 골라내기(보너스포함연봉이 3000만원 이상인 사원들중에)
SELECT
    emp_name
FROM (
        SELECT
            emp_id,
            emp_name,
            (salary+(salary*NVL(bonus,0))) *12 AS "보너스 포함 연봉",
             dept_code,
             job_code
        FROM EMPLOYEE
        WHERE (salary+(salary*NVL(bonus,0))) *12 >= 30000000
    )B
WHERE B.DEPT_CODE IS NULL;
--WHERE B.JOB_CODE = 'J1';

--인라인뷰를 주로 사용하는 예
-- TOP-N 분석 : 데이터베이스 상에 있는 자료중 최상위 N개의 자료를 보기위해 사용하는 기능.

-- 전 직원중에 급여가 가장높은 상위 5명(순위, 사원명, 급여)
-- *ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT
    ROWNUM,
    emp_name,
    salary
FROM EMPLOYEE -- 1
--WHERE ROWNUM <= 5 -- 2
ORDER BY SALARY DESC;

-- 해결 방법 : ORDER BY로 정렬한 테이블을 가지고 ROWNUM 순번을 부여후 5등까지만 추림.
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

-- 각 부서별 평균급여가 높은 3개의 부서의 부서코드, 평균 급여 조회.
-- 1)각 부서별 평균 급여 구하기
SELECT 
    FLOOR(AVG(salary))
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- 2) 각 부서별 평균급여 정렬
SELECT 
    dept_code,
    FLOOR(AVG(salary))
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY FLOOR(AVG(salary)) DESC;
-- 3) 가장 높은 부서 3개 추리기
SELECT
    ROWNUM,
    --dept_code,
    --"FLOOR(AVG(SALARY))" --1번 사용 권장하지 않음
    --"평균급여" --21ㅓㄴ 방법 권장
    E.* -- 3번 방법
FROM(
       SELECT 
        dept_code,
        FLOOR(AVG(SALARY)) --AS "평균급여"
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY FLOOR(AVG(SALARY)) DESC
    )E
WHERE ROWNUM <= 3;
-- ROWNUM 컬럼을 이용해서 순위를 매길수 있다.
-- 다만, 정렬이 되지 않은 상태에서는 순위를 매기면 의미가 없으므로
-- 선 정렬 후 순위매기기를 해야한다. -> 우선적으로 인라인뷰로 ORDER BY 정렬을 하고, 메인쿼리에서 순번을 붙인다.

--가장 최근에 입사한 5명 조회(사원명, 급여, 입사일)
-- 입사일 기준 미래 ~ 과거(내림차순), 순번 부여후 5명
SELECT
    ROWNUM,
    E.* -- 인라인뷰에서 *을 사용하려면 반드시 별칭이 부여되어있어야함.
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
    6. 순위 매기는 함수(WINDOW FUNCTION)
    RANK() OVER(정렬 기준) : 공동 1위가 3이라고 하면 그 다음 순위는 4위로 하겠다.
    DENSE_RANK() OVER(정렬기준) : 공동 1위가 3이라고 하면 그 다음 순위는 2위로 하겠다.
    
    정렬 기준 : ORDER BY 절(정렬기준 컬럼명, 오름차순/내림차순), NULL FIRST/LAST는 사용불가.
    
    SELECT절에서만 기술가능.
*/
-- 사원들의 급여가 높은 순서대로 매겨서 사원명, 급여, 순위 조회 : RANK() OVER
SELECT
    emp_name,
    salary,
    RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;

-- 사원들의 급여가 높은 순서대로 매겨서 사원명, 급여, 순위 조회 : DENSE_RANK() OVER
SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;

SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE
WHERE DENSE_RANK() OVER(ORDER BY SALARY DESC) <= 5;

--인라인뷰를 통해 해결가능.
-- 1)RANK함수로 순위를 매기고 (정렬까지 완료)
SELECT
    emp_name,
    salary,
    DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
FROM EMPLOYEE;
-- 2) 위의 결과를 토대로 조회
SELECT
    E.*
FROM(
    SELECT
        emp_name,
        salary,
        DENSE_RANK() OVER(ORDER BY SALARY DESC) AS "순위"
    FROM EMPLOYEE
)E
WHERE 순위 <= 5;