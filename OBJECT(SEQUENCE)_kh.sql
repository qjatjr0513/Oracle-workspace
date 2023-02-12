/*
    <������ SEQUENCE>
    
    �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü(�ڵ���ȣ �ο���)
    �������� �ڵ����� ���������� �߻�������(���ӵ� ���ڷ�)
    
    EX) ������ȣ, ȸ����ȣ, ���, �Խñ� ��ȣ ��.
    -> ���������� ��ġ�� �ʴ� ���ڷ� ä���Ҷ� ����� ������.
    
    1. ��������ü ��������
    [ǥ����]
    CREATE SEQUENCE ��������
    START WITH ���ۼ��� => ��������, �ڵ����� �߻���ų ������(DEFAULT���� 1)
    INCREMENT BY ������ => ��������, �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
    MAXVALUE �ִ밪 => ��������, �ִ밪 ����
    MINVALUE �ּҰ� => ��������, �ּҰ� ����
    CYCLE/NOCYCLE => ��������, ���� ���� ���θ� ����
    CACHE ����Ʈũ�� / NOCACHHE(�⺻��) => �������� ĳ�ø޸� ���� ���� ĳ�� �⺻���� 20BYTE
    
    * ĳ�ø޸�
    �������κ��� �̸� �߻��� ������ �����ؼ� �����صδ� ����.
    �Ź� ȣ���Ҷ� ���� ������ ��ȣ�� �����ϴ°� ���� ĳ�ø޸𸮿� �̸� ������ ������ ������ ���� �ξ�
    ������ ��밡��. BUT, ������ ����� �����ӽ� ������ ������ ������ ���󰡱⶧���� ��뿡 �����ؾ���.
*/
CREATE SEQUENCE SEQ_TEST;
-- ���� ������ ������ �����ϰ� �ִ� �������� ���� ���� Ȯ��.
SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCACHE;
/*
    2. ������ ��� ����.
    ��������.CURRVAL : ���� �������� ��(���������� ���������� �߻��� NEXTVAL ��)
    ��������. NEXTVAL : ���� �������� ���� ������Ű��, �� ������ �������� ��
                    == ��������.CURRVAL + INCREMENT BY ����ŭ ������ ��.
    
    ��, ������ ������ ù NEXTVAL�� START WITH�� ������ ���۰����� �߻���.
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
-- �����߻�
-- �������� �����ǰ� ���� NEXTVAL�� �ѹ��̶� ���������ʴ� �̻� CURRVAL�� ������ �� ����.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;
--LAST_NUMBER : ���� ��Ȳ���� ���� NEXTVAL���� ������ �� �ִ� ��.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;
-- ������ MAXVALUE���� �ʰ��߱� ������ �����߻�.

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310

/*
    3. ������ ����
    [ǥ����]
     ALTER SEQUENCE �������̸�
     INCREMENT BY ������ => ��������, �ѹ� ������ �����Ҷ����� � �����Ұ��� ����(DEFAULT���� 1)
     MAXVALUE �ִ밪 => ��������, �ִ밪 ����
     MINVALUE �ּҰ� => ��������, �ּҰ� ����
     CYCLE/NOCYCLE => ��������, ���� ���� ���θ� ����
     CACHE ����Ʈũ�� / NOCACHHE(�⺻��) => �������� ĳ�ø޸� ���� ���� ĳ�� �⺻���� 20BYTE
     
     => START WITH�� ����Ұ� => ��¥ �ٲٰ� ������ �����ϰ� �ٽ� �����ؾߵ�.
*/
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
--�߰��� �������� ����Ǿ����� CURRVAL�� �״�� �����ȴ�.

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 320

--SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;
-----------------------------------------------------
-- �Ź� ���ο� ����� �߻��Ǵ� ������ ����(�������� : SEQ_EID)
CREATE SEQUENCE SEQ_EID
START WITH 300
INCREMENT BY 1
MAXVALUE 400;

--����� �߰��ɶ� ������ INSERT��
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '111111-1111111', 'J1', 'S1', SYSDATE); 

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿2', '111111-1111111', 'J1', 'S1', SYSDATE); 







