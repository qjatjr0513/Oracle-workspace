/*
    <Ʈ����>
    ���� ������ ���̺� INSERT, UPDATE, DELETE���� DML���� ���� ��������� ���涧
    �ڵ����� �Ź� ������ ������ �̸� �����ص� �� �ִ� ��ü
    
    EX) ȸ�� Ż��� ������ ȸ�����̺� ������ DELETE�� ��ٷ� Ż��� ȸ���鸸 ���� �����ϴ� ���̺� �ڵ����� INSERT ó��.
    
    �Ű� Ƚ���� ���� ���� �Ѿ����� ���������� �ش� ȸ���� ������Ʈ ó���ǰԲ�
    ����� ���� �����Ͱ� ��� �ɶ����� �ش� ��ǰ�� ���� �������� �Ź� �����ؾ��Ҷ�.
    
    *Ʈ������ ����    
    SQL���� ����ñ⿡ ���� �з�
    > BEFORE TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��Ǳ����� Ʈ���� ����.
    > AFTER TRIGGER : ���� ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����.
    
    SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    > STATEMENT TRIGGER(���� Ʈ����) : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
    > ROW TRIGGER(�� Ʈ����): �ش� SQL�� �����Ҷ����� �Ź� Ʈ���� ����(FOR EACH ROW�ɼ� ����ؾ���)
        ��밡�� �ɼ�
        > :OLD - BEFORE UPDATE, BEFORE DELETE (������ �ڷ�)
        > :NEW - AFTER INSERT, AFTER UPDATE (�߰��� �ڷ�)
        
    * Ʈ���� ��������
    [ǥ����]
    CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER INSERT|DELETE|UPDATE ON ���̺��
    [FOR EACH ROW]
    DECLARE
        ��������
    BEGIN
        ������ ����(�ش� ���� ������ �̺�Ʈ �߻��� �ڵ����� ������ ����)
    EXCEPTION
    END;
    /
*/
-- EMPLOYEE ���̺� ���ο� ���� INSERT�ɶ����� �ڵ����� �޼��� ��µǴ� Ʈ���Ÿ� ����
SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN 
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ�.');
END;
/
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, SAL_LEVEL, JOB_CODE, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '�̹���', '111111-1111111', 'D1', 'S1', 'J1', SYSDATE);

SELECT * FROM USER_SEQUENCES;
------------------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ���� ����

-- ���̺����(��ǰ�� ���� �����͸� ������ ���̺�) TB_PRODUCT
DROP TABLE TB_PRODUCT;
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY,
    PNAME VARCHAR2(30) NOT NULL,
    BRAND VARCHAR2(30) NOT NULL,
    PRICE NUMBER,
    STOCK NUMBER DEFAULT 0
);
--��ǰ��ȣ �ߺ� �ȵǰԲ� �Ź� ���ο� ��ȣ�� �߻���Ű�� ������ ���� SEQ_PCODE
CREATE SEQUENCE SEQ_PCOD -- �������� ������ ������ ���� �����ϰ� ������ �����ؾߵ�
START WITH 200
INCREMENT BY 5
NOCACHE;

SELECT * FROM TB_PRODUCT;

--���õ����� �߰��ϱ�
INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL , '������Z�ø�4', '�Ｚ', 1350000, DEFAULT);

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������S10', '�Ｚ', 1000000, 50);

INSERT INTO TB_PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '������13', '����', 1500000, 20);

SELECT * FROM TB_PRODUCT;

COMMIT;

-- 2. ��ǰ�� ����� �Ҷ� ���̷��� �߰��� ���̺� �߰�(TB_PRODETAIL)
--      � ��ǰ�� � ��¥�� ��� �԰� �Ǵ� ��� �Ǿ������� ����ϴ� �뵵.
CREATE TABLE TB_PRODETAIL(
    DECODE NUMBER PRIMARY KEY,
    PCODE NUMBER REFERENCES TB_PRODUCT,
    PDATE DATE NOT NULL,
    AMOUNT NUMBER NOT NULL,
    STATUS CHAR(6)CHECK (STATUS IN('�԰�', '���')) --����
);

CREATE SEQUENCE SEQ_DECODE;

-- 200�� ��ǰ�� ���ó�¥�� 10�� ��� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 10, '�԰�');

SELECT * FROM TB_PRODETAIL;

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
WHERE PCODE = 200;

COMMIT;

-- 210�� ��ǰ�� ���ó�¥�� 5�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 210, SYSDATE, 5, '���');

-- 210�� ��ǰ�� ��� ������ 5�� ����.
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 210;

--205�� ��ǰ�� ���ó�¥�� 20�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 205, SYSDATE, 20, '�԰�');

--210�� ��ǰ�� �������� 20�� ����.
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 210;

ROLLBACK;

-- TB_PRODETAIL ���̺� INSERT �̺�Ʈ �߻���
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ��� ���� UPDATE �ǰԲ� Ʈ���Ÿ� ����.

/*
    - ��ǰ�� �԰�� ��� -> �ش��ϴ� ��ǰ�� ã�Ƽ� ������ ���� UPDATE
    UPDATE TB_PRODUCT
        SET STOCK = STOCK + �߰��� ����(TB_PRODETAIL INSERT���̺� INSERT�� ����� ��.)
    WHERE PCODE = �԰��� ��ǰ��ȣ(TB_PRODETAIL INSERT���̺� INSERT�� ����� ��.)
    
    -��ǰ�� ���� ��� -> �ش��ǰ ã�ư��� ������ ���� UPDATE
    UPDATE TB_PRODUCT
        SET STOCK = STOCK - ���� ����(TB_PRODETAIL�� INSERT�Ҷ� ����Ѱ�.)
    WHERE PCODE = ����� ��ǰ��ȣ
    
*/
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW
BEGIN
    IF '�԰�' = :NEW.STATUS 
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
--, :OLD.STATUS -- INSERT �Ҷ��� :NEW�� ��밡��
SELECT * FROM USER_TRIGGERS;

--210�� ��ǰ�� ���ó�¥�� 7�� ���
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 210, SYSDATE, 7, '���');
-- 200�� ��ǰ�� ���ó�¥�� 100�� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DECODE.NEXTVAL, 200, SYSDATE, 100, '�԰�');

/*
    Ʈ���� ����
    1. ������ �߰�, ����, ������ �ڵ����� �����Ͱ����� �������ν� ���Ἲ����
    2. �����ͺ��̽� ������ �ڵ�ȭ
    
    Ʈ���� ����
    1. ����� �߰�, ����, ������ ROW�� ����, �߰�, ������ �Բ� ����ǹǷ�
    ���ɻ� ��������.
    2. ������ ���鿡�� ��������� �Ұ����ϱ⶧���� �����ϱⰡ �����ϴ�.
    3. Ʈ���Ÿ� �����ϰԵǴ� ��� ����ġ ���� ���°� �߻��� �� ������ ���������� �����.
*/

























