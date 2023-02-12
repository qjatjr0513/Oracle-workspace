/*
    TCL(TRANSACTION CONTROL LANGUAGE)
    
    트랜잭션 제어 언어
    
    트랜잭션
    - 데이터베이스의 논리적 작업 단위
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션으로 묶어서 처리
    => COMMIT(확정)하기 전까지의 변경사항들을 하나의 트랜잭션으로 담겠다.
    - 트랜잭션의 대상이 되는 SQL문 : INSERT, UPDATE, DELETE
    
    * 트랜잭션 종류
    - COMMIT; (실행시) : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠다는것을의미.
                    실제 DB에  반영시킨 후 트랜잭션은 비워짐 -> 확정
                    
    - ROLLBACK; (실행시) : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하지 않겠단느것을 의미.
                            트랜잭션에 담겨있는 변경사항도 다 삭제한 후 마지막 COMMIT시점으로 돌아감.
                            
    - SAVEPOINT 포인트명; (실행시) : 현재 이 시점에 임시저장점을 정의해둠.
    
    - ROLLBACK TO 포인트명; (실행시) : 전체 변경사항들을 삭제(마지막 COMMIT시점까지 돌려놓음)하는것이 아니라
                                    해당 포인트 지점까지의 트랜잭션을 롤백함.
*/
SELECT * FROM EMP_01;
--사번이 900번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 900;



--사번이 901번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 901;

ROLLBACK;
---------------------------------------------------------------------------------
-- 사번이 200인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 200;

--사번이 800, 이름 홍길동, 부서 총무부인 사원 추가.
INSERT INTO EMP_01
VALUES(800, '홍길동', '총무부');

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK; -- 트랜잭션의 대상이 되는 SQL문 중에 남아있는게 없어서 롤백시켜도 차이가 없음.
--------------------------------------------------------------------------------
-- 1. EMP_01테이블에서 사번이 217, 216, 214인 사원만 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN(214, 216, 217);

SELECT * FROM EMP_01;
-- 2. 3개 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;
-- 3. EMP_01테이블에 사번이 218인 사원 삭제.
DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- 4. EMP_01테이블에 사번 801, 이름 민경민, 부서 인사부인 사원을 추가
INSERT INTO EMP_01 VALUES(801, '홍길동', '인사부');

SELECT * FROM EMP_01; --22명

ROLLBACK TO SP1;
ROLLBACK;
COMMIT;

SELECT * FROM EMP_01; --22명
-- 마지막 COMMIT시점 기준으로 마지막으로 SELECT한 시점과 동일한 결과가 나옴.

--사번이 900, 901 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN(900, 901);

-- 사번이 218번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01; -- 19명

-- 테이블 생성(DDL)
CREATE TABLE TEST(
    TEST_ID NUMBER
);

ROLLBACK;
SELECT * FROM EMP_01;

/*
    주의사항)
    DDL 구문(CREATE, ALTER, DROP)을 실행하는 순간
    기존에 트랜잭션에 있던 모든 변경사항들을 무조건 실제 DB에 반영(== COMMIT)을 시킨 후에 DDL이 수행됨.
    => 즉, DDL 수행전 변경사항이 있다면 정확히 픽스(COMMIT OR ROLLBACK)을 하고  DDL을 실행해야한다.
*/


/*
    비밀번호 변경 처리(비밀번호를 변경해주는 트랜잭션)
    비즈니스 로직
    1. 아이디, 비밀번호 입력해서 본인임을 확인.
    2. 기존의 비밀번호, 새로운 비밀번호 입력.
    3. 기존의 비밀번호, 새로운 비밀번호가 다르다면 변경.
    
*/
-- 1. 아이디와, 비밀번호 입력해서 본인임을 확인.
SELECT MEMBER_ID , MEMBER_PWD
FROM MEMBER
WHERE MEMBER_ID = '사용자가 입력한 아이디' AND MEMBER_PWD = '사용자가 입력한 비밀번호';

-- 2. 기존의 비밀번호 , 새로운 비밀번호를 입력.

-- 3. 기존의 비밀번호, 새로운 비밀번호가 다르다면 변경.
UPDATE MEMBER
SET MEMBER_PWD = '새로운 비밀번호'
WHERE MEMBER_ID = '아이디' AND 
MEMBER_PWD = '기존의 비밀번호'
AND MEMBER_PWD != '새로운 비밀번호'; --없어도됨.

COMMIT;













