/*
    <PROCEDURE>
    PL/SQL구문을 저장해서 이용하는 객체
    필요할때마다 내가 작성한 PL/SQL문을 편하게 호출 가능하다.
    
    프로시저 생성방법
    [표현식]
    CREATE [OR REPLACE] RROCEDURE 프로시저명[(매개변수(생략가능)))]
    IS
    BEGIN
        실행할 코드
    END;
    
    프로시저 실행방법
    EXEC 프로시저명;
*/
-- EMPLOYEE 테이블에서 모든 데이터를 복사한 COPY테이블 생성.
--PRO_TEST
CREATE TABLE PRO_TEST
AS SELECT * FROM EMPLOYEE;

SELECT * FROM PRO_TEST;

CREATE PROCEDURE DEL_DATA
IS
-- 지역변수선언 DECLARE
BEGIN
    DELETE FROM PRO_TEST;
    COMMIT;
END;
/

SELECT * FROM USER_PROCEDURES;

EXEC DEL_DATA;

ROLLBACK; -- 데이터 돌아오지 않음.
-- 프로시저에 매개변수 넣기
-- IN : 프로시저 실행시 필요한 값을 "받는"변수(자바에서 선언한 매개변수와 동일)
-- OUT : 호출한 곳으로 되돌려 주는 변수(결과값)
CREATE OR REPLACE PROCEDURE PRO_SELECT_EMP(
    EID IN EMPLOYEE.EMP_ID%TYPE,
    ENAME OUT EMPLOYEE.EMP_NAME%TYPE,
    SAL OUT EMPLOYEE.SALARY%TYPE,
    BONUS OUT EMPLOYEE.BONUS%TYPE
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, BONUS
    INTO ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = EID;
END;
/
-- 매개변수가 있는 프로시저 실행;
VAR EMP_NAME VARCHAR2(20); -- VAR는 오라클에서 변수를 선언할때 사용
VAR SALARY NUMBER;
VAR BONUS NUMBER;

EXEC PRO_SELECT_EMP(200,:EMP_NAME, :SALARY, :BONUS );

PRINT EMP_NAME;
PRINT SALARY;
PRINT BONUS;
/*


    프로시져 장점
    1. 처리속도가 빠름(효율적으로 작성했다는 가정하에)
    2. 대량 자료처리시 유리함
    EX) DB에서 대용량의 데이터를 SELECT문으로 받아와서 자바에서 작업을 하는 경우 VS
        DB에서 대용량대이터를 SELECT한 후 자바로 넘기지 않고 직접 처리하는 경우, DB에서 처리하는게 
        성능이 더 좋다.(자바로 데이터 넘길때 네트워크비용발생)
    
    프로시져 단점.
    1. DB자원을 직접 사용하기 때문에 DB에 부하를 주게 됨. (남용하면 안됨)
    2. 관리적 특면에서 자바의 소스코드, 오라클 코드를 동시에 형산관리하기 어렵다.
    
    정리) 
    한번에 처리되는 데이터량이 많고 성능을 요구하는 처리는 대체로 자바보다는 DB상에서
    처리하는것이 성능측면에서는 나을것이고, 소스관리(유지보수)측면에서는 자바로 처리하는게 더 좋다.
*/
-------------------------------------------------------------------------------------
/*
    <FUNCTION>
    프로시저와 유사하지만 실행 결과를 반환(돌려)받을 수 있음.
    
    FUNCTION 생성방법
    [표현식]
    CREATE [OR REPLACE] FUNCTION 프로시저명[(매개변수)]
    RETURN 자료형
    IS
    [DECLARE]
    BEGIN
        실행부분
    [EXCEPTION]
    END;
    /
*/
CREATE OR REPLACE FUNCTION MYFUNC(V_STR VARCHAR2)
RETURN VARCHAR2
IS 
    RESULT VARCHAR2(1000);
BEGIN
    DBMS_OUTPUT.PUT_LINE(V_STR);
    RESULT := '<'||V_STR||'>';
    
    RETURN RESULT;
END;
/

SELECT MYFUNC('홍길동') FROM DUAL;
-- 내가 원하는 FUNCTION을 만들어서 사용 가능

-- EMP_ID을 전달받아서 연봉을 계산해서 출력해주는 함수 만들기
CREATE OR REPLACE FUNCTION CALC_SALARY(EID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    SAL NUMBER;
    BONUS NUMBER;
BEGIN
    SELECT SALARY, BONUS
        INTO SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = EID;
    
    RETURN (SAL+ SAL* NVL(BONUS,0)) * 12;
END;
/
--특정 연봉 조회
SELECT CALC_SALARY(&사번) FROM DUAL;

--전체 연봉 조회
SELECT CALC_SALARY(EMP_ID) FROM EMPLOYEE;










                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
