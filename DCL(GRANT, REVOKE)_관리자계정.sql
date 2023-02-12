/*
    DCL(DATA CONTROL LANGUAGE)
    ������ ������.
    
    �������� �ý��� ���� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ���ϴ� ���
    
    - ���Ѻο�(GRANT)
        �ý��� ���� : Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
        ��ü���ٱ��� : Ư�� ��ü�鿡 �����ؼ� ������ �� �ִ� ����
        
    - �ý��� ����
    [ǥ����]
    GRANT ����1, ����2 ... TO ������;
    
    - �ý��� ���� ����
    CREATE SESSION : ������ ������ �� �ִ� ����
    CREATE TABLE : ���̺��� ������ �� �ִ� ����
    CREATE VIEW : �並 ������ �� �ִ� ����
    CREATE SEQUENCE : �������� ������ �� �ִ� ����
    CREATE USER : ������ ������ �� �ִ� ����.
*/
-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ���� �ο�. 
GRANT CREATE SESSION TO SAMPLE;

-- 3_1. SAMPLE ������ ���̺��� ������ �� �ִ� CREATE TABLE ���Ѻο�
GRANT CREATE TABLE TO SAMPLE;

-- 3_2. SAMPLE ������ TABLESPACE�� �Ҵ����ֱ�(SAMPLE ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUOTA : �� => �������ִ�, �Ҵ��Ѵ�.
-- 2M : 2 MEGA BYTE

-- 4. SAMPLE ������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;
GRANT CREATE VIEW TO KH;
-- 5. SAMPLE ������ KH.EMPLOYEE ���̺��� ��ȸ�� �� �ִ� ���� �ο�.
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

/*
    - ��ü����
    Ư�� ��ü���� ������ �� �ִ� ����.
    ���� : SELECT, INSERT, UPDATE, DELETE => DML
    
    [ǥ����]
    GRANT �������� ON Ư����ü TO ������;
    
    ��������     |     Ư����ü
    ------------------------
    SELECT      |    TABLE, VIEW, SEQUENCE
    INSERT      |    TABLE, VIEW
    UPDATE      |    TABLE, VIEW
    DELETE      |    TABLE, VIEW
    
*/
-- 6. SAMPLE������ KH.DEPARTMENT���̺� ���� ������ �� �ִ� ���� �ο�.
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
 
/*
    < �� ROLE>
    Ư�� ���ѵ��� �ϳ��� �������� ��� ������.
    
    CONNECT : CREATE SESSION(�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, SELECT, INSERT
                (Ư�� ��ü���� ���� �� ������ �� �ִ� ����)
*/
--------------------------------------------------------------------------------
/*
    < REVOKE ���� ȸ��>
    
    [ǥ����]
    REVOKE ����1, ����2 ....... FROM ������;
    
    ������ ������ ����ϴ� ��ɾ�
*/

-- 7. SAMPLE �������� ���̺��� ������ �� �ִ� ���� ȸ��
REVOKE CREATE TABLE FROM SAMPLE;

--DCL �ǽ����� --

-- ����ڿ��� �ο��� ���� : CONNECT, RESOURCE
-- ������ �ο����� ����ڴ� : MYMY

CREATE USER MYMY IDENTIFIED BY MYMY;
GRANT CONNECT, RESOURCE TO MYMY;







