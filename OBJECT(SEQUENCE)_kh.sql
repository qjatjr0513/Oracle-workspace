/*
    <시퀀스 SEQUENCE>
    
    자동으로 번호를 발생시켜주는 역할을 하는 객체(자동번호 부여기)
    정수값을 자동으로 순차적으로 발생시켜줌(연속된 숫자로)
    
    EX) 주차번호, 회원번호, 사번, 게시글 번호 등.
    -> 순차적으로 겹치지 않는 숫자로 채번할때 사용할 예정임.
    
    1. 시퀀스객체 생성구문
    [표현법]
    CREATE SEQUENCE 시퀀스명
    START WITH 시작숫자 => 생략가능, 자동으로 발생시킬 시작점(DEFAULT값은 1)
    INCREMENT BY 증가값 => 생략가능, 한번 시퀀스 증가할때마다 몇씩 증가할건지 결정(DEFAULT값은 1)
    MAXVALUE 최대값 => 생략가능, 최대값 지정
    MINVALUE 최소값 => 생략가능, 최소값 지정
    CYCLE/NOCYCLE => 생략가능, 값의 순한 여부를 결정
    CACHE 바이트크기 / NOCACHHE(기본값) => 생략가능 캐시메모리 여부 지정 캐시 기본값은 20BYTE
    
    * 캐시메모리
    시퀀스로부터 미리 발생될 값들을 생성해서 저장해두는 공간.
    매번 호출할때 마다 새로이 번호를 생성하는것 보단 캐시메모리에 미리 생성된 값들을 가져가 쓰면 훨씬
    빠르게 사용가능. BUT, 접속이 끊기고 재접속시 기존에 생성된 값들은 날라가기때문에 사용에 조심해야함.
*/
CREATE SEQUENCE SEQ_TEST;
-- 현재 접속한 계정이 소유하고 있는 시퀀스에 대한 정보 확인.
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCACHE;
/*
    2. 시퀀스 사용 구문.
    시퀀스명.CURRVAL : 현재 시퀀스의 값(마지막으로 성공적으로 발생된 NEXTVAL 값)
    시퀀스명. NEXTVAL : 현재 시퀀스의 값을 증가시키고, 그 증가된 시퀀스의 값
                    == 시퀀스명.CURRVAL + INCREMENT BY 값만큼 증가된 값.
    
    단, 시퀀스 생성후 첫 NEXTVAL은 START WITH로 지정된 시작값으로 발생함.
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- 오류발생
-- 시퀀스가 생성되고 나서 NEXTVAL을 한번이라도 수행하지않는 이상 CURRVAL을 수행할 수 없다.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;
--LAST_NUMBER : 현재 상황에서 다음 NEXTVAL으로 가져올 수 있는 값.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- 지정한 MAXVALUE값을 초과했기 때문에 에러발생.

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310

/*
    3. 시퀀스 변경
    [표현법]
     ALTER SEQUENCE 시퀀스이름
     INCREMENT BY 증가값 => 생략가능, 한번 시퀀스 증가할때마다 몇씩 증가할건지 결정(DEFAULT값은 1)
     MAXVALUE 최대값 => 생략가능, 최대값 지정
     MINVALUE 최소값 => 생략가능, 최소값 지정
     CYCLE/NOCYCLE => 생략가능, 값의 순한 여부를 결정
     CACHE 바이트크기 / NOCACHHE(기본값) => 생략가능 캐시메모리 여부 지정 캐시 기본값은 20BYTE
     
     => START WITH는 변경불가 => 진짜 바꾸고 싶으면 삭제하고 다시 생성해야됨.
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
--중간에 시퀀스가 변경되었더라도 CURRVAL은 그대로 유지된다.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320

--SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;
-----------------------------------------------------
-- 매번 새로운 사번이 발생되는 시퀀스 생성(시퀀스명 : SEQ_EID)
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 400;

--사원이 추가될때 실행할 INSERT문
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동', '111111-1111111', 'J1', 'S1', SYSDATE); 

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동2', '111111-1111111', 'J1', 'S1', SYSDATE); 







