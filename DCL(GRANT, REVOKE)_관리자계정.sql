/*
    DCL(DATA CONTROL LANGUAGE)
    데이터 제어언어.
    
    계정에서 시스템 권한 또는 객체접근권한을 부여(GRANT)하거나 회수하는 언어
    
    - 권한부여(GRANT)
        시스템 권한 : 특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
        객체접근권한 : 특정 객체들에 접근해서 조작할 수 있는 권한
        
    - 시스템 권한
    [표현법]
    GRANT 권한1, 권한2 ... TO 계정명;
    
    - 시스템 권한 종류
    CREATE SESSION : 계정에 접속할 수 있는 권한
    CREATE TABLE : 테이블을 생성할 수 있는 권한
    CREATE VIEW : 뷰를 생성할 수 있는 권한
    CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
    CREATE USER : 계정을 생성할 수 있는 권한.
*/
-- 1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 2. SAMPLE 계정에 접속하기 위한 CREATE SESSION 권한 부여. 
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE 계정에 테이블을 생성할 수 있는 CREATE TABLE 권한부여
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE 계정에 TABLESPACE를 할당해주기(SAMPLE 계정 변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUOTA : 몫 => 나누어주다, 할당한다.
-- 2M : 2 MEGA BYTE

-- 4. SAMPLE 계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;
GRANT CREATE VIEW TO KH;
-- 5. SAMPLE 계정에 KH.EMPLOYEE 테이블을 조회할 수 있는 권한 부여.
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

/*
    - 객체권한
    특정 객체들을 조작할 수 있는 권한.
    조작 : SELECT, INSERT, UPDATE, DELETE => DML
    
    [표현법]
    GRANT 권한종류 ON 특정객체 TO 계정명;
    
    권한종류     |     특정객체
    ------------------------
    SELECT      |    TABLE, VIEW, SEQUENCE
    INSERT      |    TABLE, VIEW
    UPDATE      |    TABLE, VIEW
    DELETE      |    TABLE, VIEW
    
*/
-- 6. SAMPLE계정에 KH.DEPARTMENT테이블에 행을 삽입할 수 있는 권한 부여.
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
 
/*
    < 롤 ROLE>
    특정 권한들을 하나의 집합으로 모아 놓은것.
    
    CONNECT : CREATE SESSION(데이터베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSERT
                (특정 객체들을 생성 및 조작할 수 있는 권한)
*/
--------------------------------------------------------------------------------
/*
    < REVOKE 권한 회수>
    
    [표현법]
    REVOKE 권한1, 권한2 ....... FROM 계정명;
    
    권한을 뺏을때 사용하는 명령어
*/

-- 7. SAMPLE 계정에서 테이블을 생성할 수 있는 권한 회수
REVOKE CREATE TABLE FROM SAMPLE;

--DCL 실습문제 --

-- 사용자에게 부여할 권한 : CONNECT, RESOURCE
-- 권한을 부여받을 사용자는 : MYMY

CREATE USER MYMY IDENTIFIED BY MYMY;
GRANT CONNECT, RESOURCE TO MYMY;







