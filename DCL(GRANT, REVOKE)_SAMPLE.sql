-- 3-1.
-- CREATE TABLE 권한 부여받기 전
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- insufficient privileges
-- 불충분한 권한 :  SAMPLE 계정에 테이블을 생성할 수 있는 권한을 안줘서 발생.

-- 3_2.
-- CREATE TABLE 권한을 부여받은 후.
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- no privileges on tablespace 'SYSTEM'
-- TABLESPACE : 테이블이 모여있는 공간
--SAMPLE 계정에는 TABLESPACE가 아직 할당되지 않아서 오류 발생.

-- TABLESPACE 할당받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블 생성 완료.

-- 위 테이블 생성 권한을 부여받게되면
-- 계정이 소유하고 있는 테이블들을 조작(SELECT, INSERT, DELETE, UPDATE .. DML)하는것이 가능해짐.

INSERT INTO TEST VALUES(1);

SELECT * FROM TEST;

-- 4. 뷰 만들기
CREATE VIEW VIEW_TEST
AS SELECT * FROM TEST;
-- insufficient privileges(불충분한 권한)

--권한 부여받은 후
CREATE VIEW VIEW_TEST
AS SELECT * FROM TEST;
-- 뷰 생성 완료.

-- 5. SAMPLE 계정에서 KH계정의 테이블에 접근해서 조회해보기.
SELECT *
FROM KH.EMPLOYEE;
--table or view does not exist
--KH 계정의 테이블에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생

-- SELECT ON 권한 부여 받은 후 조회.
SELECT *
FROM KH.EMPLOYEE;

-- 6. SAMPLE계정에서 KH계정의 DEPARTMENT테이블에 접근해서 행 삽입해보기.
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');
-- KH계정의 DEPARTMENT테이블에 접근해서 삽입할수 있는 권한이 없기때문에 오류 발생.

--권한부여후
INSERT INTO KH.DEPARTMENT VALUES('D0', '회계부', 'L2');

COMMIT;

--7. 테이블 생성
CREATE TABLE TESET2(
    TEST_ID NUMBER
);
-- SAMPLE 계정에서 테이블을 생성할 수 없도록 권한을 회수하였기 때문에 에러발생.