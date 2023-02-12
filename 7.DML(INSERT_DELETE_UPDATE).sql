/*
    DML(DATA MANIPULATION LANGUAGE)
    
    데이터 조작 언어
    
    테이블에 새로운 데이터를 삽입(INSERT)하거나 
    기존의 데이터를 수정(UPDATE)하거나
    삭제(DELETE)하는 구문
*/

/*
    1. INSERT : 테이블에 새로운 행을 추가하는 구문
    
    [표현법]
    INSERT INTO 계열
    
    1)번방법 : INSERT INTO 테이블명 VALUES(값1, 값2, 값3)
    => 해당 테이블에 모든 컬럼에 대해 추가해줘야 할때 사용하는 방법.
    주의사항 : 컬럼의 순서, 자료형, 갯수를 맞춰서 VALUES 괄호안에 값을 나열해야함.
    -부족하게 값을 넣을 경우 : NOT ENOUGH VALUE 오류
    - 값을 더 많이 제시하는 경우 : TOO MANY VALUES 오류
*/
--EMPLOYEE테이블에 사원정보 추가
INSERT INTO EMPLOYEE
VALUES( 900, '홍길동', '990512-1234567', 'ghdrlfehd@iei.or.kr', '01041213393', 'D1', 'J7', 'S2', 5000000, 0.5, 200,
SYSDATE, NULL, DEFAULT  -- DEFAULT값으로 넣어라. 
);
-- value too large for column "KH"."EMPLOYEE"."PHONE" (actual: 13, maximum: 12)
-- 실제 넣으려는 값의 크기(actual) -> 자료형의 크기(maximum)일 경우 발생.

SELECT * FROM EMPLOYEE;
/*
    2번 방법 : INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) VALUES (값1, 값2, 값3)
    -> 해당 테이블에 "특정" 컬러만 선택해서 그 컬럼에 추가할 값만 제시하고자 할때 사용
    
    - 그래도 한 행 단위로 추가되기 때문에 선택이 안된 컬럼은 기본적으로 NULL 값이 들어감.
    - 단, DEFAULT 설정이 되어 있는 경우 기본값이 들어감.
    
    주의사항 : NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 직접 값을 제시해야함.
            다만, DEFAULT 설정이 되어있다면 NOT NULL 이라고 해도 선택 안해도 됨.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES (901, '홍길동2', '980808-1234567', 'D2', 'J2', 'S5', SYSDATE);

/*
    3번 방법 ) INSERT INTO 테이블명 (서브쿼리);
    => VALUES()로 값을 직접 기입하는 것이 아니라
       서브쿼리로 조회한 결과값을 통째로 INSERT하는 구문
       즉 여러행을 한번에 INSERT 할 수 있다.
*/
DROP TABLE EMP_01;
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

-- 전체 사원들의 사번, 이름, 부서명을 조회한 결과를 EMP_01테이블에 통째로 추가.
--1) 조회
SELECT
    emp_id,
    emp_name,
    dept_title
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;

INSERT INTO EMP_01
(
SELECT
    emp_id,
    emp_name,
    dept_title
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
);
SELECT * FROM EMP_01;
ROLLBACK;
/*
    INSERT ALL 계열
    두 개 이상의 테이블에 각각 INSERT 할 때 사용
    조건 : 그때 사용되는 서브쿼리가 동일해야한다.
    
    1) INSERT ALL
        INTO 테이블명1 VALUES(컬럼명, 컬럼명, ...)
        INTO 테이블명2 VALUES(컬럼명, 컬럼명, ...)
            서브쿼리;
*/
-- 새로운 테이블 만들기
--첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명 보관할 테이블
-- 테이블명 : EMP_JOB / EMP_ID, EMP_NAME, JOB_NAME
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(30)
);
--두 번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명 보관할 테이블
-- 테이블명 : EMP_DEPT / EMP_ID, EMP_NAME, DEPT_TITLE
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER, 
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(30)
);

-- 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명, 부서명을 조회
SELECT
    EMP_ID,
    EMP_NAME,
    JOB_NAME,
    DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
JOIN JOB USING(JOB_CODE)
WHERE SALARY >= 3000000;
-- 
INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
    SELECT
        EMP_ID,
        EMP_NAME,
        JOB_NAME,
        DEPT_TITLE
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING(JOB_CODE)
    WHERE SALARY >= 3000000;
SELECT * FROM EMP_DEPT;
/*
    2) INSERT ALL
        WHEN 조건1 THEN
            INTO 테이블명1 VALUES(컬럼명, 컬럼명)
        WHEN 조건2 THEN
            INTO 테이블명2 VALUES(컬럼명, 컬럼명)
            
        서브쿼리
*/

-- 조건을 사용해서 각 테이블에 값 INSERT
-- 새로운 테스트용 테이블 생성
-- 2010년도 기준으로 이전에 입사한 사원들의 사번, 사원명, 입사일, 급여를 담는 테이블(EMP_OLD)
CREATE TABLE EMP_OLD
AS SELECT 
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
    FROM EMPLOYEE
    WHERE 1=0;

-- 2010년도 기준으로 이후에 입사한 사원들의 사번, 사원명, 입사일, 급여를 담는 테이블(EMP_NEW)
CREATE TABLE EMP_NEW
AS SELECT 
        EMP_ID,
        EMP_NAME,
        HIRE_DATE,
        SALARY
    FROM EMPLOYEE
    WHERE 1=0;

-- 1) 서브쿼리 부분
-- 2010년 이전, 이후
SELECT
    EMP_ID,
    EMP_NAME,
    HIRE_DATE,
    SALARY
FROM EMPLOYEE
WHERE HIRE_DATE < '2010/01/01'; -- EMP_OLD(15)
--WHERE HIRE_DATE > '2010/01/01'; -- EMP_NEW(10)

INSERT ALL
    WHEN HIRE_DATE < '2010/01/01' THEN
        INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    WHEN HIRE_DATE > '2010/01/01' THEN
        INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
    
    SELECT
--        EMP_ID,
--        EMP_NAME,
--        HIRE_DATE,
--        SALARY
        * -- *로도 제시가 가능함. 
    FROM EMPLOYEE;

/*
    2. UPDATE
    
        테이블에 기록된 기존의 데이터를 "수정"하는 구문.
        
        [표현법]
        UPDATE 테이블명
        SET 컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,
            컬럼명 = 바꿀값,... --여러개의 컬럼값들을 동시 변경 가능( , 로 나열해야함)
        WHERE  조건; -- WHERE절 생략 가능하나, 생략시 "모든" 행의 데이터가 다 변경되어버림.
*/
-- 복사본 테이블 만든 후 작업.
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;


-- DEPT_COPY 테이블에서 D9부서인 부서명을 전략기획팀으로 수정.
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9'; --조건절 제외시 9개 행이 모두 업데이트됨.
--전체 행의 모든 DEPT_TITLE가 전략기획팀으로 수정되었음.

ROLLBACK; -- 변경사항에 대해서 되돌리는 명령어 : ROLLBACK

SELECT * FROM DEPT_COPY;

-- WHERE절의 조건에 따라 1개 혹은 여러개의 행이 동시에 변경이 가능하다.

-- 복사본테이블 
-- EMPLOYEE테이블로 부터 EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS(값까지 복사)
-- EMP_SALARY
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS FROM EMPLOYEE;
-- 1)EMP_SALARY 테이블에서 노옹철 사원의 급여를 10000000만원으로 변경
UPDATE EMP_SALARY
SET SALARY = 10000000
WHERE EMP_NAME = '노옹철';
-- 2)EMP_SALARY 테이블애서 선동일 사원의 급여를 7000000, 보너스를 0.2로 변경
UPDATE EMP_SALARY
SET SALARY = 7000000,
    BONUS = 0.2
WHERE EMP_NAME = '선동일';
-- 3) 전체 사원의 급여를 기존의 급여에 20% 인상한 금액 변경.
UPDATE EMP_SALARY
SET SALARY = SALARY * 1.2;

SELECT * FROM EMP_SALARY;

/*
    UPDATE 시에 서브쿼리 사용
    서브쿼리를 수행한 결과값으로 기존의 값으로부터 변경하겠다.
    
    - CREATE 시에 서브쿼리사용 : 서브쿼리를 수행한 결과를 테이블 만들때 넣어버리겠다.
    - INSERT 시에 서브쿼리 사용 : 서브쿼리를 수행한 결과를 해당 테이블에 삽입하겠다.
    
    [표현법]
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건; -- 생략가능.
*/

-- EMP_SALARY 테이블에 홍길동 사원의 부서코드를 선동일 사원의 부서코드로 변경.
-- 홍길동 사원의 부서코드 = D1, 선동일 사원의 부서코드 = D9
SELECT
    DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '선동일';

UPDATE EMP_SALARY
SET DEPT_CODE = (SELECT
    DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '선동일')
WHERE EMP_NAME = '홍길동';

SELECT * FROM EMP_SALARY;

-- 방명수 사원의 급여와, 보너스를 유재식 사원의 급여와 보너스 값으로 변경.
-- 단일행 다중열 서브쿼리 (비교할 값1, 비교할 값 2) = (비교할 값1, 비교할 값 2)

UPDATE EMP_SALARY
SET (SALARY, BONUS) = (SELECT
    SALARY,
    BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식')
WHERE EMP_NAME = '방명수';

SELECT * FROM EMP_SALARY;

-- 업데이트 주의사항 : UPDATE 할때도 해당 컬럼에 제약조건을 준수해야한다.

--EMPLOYEE 테이블에서 송종기 사원의 사번은 200으로 변경.
UPDATE EMPLOYEE
SET EMP_ID = 200
WHERE EMP_NAME = '송종기'; --PK제약조건 위배.

UPDATE EMPLOYEE
SET EMP_ID = NULL -- NOT NULL 제약조건 위배.
WHERE EMP_ID = 200;

-- 모든 변경사항을 확정짓는 명령어 : COMMIT;
COMMIT;

/*
    4. DELETE
    
    테이블에 기록된 데이터를 "행" 단위로 삭제하는 구문.
    
    [표현법]
    DELETE FROM 테이블명
    WHERE 조건; -- WHERE 생략가능. 생략시 "모든"행 삭제
*/
--EMPLOYEE테이블에서 모든 행 삭제
DELETE FROM EMPLOYEE;
-- 내용물들이 다지워진것이지 테이블 자체가 지워진것은 아님.

SELECT * FROM EMPLOYEE;

ROLLBACK; -- 롤백시 마지막으로 "커밋"한 시점으로 돌아간다.

-- EMPLOYEE테이블로부터 홍길동, 홍길동2 사원의 정보를 지우기 
DELETE FROM EMPLOYEE
WHERE (EMP_NAME = '홍길동' OR EMP_NAME = '홍길동2');

-- WHERE 조건절에 따라 여러행이 삭제될 수 있음.

COMMIT;

-- DEPARTMENT 테이블로부터 DEPT_ID가 D1인 부서 삭제.
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- 만약에 EMPLOYEE테이블의 DEPT_CODE컬럼에서 외래키로 참조하고 있을경우에
--삭재가 되지 않았을것임. 삭제가 되었다는 말은 즉, 외래키로 사용하고 있지 않다.

ROLLBACK;

/*
    TRUNCATE : 테이블의 전체 행을 모두 삭제할때 사용하는 구문(절삭)
               DELETE구문보다 수행속도가 빠름.
               별도의 조건제시 불가.
               ROLLBACK이 불가능함.
               
    [표현법]
    TRUNCATE TABLE 테이블명;
    
    DELETE 구문과 비교
         TRUNCATE TABLE 테이블명    |        DELETE FROM 테이블명
         ---------------------------------------------------------------
      별도의 조건 제시 불가(WHERE X)  |     특정 조건 제시 가능(WHERE O)
      수행속도가 빠름(상대적으로)      |          수행속도가 느림
        ROLLBACK  불가              |          ROLLBACK 가능
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;

ROLLBACK;

TRUNCATE TABLE EMP_SALARY; -- 잘렸습니다. 라고 표현. 롤백불가.
















