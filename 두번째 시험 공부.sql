-- EMPLOYEE 테이블에서 JOB_CODE가 J1이거나 J3이거나
--SALARY가 200만원 이상이고, BONUS가 있고, 남자인 사원의 
--EMP_NAME, EMP_NO, DEPT_CODE, SALARY를 조회.

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J3' OR DEPT_CODE = 'J1' AND SALARY > 2000000
AND NVL(BONUS, 0);

--문제점을 찾고

--문제점을 해결하는 코드
SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J3' OR JOB_CODE = 'J1') AND SALARY >= 2000000
AND NVL(BONUS, 0)!= 0 AND SUBSTR(EMP_NO, 8, 1) IN ('1', '3'); -- NVL(BONUS, 0)!= 0 -> 0과 같지 않을때만 BONUS를 가져옴

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J3' OR JOB_CODE = 'J1') AND SALARY >= 2000000
AND BONUS IS NOT NULL AND SUBSTR(EMP_NO, 8, 1) IN ('1', '3');
------------------------------------------------------------------
-- 1. 계정이 생성되지 않는 케이스
-- 2. 계정생성은 완료했지만, 접속이 안되는 케이스 
-- 3. 접속까진 했는데, 테이블생성이 안된 케이스
CREATE USER 사용자이름 IDENTIFIED BY 비밀번호; --1번 케이스
--현재 계정을 만든 상태.

--접속하려고하면 오류가날거에요.

-- 오류를 해결하려면 어떤조치를 취해야되나 ?
GRANT CONNECT, RESOURCE TO 사용자이름; -- RESOURCE는 객체 생성할 수 있는 권한(테이블a 생성, 수정, 삽입 권한 부여) --2번 케이스
--RESOURCE 권한 부여 --3번 케이스
---------------------------------------------------------------------------
-- 서술형 공부 키워드 위주 --

-- 1. RANK() OVER VS DENSE_RANK()의 차이점과 각 매서드에 대해 서술하시오.
-- 2. DENSE_RANK() OVER
    --RANK() OVER(정렬 기준) : 공동 1위가 3이라고 하면 그 다음 순위는 4위로 하겠다.
    --DENSE_RANK() OVER(정렬기준) : 공동 1위가 3이라고 하면 그 다음 순위는 2위로 하겠다.
    
-- 3. SELECT ? DML ? DDL ? TCL(Transactio Control Language) : 트랜젝션 제어, ROLLBACK, COMMIT ?
    --<SELECT>
    --데이터를 조회하거나 검색할 때 사용하는 명령어.
    
    --DML(DATA MANIPULATION LANGUAGE)
    --데이터 조작 언어
    --테이블에 새로운 데이터를 삽입(INSERT)하거나 
    --기존의 데이터를 수정(UPDATE)하거나
    --삭제(DELETE)하는 구문
    
    -- DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    --오라클에서 제공하는 객체(OBJECT)를
    --새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 명령문.
    --즉, 구조 자체를 정의하는 언어로 DB관리자, 설계자가 사용함.

    --TCL(Transaction Control Language) : 트랜젝션 제어, ROLLBACK, COMMIT

-- 4. 오라클 전용 구문으로 작성된 쿼리문 -> ANSI 구문으로 변경
----> 오라클 전용 구문
--SELECT 
--    DEPT_ID,
--    DEPT_TITLE,
--    LOCAL_CODE,
--    LOCAL_NAME
--FROM DEPARTMENT, LOCATION 
--WHERE LOCATION_ID = LOCAL_CODE;
----> ANSI 구문
--SELECT 
--    DEPT_ID,
--    DEPT_TITLE,
--    LOCAL_CODE,
--    LOCAL_NAME
--FROM DEPARTMENT 
--JOIN LOCATION  ON(LOCATION_ID = LOCAL_CODE);

-- 5. 특정 테이블 특정 컬럼에 제약조건을 추가하시오.
--CREATE TABLE MEM_CHECK(
--    MEM_NO NUMBER NOT NULL, 
--    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE, -- 컬럼레벨방식,
--    MEM_PWD VARCHAR2(20) NOT NULL,
--    MEM_NAME VARCHAR2(20) NOT NULL,
--    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
--    PHONE VARCHAR2(15),
--    EMAIL VARCHAR2(30),
--    MEM_DATE DATE NOT NULL -- 회원가입일
--);


-- 6. SELECT문이란?
-- <SELECT>
--    데이터를 조회하거나 검색할 때 사용하는 명령어.
--    
--    - RESULT SET : SELECT 구문을 통해 조회된 데이터의 결과물을 의미.
--                    즉, 조화된 행동의 집합.
--    
--    [표현법]
--    SELECT 조회하고자 하는 컬럼명, 컬럼명2, 컬럼명3 .....
--    FROM 테이블명;

-- 7. PRIMARY KEY ?? <- 제약조건들 전부., FOREIGN KEY, NOT NULL
--    PRIMARY KEY(기본키) 제약조건
--    테이블에서 각 행들의 정보를 유일하게 식별 할 수 있는 컬럼에 부여하는 제약조건.
--    => 각 행들을 구분할 수 있는 식별자의 역할.
--    예) 사번, 부서아이디, 직급코드, 회원번호 ...
--    => 식별자의 조건 : 중복되어서는 안됨, 값이 없으면 안됨 => (NOT NULL + UNIQUE)

--    주의사항 : 한 테이블 당 한개의 컬럼값만 기본키로 지정 가능.

--        5. FOREIGN KEY (외래키)
--        해당 컬럼에 다른 테이블에 존재하는 값만 들어와야 하는
--        컬럼에 부여하는 제약조건
--        => "다른테이블(부모 테이블)을 참조한다"라고 표현
--            즉, 참조된 다른테이블(부모 테이블)이 제공하는 있는 값만 들어올 수 있다.

--    1. NOT NULL 제약조건
--    -> 즉, NULL값이 절대 들어와서는 안되는 컬럼에 부여하는 제약조건
--        삽입 / 수정 시 NULL값을 허용하지 않도록 제한하는 제약조건
--        주의사항 : 컬럼레벨 방식밖에 안됨.
--    해당컬럼에 반드시 값이 존재해야만 할때 사용.


-- 2) 제약조건 추가 / 삭제
--    2-2) 제약조건 추가
--    
--    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
--    -FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
--    
--    -UNIQUE : ADD UNIQUE(컬럼명)
--    -CHECK : ADD CHECK(컬럼에 대한 조건);
--    -NOT NULL : MODIFY 컬럼명 NOT NULL;
--    
--    나만의 제약조건명 부여하고자 한다면
--    CONSTRAINT 제약조건명 앞에다가 붙이면됨.
--    -> CONSTRAINT 제약조건명은 생략가능했음.
--    -> 주의사항 : 현재 계정내 고유한 이름으로 부여해야함.
--*/
--
----DEPT_COPY테이블로부터 
----DEPT_ID 컬럼에 PRIMARY_KEY 제약조건추가
----DEPT_TITLE 컬럼애 UNIQUE 제약조건추가
----LNAME컬럼에 NOT NULL 제약조건 추가.
--ALTER TABLE DEPT_COPY
--ADD PRIMARY KEY(DEPT_ID)
--ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
--MODIFY LNAME NOT NULL;

--EMPLOYEE_COPY3에 외래키(DEPT_CODE)를 추가 (외래키 이름 : ECOPY_FK)
--   이떄 부모테이블은 DEPT_TEST테이블, DEPT_ID를 참조
--ALTER TABLE EMPLOYEE_COPY3 
--ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST(DEPT_ID);

-- 8. INNER JOIN이란?
--    1. 등가조인(EQUAL JOIN) / 내부조인(INNER JOIN)
--    연결시키고자 하는 컬럼의 값이 "일치하는 행들만"조인되서 조회.
--    (==일치하지 않는 값들은 결과에서 제외)
--    => 동등비교연산자 = ("일치한다"라는 조건을 제시함)

-- 9. OUTER JOIN?
--    2. 포괄조인 / 외부조인(OUTER JOIN)
--    
--    테이블간의 JOIN시에 "일치하지 않은 행도" 포함시켜줌.
--    단, 반드시 LEFT/ RIGHT를 지정해야한다. => 기준이되는 테이블을 지정해준다.
--    
--    일치하는행 + 기준이되는 테이블을 기준으로 일치하지 않는 행도 포함시켜서조회시켜줌.

--    1) LEFT OUTER JOIN : 두 테이블중에 왼편에 기술된 테이블을 기준으로 JOIN
--                        즉, 뭐가 되었든 간에 왼편에 기술된 테이블의 데이터는 무조건 조회.

-- 10. CHAR와 VARCHAR2 차이점
--  문자 (CHAR(크기)/VARCHAR2(크기)) : 크기는 BYTE단위임. (숫자, 영어, 특수문자 -> 글자당 1 BYTE),
--            
--            CHAR(바이트수) : 최대 2000BYTE까지 지정 가능.
--                            고정길이(아무리 작은 값이 들어와도 공백으로 채워서 처음 할당한 크기를 유지함)
--                            주로 들어올 값의 글자수가 정해져 있을 경우 사용
--                            EX) 성별 : M/F, 주민번호 : 14글자
--                    
--            VARCHAR2(바이트수) : 최대 4000BYTE까지 지정 가능
--                               가변길이(적은값이 들어올 경우 그 담긴 값에 맞춰 크기가 줄어든다.)
--                               VAR는 '가변' , 2는 2배를 의미한다.
--                               주로 들어올 값의 글자수가 정해지지 않은 경우 사용.
--                               EX) 이름 , 아이디 , 비밀번호 등등등.

-- 11. DATA DICTIONARY? <-- DDL(CREATE)파일
--테이블 확인방법
-- 1) 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고있는 시스템 테이블.
--    SELECT *
--    FROM USER_TABLES;

--      데이터 사전에는 데이터베이스의 데이터를 제외한 모든 정보가 있고, 이것의 내용을 변경하는 권한은 시스템에만 있음.
--      읽기전용테이블로서 조회만 가능.

-- 12. 문자열데이터(221225) -> 2022년 12월 25일로 표현할 수 있도록 형변환 함수를 이용해라.
SELECT
    TO_CHAR(TO_DATE('221225', 'YYMMDD') , 'YYYY"년" MM"월" DD"일"')
FROM DUAL;

-- 13. NVARCHAR--> 문자를 셀때 문자의 갯수자체를 길이로 취급하는 함수. 유니코드를 지원하기 위한 자료형
--     NVARCHAR(50) -> '민' --> 1BYTE로 취급

-- 14. DDL create? DML delete문, DML UPDATE, DML INSERT ? 
--    < CREATE TABLE >
--    테이블 : 행(ROW), 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체 종류 중 하나.
--            모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 하려면 무조건 테이블을 만들어야함)
--            
--    [표현법]
--    CREATE TABLE 테이블명 (
--    컬럼명 자료형,
--    컬럼명 자료형,
--    컬럼명 자료형,
--    NAME DATE
--    ...
--    )
--    
--    4. DELETE
--    
--    테이블에 기록된 데이터를 "행" 단위로 삭제하는 구문.
--    
--    [표현법]
--    DELETE FROM 테이블명
--    WHERE 조건; -- WHERE 생략가능. 생략시 "모든"행 삭제
--    
--    2. UPDATE
--    
--        테이블에 기록된 기존의 데이터를 "수정"하는 구문.
--        
--        [표현법]
--        UPDATE 테이블명
--        SET 컬럼명 = 바꿀값,
--            컬럼명 = 바꿀값,
--            컬럼명 = 바꿀값,... --여러개의 컬럼값들을 동시 변경 가능( , 로 나열해야함)
--        WHERE  조건; -- WHERE절 생략 가능하나, 생략시 "모든" 행의 데이터가 다 변경되어버림.
--    
--    1. INSERT : 테이블에 새로운 행을 추가하는 구문
--    
--    [표현법]
--    INSERT INTO 계열
--    
--    1)번방법 : INSERT INTO 테이블명 VALUES(값1, 값2, 값3)
--    => 해당 테이블에 모든 컬럼에 대해 추가해줘야 할때 사용하는 방법.
--    주의사항 : 컬럼의 순서, 자료형, 갯수를 맞춰서 VALUES 괄호안에 값을 나열해야함.
--    -부족하게 값을 넣을 경우 : NOT ENOUGH VALUE 오류
--    - 값을 더 많이 제시하는 경우 : TOO MANY VALUES 오류
    
-- 15. NVL 함수? NVL 활용하여 쿼리문 작성
--    <NULL 처리 함수>
--    --NVL(컴럼명, 해당 컬럼값이 NULL일 경우 반환할 반환값)
--    --해당 컬럼값이 존재할 경우(NULL이 아닌경우) 기존의 컬럼값이 반환.
--    --해당 컬럼값이 존재하지 않을 경우(NULL인 경우) 내가 제시한 특정값을 반환.

-- 16. CHAR(2000) <- 이건 무슨뜻인가?
-- CHAR(바이트수) : 최대 2000BYTE까지 지정 가능.
-- (숫자, 영어, 특수문자 -> 글자당 1 BYTE)

-- 17. 자료형중 NUMBER(5,1) <- 무엇을 의미하는가?
--     NUMBER(5,1) - 최대 5자리, 소수점 1자리를 허용함.

--------------------------------------------------------------------------------------------------------
-- ROLLUP, CUBE













