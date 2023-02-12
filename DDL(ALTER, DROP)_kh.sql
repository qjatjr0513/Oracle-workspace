/*
    DDL : 데이터 정의 언어
    
    객체들을 새로게 생성(CREATE), 수정하고, 삭제하는 구문.
    
    1. ALTER
    객제의 구조를 수행하는 구문.
    
    <테이블수정>
    [표현법]
     ALTER TABLE 테이블명 수정할 내용.
     
     -수정할 내용
     1) 컬럼추가 / 수정 / 삭제
     2) 제약조건 추가 / 삭제 => 수정은 불가(수정하고자 한다면 삭제 후 새로이 추가)
     3) 테이블명 / 컬럼명 / 제약조건명 수정
*/
-- 1) 컬럼 추가 / 수정 / 삭제
-- 1-1) 컬럼 추가(ADD) : ADD 추가할 컬럼명 자료형 DEFAULT 기본값. (단, DEFAULT 기본값은 생략 가능)
SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가.
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- 새로운 컬럼이 만들어지고 기본적으로 NULL값으로 채워짐.

--LNAME 컬럼추가 DEFAULT 지정.
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';
-- 새로운 컬럼 추가하고 기본값으로 한국으로 채워짐.

-- 1-2) 컬럼 수정(MODIFY)
--      컬럼의 자료형 수정 : MODIFY 수정할컬럼명 바꾸고자하는 자료형
--      DEFAULT 값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는 기본값.

-- DEPT_COPY테이블의 DEPT_ID 컬럼의 자료형을 CHAR(3)로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- 현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 완전히 다른 타입으로는 변경이 불가능하다.
-- DEPT_COPY 테이블의 DEPT_ID 컬럼의 자료형을 NUMBER로 변경.

ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- column to be modified must be empty to change datatype
-- 현재 변경하고자하는 컬럼에 이미 담겨있는 값과 일치하는 컬럼이거나 혹은 속해있는 컬럼, 그리고 더 큰 바이트의 자료형으로만 변경 가능함
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);
-- ORA-01441: cannot decrease column length because some value is too big

--> 문자 -> 숫자(X) / 문자열에서 사이즈 축소 (X) / 문자열에서 사이즈 확대(O)

-- 한번에 여러개 컬럼 자료형 변경하기
--DEPT_TITLE의 데이터타입을 VARCHAR2(40)으로
--LOCATION_ID의 데이터 타입을 VARCHAR2(2)로
--LNAME컬럼의 기본값을 '미국'
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';

-- 1-3) 컬럼 삭제 (DROP COLUMN) : DROP COLUMN 삭제하고자하는 컬럼명
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

-- DEPT_COPY2 DEPT_ID 삭제.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

--DDL문은 복구가 불가능하다.
ROLLBACK;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- 오류 : cannot drop all columns in a table
-- 테이블에 최소 한개의 컬럼은 존재해야함.

/*
    2) 제약조건 추가 / 삭제
    2-2) 제약조건 추가
    
    - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
    -FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)];
    
    -UNIQUE : ADD UNIQUE(컬럼명)
    -CHECK : ADD CHECK(컬럼에 대한 조건);
    -NOT NULL : MODIFY 컬럼명 NOT NULL;
    
    나만의 제약조건명 부여하고자 한다면
    CONSTRAINT 제약조건명 앞에다가 붙이면됨.
    -> CONSTRAINT 제약조건명은 생략가능했음.
    -> 주의사항 : 현재 계정내 고유한 이름으로 부여해야함.
*/

--DEPT_COPY테이블로부터 
--DEPT_ID 컬럼에 PRIMARY_KEY 제약조건추가
--DEPT_TITLE 컬럼애 UNIQUE 제약조건추가
--LNAME컬럼에 NOT NULL 제약조건 추가.
ALTER TABLE DEPT_COPY
ADD PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME NOT NULL;


/*
    2-2) 제약조건 삭제
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명;
    NOT NULL : MODIFY 컬럼명 NULL;
*/
--DEPT_COPY 테이블로부터 PK에 해당하는 제약조건을 삭제.
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007402;

--DEPT_COPY 테이블로부터 UNIQUE에 해당하는 제약조건을 삭제
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ;

--NOT NULL 제약조건 삭제.
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;

-- 3) 컬럼명 / 제약조건명 / 테이블명 변경

-- 3-1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명.
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
-- DEPT_COPY의 SYS_C007391제약조건을 DEPT_COPY_DI_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007391 TO DEPT_COPY_DI_NN;

-- 3-3) 테이블명 변경 : RENAME 기존테이블명 TO 바꿀테이블명.
--                          기존테이블명 생략가능.(ALTER TABLE에서 기술했으므로 생략가능하다)
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--------------------------------------------------------------------------------------
/*
    2. DROP 
    객체를 삭제하는 구문.
    
    [표현법]
    DROP TABLE 삭제하고자하는 테이블이름;
*/
-- EMP_NEW 테이블 삭제
DROP TABLE EMP_NEW;

-- 부모테이블을 삭제하는 경우에 대한 테스트.
-- 1. DEPT_TEST에 DEPT_ID PRIMARY_KEY 제약조건 추가.
ALTER TABLE DEPT_TEST ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);

--2. EMPLOYEE_COPY3에 외래키(DEPT_CODE)를 추가 (외래키 이름 : ECOPY_FK)
--   이떄 부모테이블은 DEPT_TEST테이블, DEPT_ID를 참조
ALTER TABLE EMPLOYEE_COPY3 
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST(DEPT_ID);

--부모테이블 삭제.(오류 나야 정상)
DROP TABLE DEPT_TEST;
-- unique/primary keys in table referenced by foreign keys

-- 부모테이블 삭제하는 방법
-- 1) 자식테이블을 먼저 삭제한후 부모테이블 삭제한다.
DROP TABLE  자식테이블;
DROP TABLE 부모테이블;

-- 2) 부모테이블만 삭제하되 , 맞물려있는 외래키 제약조건도 함께 삭제한다.
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;





