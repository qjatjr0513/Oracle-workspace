/*
    <SELECT>
    데이터를 조회하거나 검색할 때 사용하는 명령어.
    
    - RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미.
                    즉, 조화된 행동의 집합.
    
    [표현법]
    SELECT 조회하고자 하는 컬럼명, 컬럼명2, 컬럼명3 .....
    FROM 테이블명;
*/

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여 컬럼을 조회
SELECT 
    EMP_ID AS emp_id, -- 컬럼값을 소문자로 작성하는 이유는 자바로 넘겨주기 위한것
    EMP_NAME AS emp_name,
    SALARY AS salary
FROM EMPLOYEE;
-- 명령어, 키워드, 컬럼명, 테이블명은 대소문자를 가리지 않음.
-- 소문자로 해도 무방, 단 컬럼을 제외하곤 대문자로 작성하는 습관 가질것.

SELECT * FROM EMPLOYEE;
-- COLUMN

-- EMPLOYEE테이블의 전체 사원들의 이름, 이메일 휴대폰번호를 조회.
SELECT
    emp_name,
    email,
    phone
FROM EMPLOYEE;

--------------퀴즈---------------
--1. JOB테이블의 모든 컬럼 조회
--방법 1.
SELECT * 
FROM JOB;
--방법 2.
SELECT 
    job_code,
    job_name
FROM JOB;

--2. JOB테이블의 직급명 컬럼만 조회
SELECT 
    job_name
FROM JOB;

--3. DEPARTMENT 테이블의 모든 컬럼 조회
SELECT * FROM DEPARTMENT;

--4. EMPLOYEE 테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회.
SELECT
    emp_name,
    email, 
    phone, 
    hire_date --의미를 알수있게 작성
FROM EMPLOYEE;

--5. EMPLOYEE 테이블의 입사일, 직원명, 급여 컬럼만조회
SELECT
    hire_date,
    emp_name,
    salary
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    조회하고자 하는 컬럼들을 나열하는 SELECT 절에 산술연산(+-/*)을 기술해서 결과를 조회할 수 있다.
*/
-- EMPLOYEE 테이블로 부터 직원명, 월급, 연봉.(월급 * 12)
SELECT 
    emp_name,
    salary,
    salary * 12 AS "연봉"
FROM EMPLOYEE;

-- EMPLOYEE 테이블로 부터 직원명, 월급, 보너스, 보너스가 포함된 연봉(== (월급 +보너스*월급)*12)
SELECT
    emp_name,
    salary,
    bonus,
    (salary + bonus*salary)*12 
FROM EMPLOYEE;
-- 산술연산 과정에서 NULL값이 존재할 경우 산술연산의 결과마저도 NULL이 된다.

-- EMOLOYEE테이블로부터 직원명, 입사일, 근무일수(오늘 날짜 - 입사일) 조회
-- DATE 타입끼리도 연산이 가능(DATE -> 년, 월, 일, 시, 분, 초)
-- 오늘날짜 : SYSDATE
SELECT
    emp_name,
    hire_date,
    SYSDATE "현재시간",
    SYSDATE - HIRE_DATE "근무일수"
FROM EMPLOYEE;

/*
    <칼럼의 별칭 부여하기>
    [표현법]
    1. 컬럼명 AS 별칭
    2. 컬럼명 AS "별칭"  --> 수업에서는 이거 사용
    3. 컬럼명 별칭
    4. 컬럼명 "별칭"
    
    AS를 붙이든 안붙이든 간에 별칭에 특수문자나 띄어쓰기가 포함될시 반드시 ""로 묶어서 표기함.
*/
--EMPLOYEE 테이블로부터 직원명, 월급, 연봉 -> 연봉(보너스 미포함)
SELECT
    emp_name,
    salary AS 급여,
    bonus AS 보너스,
    salary *12 AS "연봉(보너스 미포함)"
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직원명, 월급 -> 급여(월), 보너스, 보너스가 포함된 연봉 -> "보너스가 포함된 연봉"
SELECT
    emp_name,
    salary AS "급여(월)",
    bonus AS 보너스,
    (salary + bonus * salary)*12 AS "보너스가 포함된 연봉"
FROM EMPLOYEE;

/*
    <리터럴>
    임의로 지정한 문자열('')을 SELECT절에 기술하면
    실제 그 테이블에 존재하는 데이터처럼 조회가 가능함.
*/
SELECT 1 AS 숫자, '원' AS 문자열, 0.4 AS 실수
FROM DUAL; --DUAL은 오라클에서 제공하는 임시 테이블

SELECT SYSDATE
FROM DUAL;
-- DUAL은 임시테이블.

-- EMPLOYEE 테이블로부터 사번, 사원명, 급여, 단위(원) 조회하기
SELECT
    emp_id,
    emp_name,
    salary,
    '원' AS 단위
FROM EMPLOYEE;
--SELECT절에 제시한 리터럴 값이 조회결과인 RESULTSET의 모든행에 반복적으로 출력된다.

/*
    <연결연산자>
    여러값들을 마치 하나의 컬럼인것 처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있도록 해주는 연산자.
*/
-- EMPLOYEE의 사번, 이름, 급여를 한테이블로 조회.
SELECT
    emp_id || 
    emp_name ||
    salary
FROM EMPLOYEE;

-- 컬럼값과 리터럴을 연결.
-- ooo 사원의 월급은 00000000원 입니다.
SELECT 
    emp_name || ' 사원의 월급은 '|| salary || '원 입니다.'
FROM EMPLOYEE;

/*
    <DISTINCT>
    조회하고자 하는 칼럼에 중복된 값을 딱 한번만 조회하고자 할때 사용.
    해당 칼럼명 앞에 기술.
    
    [표현법]
    DISTINCT 컬럼명
    (단, SECLECT절에 DISTINCT 구문은 단 한개만 가능하다)
*/
-- EMPLOYEE 테이블에서 부서코드들만 조회
SELECT 
    DISTINCT dept_code
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직급코드들만 조회
SELECT
    DISTINCT job_code
FROM EMPLOYEE;
--DEPT_CODE, JOB_CODE값을 세트로 묶어서 중복 판별
SELECT 
  DISTINCT  dept_code,job_code
FROM EMPLOYEE;
------------------------------------------------------

/*
    <WHERE 절>
    조회하고자 하는 테이블에 특정 조건을 제시해서
    그 조건에 만족하는 데이터들만 조회하고자 할때 기술하는 구문.
    
    [표현법]
    SELECT 조회하고자 하는 칼럼명, ....
    FROM 테이블명
    WHERE 조건식;
    
    실행순서
    FROM -> WHERE -> SELECT
    조건식에 사용가능한 연산자들
    1. 대소비교연산자 -> >, <, >=, <=
    2. 동등비교연산자 -> =, !=
*/
-- EMPLOYEE 테이블로부터 급여가 400만원 이상인 사원들 조회하기.
SELECT *
FROM EMPLOYEE
WHERE SALARY >=4000000;

--EMPLOYEE테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드 급여 조회
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE테이블에서 부서코드가 D9가 아닌 사원들의 사원명, 부서코드 급여 조회
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE <> 'D9';
WHERE DEPT_CODE ^= 'D9';

--------------- 실습문제 ------------------
--1.EMPLOYEE 테이블에서 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회.
SELECT
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
WHERE SALARY >= 3000000;

-- 2. EMPLOYEE 테이블에서 직급 코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

-- 3. EMPLOYEE 테이블에서 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT 
    emp_id,
    emp_name,
    hire_date
FROM EMPLOYEE
WHERE ENT_YN ='Y';

--4. EMPLOYEE 테이블에서 연봉(급여 * 12)이 5000만원 이상인 사원들의 이름, 급여, 연봉, 입사일 조회
SELECT 
    emp_name,
    salary,
    (salary * 12) AS "연봉",
    hire_date
FROM EMPLOYEE
WHERE (salary * 12) >= 50000000;
--> SELECT 절에서 부여한 별칭을 WHERE절에서 사용할 수 없음.

/*
    <논리연산자>
    여러개의 조건을 엮을 때 사용
    
    AND(자바 : &&), OR(자바 : ||)
    AND : ~ 이면서, 그리고
    OR : ~이거나, 또는
*/
-- EMPLOYEE에서 부서코드가 D9이면서 급여가 500만원 이상인 사원들의 이름, 부서코드, 급여 조회.
SELECT 
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;
--부서코드가 D6이거나 급여가 300만원 이상인 사원드의 이름, 부서코드, 급여 조회
SELECT
    emp_name, 
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 30000000;

--급여가 350만원 이상이고, 600만원 이하인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT
    emp_name,
    emp_id,
    salary,
    job_code
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000; 

/*
    <BETWEEN AND>
    몇 이상 몇 이하인 범위에 대한 조건을 제시할때 사용.
    
    [표현법]
    비교할 대상 컬럼명 BETWEEN 하한값 AND 상한값
*/
SELECT
    emp_name,
    emp_id,
    salary,
    job_code
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000; 
--급여가 350만원 미만이고, 600만원 초과인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT
    emp_name,
    emp_id,
    salary,
    dept_code
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;
--자바에서 !(논리부정연산자) 동일 의미다. (NOT은 컬럼의 앞뒤에 작성 가능)

--입사일이 '90/01/01' ~ '03/01/01'인 사원들의 모든 칼럼조회
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';
--입사일이 '90/01/01' ~ '03/01/01'이 아닌 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

/*
    <LIKE '특정패턴'>
    비교하고자 하는 컬럼값이 내가 지정한 특정 패턴에 만족될 경우 조회
    
    [표현법]
    비교할 대상 컬럼명 LIKE '특정패턴'
    
    -옵션 : 특정패턴 부분에 와일드카드인 '%', '_'를 가지고 제시할 수 있다.
    '%' : 0글자 이상.
          비교할 대상 컬럼명 LIKE '문자%' => 컬럼값 중에 '문자'로 시작하는 것을 조회
          비교할 대상 컬럼명 LIKE '%문자' => 컬럼값 중에 '문자'로 끝나는 것을 조회
          비교할 대상 컬럼명 LIKE '%문자%' => 컬럼값 중에 '문자'가 포함되는 것을 조회
          
    '_' : 1글자
          비교대상 컬럼 명 LIKE '_문자' => 해당 컬럼값 중에 '문자'앞에 무조건 1글자가 존재하는 경우 조회
          비교대상 컬럼 명 LIKE '__문자' => 해당 컬럼값 중에 '문자'앞에 무조건 2글자가 존재하는 경우 조회
*/
--성이 진씨인 사원들의 이름, 급여, 입사일 조회
SELECT 
    emp_name,
    salary,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

-- 이름중에 하가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT
    emp_name,
    emp_no,
    dept_code
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

-- 전화번호 4번째 자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일조회.
SELECT
    emp_id,
    emp_name,
    phone,
    email
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--이름 가운데 글자가 '지'인 사원들의 모든 컬럼
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';
--이메일중 _의 앞글자가 3글자인 사원의 사번, 이름, 이메일
SELECT
    emp_id,
    emp_name,
    email
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE '$';
-- 리터럴 값이 _인경우
--와일드 카드로 사용되고 있는 문자와 컬럼값이 동일한 경우 제대로 조회가 안됨(와일드 카드로 인식하기 때문)
--따라서 어떤 구분을 해줘야하는데, 내가 데이터로 취급하고자하는 그 값(_ , %)앞에 나만의 와일드 카드를 제시하고
--ESCAPE OPTION을 등록해야함.

--------------------------------------------------------------------------------
--1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT
    emp_name,
    hire_date
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

--2. 전화번호가 처음 3글자가 010이 아닌 사원들의 이름, 전화번호 조회
SELECT 
    emp_name,
    phone
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';

--3. DEPARTMENT 테이블에서 해외영업과 관련된 부서들의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%';

/*
    <IS NULL>
    해당 값이 NULL인지 비교해준다.
    
    [표현법]
    비교대상 컬럼 IS NULL : 컬럼값이 NULL인 경우
    비교대상 컬럼 IS NOT NULL : 컬럼값 NULL이 아닌 경우
*/
--보너스를 받지 않는 사원들 즉, 보너스값이 NULL인 사번, 이름, 급여, 보너스
SELECT
    emp_id
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE BONUS IS NULL;

--사수가 없는 사원들의 사원명, 사수사번(관리자 사번), 부서코드 조회
SELECT
    emp_name,
    manager_id,
    dept_code
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--사수도 없고, 부서배치도 받지 않은 사원들의 모든 컬럼 조회
SELECT 
    *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- 부서배치는 받지않았지만, 보너스는 받는 사원의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
    <IN>
    비교 대상 컬럼값에 내가 제시한 목록들 중에 하나라도 일치하는 값이 있는지 판단.
    
    [표현법]
    비교대상 컬럼 IN(값1, 값2, 값3 ....)
*/
--부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여
SELECT
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE DEPT_CODE IN('D6', 'D8', 'D5');
--WHERE DEPT_CODE = 'D6' OR DEPT_CODE = 'D8' OR DEPT_CODE = 'D5'; 

--직급 코드가 J1이거나 J3이거나 또는 J4인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE IN('J1', 'J3', 'J4');

--위를 제외한 모든 사원 조회
SELECT *
FROM EMPLOYEE
WHERE NOT JOB_CODE IN('J1', 'J3', 'J4');

/*
    <연산자 우선순위>
    0. ()
    1. 산술연산자
    2. 연결연산자
    3. 비교연산자
    4. IS NULL, LIKE, IN
    5. BETWEEN AND
    6. NOT
    7. AND(논리연산자)
    8. OR(논리연산자)
*/

--직급코드가 J7이거나 J2인 사원들중 급여가 200만원 이상이 사원들의 모든 컬럼 조회.
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE ='J7' OR JOB_CODE ='J2') AND SALARY >= 2000000;
--OR연산자보다 AND 연산자가 항상먼저 실행됨.
--OR연산자 먼저 실행시키고 싶다면 ()로 감싸주기.

---------------------실습문제-----------------------
-- 1. 사수가 없고, 부서배치도 받지 않은 사원들의 (사원명, 사수번호, 부서코드)조회
SELECT
    emp_name,
    manager_id,
    dept_code
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;
-- 2. 연봉(보너스 미포함)이 3000만원 이상이고, 보너스를 받지 않는 사원들의 (사번, 사원명, 급여, 보너스) 조회
SELECT
    emp_id,
    emp_name,
    salary,
    bonus
FROM EMPLOYEE
WHERE BONUS IS NULL AND (SALARY * 12) >= 30000000;
-- 3. 입사일이 '95/01/01' 이상이고 부서배치를 받은 사원들의(사번, 사원명, 입사일, 부서코드) 조회
SELECT
    emp_id,
    emp_name, 
    hire_date,
    dept_code
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL;
-- 4. 급여가 200만원 이상 500만원 이하이고 입사일이 '01/01/01'이상이고 보너스를 받지 않는 사원들의 
--(사번, 사원명, 급여, 입사일, 보너스)조회
SELECT
    emp_id,
    emp_name,
    salary,
    hire_date,
    bonus
FROM EMPLOYEE
WHERE (SALARY BETWEEN 2000000 AND 5000000) AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL;
--5. 보너스포함 연봉이 NULL이 아니고 이름에 하가 포함되어있는 사원들의(사번, 사원명, 급여, 보너스포함 연봉)조회
--연봉에 별칭 부여
SELECT
    emp_id,
    emp_name,
    salary,
    (salary + bonus * salary)*12 AS 연봉
FROM EMPLOYEE
WHERE (salary + bonus * salary)*12 IS NOT NULL AND EMP_NAME LIKE '%하%';
------------------------------------------------------------------------
/*
    <ORDER BY 절>
    SELECT문 가장 마지막에 기입하는 구문 뿐만 아니라 가장 마지막에 실행되는 구문.
    그중 조회된 결과물들에 대해서 정렬 기준을 세워주는 구문
    
    [표현법]
    SELECT 컬럼1, 컬럼2
    FROM 테이블명
    WHERE 조건절
    ORDER BY [정렬기준으로 세우고자 하는 컬럼명/ 별칭/ 컬럼순번] [ASC/DESC][NULLS FIRST/NULLS LAST]
    
        오름차순 / 내림차순
        -ASC : 오름차순(생략시 기본값)
        -DESC : 내림차순
        
        정렬하고자 하는 컬럼값에 NULL이 있는 경우
        -NULLS FIRST : 해당 NULL값들을 앞으로 배치하겠다. (내림차순 정렬인경우 기본값)
        -NULLS LAST : 해당 NULL값들을 뒤로 배치하겠다. (오름차순 정렬인경우 기본값)
*/
--월급이 높은 사람들 부터 나열하고 싶을때.(내림차순)
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

--월급 오름차순
SELECT *
FROM EMPLOYEE
ORDER BY SALARY ASC;

-- 보너스 기준 정렬
SELECT *
FROM EMPLOYEE
--ORDER BY BONUS; --ASC (오름차순) && NULL LAST 기본값.
--ORDER BY BONUS ASC NULLS FIRST;
--ORDER BY BONUS DESC; -- DESC (내림차순) && NULL FIRST 기본값.
ORDER BY BONUS DESC NULLS LAST, SALARY, EMP_ID DESC; 
--> 첫번째로 제시한 정렬기준의 컬럼값이 동일한 경우, 두번째 정렬기준을 가지고 다시 정렬

-- 연봉 기준 오름차순 정렬
SELECT 
    emp_name,
    salary,
    (salary * 12) "연봉"
FROM EMPLOYEE
--ORDER BY "연봉" ASC; --ORDER BY는 마지막에 실행되기 때문에 연봉 사용가능
--ORDER BY (salary * 12) ASC;
ORDER BY 3; -- 컬럼 순번도 사용 가능하다.

--ORDER BY는 숫자뿐만 아니라, 문자열, 날짜 등에 대해서도 정렬 가능하다!





