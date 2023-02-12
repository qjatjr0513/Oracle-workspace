/*
    <PL/SQL>
    PROCEDURE LANGUAGE EXENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ��ִ� ������ ���
    SQL���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP, FOR, WHILE), ����ó������
    �����Ͽ� SQL�� ������ ����.
    �ټ��� SQL���� �ѹ��� ���డ��(BLOCK ����)
    
    PL/SQL ����
    - [�����(DECLARE)] : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - �����(EXECUTABLE) : BEGIN���� ����, SQL�� �Ǵ� ���(���ǹ�, �ݺ���)���� ������ ����ϴ� �κ�.
    -[����ó����](EXCEPTION) : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ������ �̸� ����� �Ѽ� �ִ� �κ�.
*/
--�����ϰ� ȭ�鿡 HELLO WORLD�� ����غ���
SET SERVEROUTPUT ON;

BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO WOLD');
END;
/

/*
    1. DECLARE �����
       ���� �� ��� �����ϴ� ����(����� ���ÿ� �ʱ�ȭ�� ����)
       �Ϲ�Ÿ�� ����, ���۷��� ����, ROWŸ�� ����
    
       1_1)�Ϲ�Ÿ�� ���� ���� �� �ʱ�ȭ
       [ǥ����] ������ [CONSTANT] �ڷ��� [:=��];
*/
DECLARE
    EID NUMBER; --���
    ENAME VARCHAR2(20); --�̸�
    PI CONSTANT NUMBER := 3.14;
BEGIN

    --EID := 800;
    --ENAME := 'ȫ�浿';
    EID := &���;
    ENAME := '&����̸�';
    
    DBMS_OUTPUT.PUT_LINE('EID : '|| EID); -- EID : 800
    DBMS_OUTPUT.PUT_LINE('ENAME : '|| ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : '|| PI);
END;
/

-- 1-2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ(� ���̺� �Į���� ������Ÿ���� �����ؼ� �� Ÿ������ ����)
-- [ǥ����] ������ ���̺��.�÷���%TYPE;
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    EID := 300;
    ENAME := 'ȫ�浿';
    SAL := 5000000;
    
    SELECT
        EMP_ID, EMP_NAME, SALARY
        INTO EID, ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/
--------------------------�ǽ�����-----------------------------------------
/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLED�� �����ϰ�
    �� �ڷ��� EMPLOYEE(EMP_ID, EMP_NAME, JOB_CODE, SALARY)
            DEPARTMENT(DEPT_TITLE)�� ����.
            
    ����ڰ� �Է��� ����� ����� ���, �����, �����ڵ�, �޿� �μ��� ��ȸ�� ������ ��Ƽ� ����ϱ�.
*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLED DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN

    EID := 300;
    ENAME := 'ȫ�浿';
    JCODE := 'J7';
    SAL := 5000000;
    DTITLED := '�λ������';
    
     SELECT  
        EMP_ID,
        EMP_NAME,
        JOB_CODE,
        SALARY,
        DEPT_TITLE
        INTO EID , ENAME , JCODE , SAL , DTITLED
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLED : ' || DTITLED);
END;
/
-- 1-3) ROWŸ�� ���� ����
--      ���̺��� �� �࿡ ���� ��� �÷����� �Ѳ����� ������ �ִ� ����
--      [ǥ����] ������ ���̺��%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
        INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('����� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || NVL(E.BONUS,0)*100 || '%');
END;
/
-------------------------------------------------------------------------------
/*
    2. BEGIN
    <���ǹ�>
    1) IF ���ǽ� THEN ���೻��
*/
-- ��� �Է¹��� �� �ش� ����� ���,�̸�, �޿�, ���ʽ���(%)�� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ� ����� '���ʽ��� ���޹��� ���� ����Դϴ�.'���.
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME,SALARY,NVL(BONUS,0)
        INTO EID,ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('����� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;

    DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100|| '%');

END;
/

--2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF;(IF ~ ELSE)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME,SALARY,NVL(BONUS,0)
    INTO EID,ENAME,SAL,BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('EID : '||EID);
    DBMS_OUTPUT.PUT_LINE('����� : '||ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : '||SAL);

    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE 
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : '||BONUS*100|| '%');
    END IF;

END;
/
------------------------------------------------------------------------------
DECLARE
    --���۷���Ÿ�Ժ���(EID, ENAME, DTITLE, NCODE)
    --�������÷�(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
    
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
    --�Ϲ�Ÿ�Ժ��� (TEAM �������ڿ�(10)) <= �ؿ���, ������
BEGIN
    --����ڰ� �Է��� ����� ����� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ�� �� ������ ����
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCAL_CODE = LOCATION_ID)
    WHERE EMP_ID = &���;
    --NCODE���� KO�� ��� TEAM�� �ѱ��� ����
    --�װ� �ƴҰ�� TEAM�� �ؿ��� ����.
    IF NCODE = 'KO'
        THEN TEAM := '�ѱ���';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    --���, �̸�, �μ�, �Ҽ�(TEAM)�� ���
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/
--3) IF ���ǽ� THEN ���೻�� ELSIF ���ǽ�2 THEN ���೻�� ... [ELSE ���೻��] END IF;
-- �޿��� 500�����̻��̸� ���
--�޿��� 300�����̻��̸� �߱�
--�׿� �ʱ�
--��¹� : XXX����� �޿������ XX�Դϴ�.
DECLARE
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT EMP_NAME, SALARY
        INTO ENAME, SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000
        THEN GRADE := '���';
    ELSIF SAL >=300000
        THEN GRADE := '�߱�';
    ELSE
        GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(ENAME || '����� �޿������ ' || GRADE || '�Դϴ�.');
END;
/
-- 4) CASE �񱳴���� WHEN ����񱳰�1 THEN �����1 WHEN �񱳰�2 THEN �����2 ELSE �����3 END;
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(20);
BEGIN
    SELECT *
        INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DNAME := CASE EMP.DEPT_CODE 
                WHEN 'D1'THEN '�λ���'
                WHEN 'D2'THEN 'ȸ����'
                WHEN 'D3' THEN '��������'
                WHEN 'D4' THEN '����������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�ؿܿ�����'
            END;
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '�� �μ��� ' || DNAME || '�Դϴ�');
    
END;
/
-------------------------------------------------------------------------------
--�ݺ���
/*
    1) BASIC LOOP��
    [ǥ����]
    LOOP
        �ݺ������� ������ ����;
        
        * �ݺ����� ���������� �ִ� ����
    END LOOP;
    
    *�ݺ����� ���������� �ִ� ����(2����)
    1) IF ���ǽ� THEN EXIT; END IF;
    2) EXIT WHEN ���ǽ�;
*/
-- 1~5���� ���������� 1�� �����ϴ� ���� ���.
DECLARE
    I NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
        EXIT WHEN I = 6;
    END LOOP;
END;
/
/*
    2) FOR LOOP��
    FOR ���� IN �ʱⰪ..������
    LOOP
        �ݺ������� ������ ����;
    END LOOP;
*/
BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
    END LOOP;
END;
/

DROP TABLE TEST;

CREATE TABLE TEST(
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
START WITH 1 --SEQUENCE�� ������ �Ұ�  OR REPLACE ��� �Ұ�
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

BEGIN
    FOR I IN 1..500
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL , SYSDATE);
    END LOOP;
END;
/

-- 3) WHILE LOOP��
/*
    [ǥ����]
    WHILE �ݺ����� ����� ����
    LOOP
         ���� ������ ����
    END LOOP;
*/
DECLARE
    I NUMBER := 1;
BEGIN
    WHILE I < 6
    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I+1;
    END LOOP;
END;
/
-- 4) ����ó����
/*
    ����(EXCEPTION) : ������ �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������2;
        ...
        WHEN OTHERS THEN ����ó������N; -- ������ �̸��� �𸦶� OTHERS ���
        
        *�ý��ۿ���(����Ŭ���� �̸� �����ص� ���� �� 20��)
        - NO_DATA FOUND : SELECT�� ����� �� �൵ ���� ���.
        - TOO_MANY_ROWS : SELECT�� ����� �������� ���.
        - ZERO_DIVIDE : 0���� ������
        - DUP_VAL_ON_INDEX : UNIQUE �������ǿ� ����Ǿ�����.
        ...
*/
-- ����ڰ� �Է��� ���� ������ ������ ����� ���
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 1000 / &����;
    DBMS_OUTPUT.PUT_LINE('��� : ' || RESULT);
EXCEPTION
    --WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0�� ����� �� �����ϴ�.');
      WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0�� ����� �� �����ϴ�.');
END;
/
-- UNOQUE �������� ����.
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = &���
    WHERE EMP_NAME = '������';

EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�.');
END;
/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
        INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = &������;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ʹ� ���� ���� ��ȸ�Ǿ����ϴ�.');
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�����Ͱ� �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��߽��ϴ�.');
END;
/
------------------------------------------------------------------------------
-- 1) ����� ������ ���ϴ� PL/SQL �� �ۼ�, ���ʽ��� �ִ� ����� ���ʽ��� �����Ͽ� ���.
-- ��¹� (�޿� ����̸� ����)
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    YSALARY NUMBER;
BEGIN
    SELECT *
        INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    YSALARY := (EMP.SALARY + EMP.SALARY* NVL(EMP.BONUS,0))*12;
    
    DBMS_OUTPUT.PUT_LINE(EMP.SALARY || ' ' || EMP.EMP_NAME || ' ' || TO_CHAR(YSALARY,'L999,999,999'));
END;
/

-- 2) ������ ¦���� ���
-- 2-1) FOR LOOP �̿�
DECLARE
    I NUMBER := 1;
    J NUMBER := 1;
    RESULT NUMBER;
BEGIN

    FOR I IN 1..9 
    LOOP
    IF MOD(I,2) = 0
        THEN
        DBMS_OUTPUT.PUT_LINE(I || '��');
        FOR J IN 1..9
        LOOP
            RESULT := I*J;
            DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || RESULT);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');
    END IF;
    END LOOP;
END;
/
-- 2-2) WHILE LOOP�̿�
DECLARE
    I NUMBER := 2;
    J NUMBER := 1;
    RESULT NUMBER;
BEGIN
    WHILE  I < 9
    LOOP
        IF MOD(I,2) = 0
            THEN
            J := 1;
            DBMS_OUTPUT.PUT_LINE(I || '��');
            WHILE J <= 9
            LOOP
                RESULT := I * J;
                DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = '||RESULT);
                J := J+1;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE(' ');
        END IF;
        I := I+1;     
    END LOOP;
END;
/

































