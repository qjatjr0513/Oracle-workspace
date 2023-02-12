/*
    <트리거>
    내가 저장한 테이블에 INSERT, UPDATE, DELETE등의 DML문에 의해 변경사항이 생길때
    자동으로 매번 실행할 내용을 미리 정의해둘 수 있는 객체
    
    EX) 회원 탈퇴시 기존의 회원테이블에 데이터 DELETE후 곧바로 탈퇴된 회원들만 따로 보관하는 테이블에 자동으로 INSERT 처리.
    
    신고 횟수가 일정 수를 넘었을때 묵시적으로 해당 회원을 블랙리스트 처리되게끔
    입출고에 대한 데이터가 기록 될때마다 해당 상품에 대한 재고수량을 매번 수정해야할때.
    
    *트리거의 종류    
    SQL문의 시행시기에 따른 분류
    > BEFORE TRIGGER : 내가 지정한 테이블에 이벤트가 발생되기전에 트리거 실행.
    > AFTER TRIGGER : 내가 지정한 테이블에 이벤트가 발생된 후에 트리거 실행.
    
    SQL문에 의해 영향을 받는 각 행에 따른 분류
    > STATEMENT TRIGGER(문장 트리거) : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
    > ROW TRIGGER(행 트리거): 해당 SQL문 실행할때마다 매번 트리거 실행(FOR EACH ROW옵션 기술해야함)
        사용가능 옵션
        > :OLD - BEFORE UPDATE, BEFORE DELETE (수정전 자료)
        > :NEW - AFTER INSERT, AFTER UPDATE (추가된 자료)
        
    * 트리거 생성구문
    [표현식]
    CREATE OR REPLACE TRIGGER 트리거명
    BEFORE|AFTER INSERT|DELETE|UPDATE ON 테이블명
    [FOR EACH ROW]
    DECLARE
        변수선언
    BEGIN
        실행할 내용(해당 위에 지정한 이벤트 발생시 자동으로 실행할 구문)
    EXCEPTION
    END;
    /
*/
-- EMPLOYEE 테이블에 새로운 행이 INSERT될때마다 자동으로 메세지 출력되는 트리거를 정의
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN 
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다.');
END;
/
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, SAL_LEVEL, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '이범석', '111111-1111111', 'D1', 'S1', 'J1', SYSDATE);

SELECT * FROM USER_SEQUENCES;
------------------------------------------------------------------------------------------
-- 상품 입고 및 출고 관련 예시

-- 테이블생성(상품에 대한 데이터를 보관한 테이블) TB_PRODUCT
DROP TABLE TB_PRODUCT;
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
--상품번호 중복 안되게끔 매번 새로운 번호를 발생시키는 시퀀스 생성 SEQ_PCODE
CREATE SEQUENCE SEQ_PCOD -- 시퀀스는 삭제와 수정만 가능 수정하고 싶으면 삭제해야됨
START WITH 200
INCREMENT BY 5
NOCACHE;

SELECT * FROM TB_PRODUCT;

--샘플데이터 추가하기
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '갤럭시Z플립4', '삼성', 1350000, DEFAULT);

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시S10', '삼성', 1000000, 50);

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰13', '애플', 1500000, 20);

SELECT * FROM TB_PRODUCT;

COMMIT;

-- 2. 상품을 입출고를 할때 상세이력을 추가할 테이블 추가(TB_PRODETAIL)
--      어떤 상품이 어떤 날짜에 몇개가 입고 또는 출고가 되었는지를 기록하는 용도.
CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6)CHECK (STATUS IN('입고', '출고')) --상태
);

CREATE SEQUENCE SEQ_DECODE;

-- 200번 상품에 오늘날짜로 10개 재고 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 10, '입고');

SELECT * FROM TB_PRODETAIL;

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 210번 상품이 오늘날짜로 5개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 210, SYSDATE, 5, '출고');

-- 210번 상품의 재고 수량을 5개 감소.
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

--205번 상품이 오늘날짜로 20개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 205, SYSDATE, 20, '입고');

--210번 상품이 재고수량을 20개 증가.
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 210;

ROLLBACK;

-- TB_PRODETAIL 테이블에 INSERT 이벤트 발생시
-- TB_PRODUCT 테이블에 매번 자동으로 재고 수량 UPDATE 되게끔 트리거를 정의.

/*
    - 상품이 입고된 경우 -> 해당하는 상품을 찾아서 재고수량 증가 UPDATE
    UPDATE TB_PRODUCT
        SET STOCK = STOCK + 추가됭 수량(TB_PRODETAIL INSERT테이블에 INSERT시 사용한 값.)
    WHERE PCODE = 입고한 상품번호(TB_PRODETAIL INSERT테이블에 INSERT시 사용한 값.)
    
    -상품이 출고됭 경우 -> 해당상품 찾아가서 재고수량 감소 UPDATE
    UPDATE TB_PRODUCT
        SET STOCK = STOCK - 출고된 수량(TB_PRODETAIL에 INSERT할때 사용한값.)
    WHERE PCODE = 출고한 상품번호
    
*/
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF '입고' = :NEW.STATUS 
    THEN 
        UPDATE TB_PRODUCT
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    ELSE
        UPDATE TB_PRODUCT
        SET STOCK = STOCK - :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/
--, :OLD.STATUS -- INSERT 할때는 :NEW만 사용가능
SELECT * FROM USER_TRIGGERS;

--210번 상품이 오늘날짜로 7개 출고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 210, SYSDATE, 7, '출고');
-- 200번 상품이 오늘날짜로 100개 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 100, '입고');

/*
    트리거 장점
    1. 데이터 추가, 수정, 삭제시 자동으로 데이터관리를 해줌으로써 무결성보장
    2. 데이터베이스 관리의 자동화
    
    트리거 단점
    1. 빈번한 추가, 수정, 삭제시 ROW의 삽입, 추가, 삭제가 함께 실행되므로
    성능상 좋지않음.
    2. 관리적 측면에서 형상관리가 불가능하기때문에 관리하기가 불편하다.
    3. 트리거를 남용하게되는 경우 예상치 못한 사태가 발생할 수 있으며 유지보수가 힘들다.
*/

























