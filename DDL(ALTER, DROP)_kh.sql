/*
    DDL : ������ ���� ���
    
    ��ü���� ���ΰ� ����(CREATE), �����ϰ�, �����ϴ� ����.
    
    1. ALTER
    ������ ������ �����ϴ� ����.
    
    <���̺����>
    [ǥ����]
     ALTER TABLE ���̺�� ������ ����.
     
     -������ ����
     1) �÷��߰� / ���� / ����
     2) �������� �߰� / ���� => ������ �Ұ�(�����ϰ��� �Ѵٸ� ���� �� ������ �߰�)
     3) ���̺�� / �÷��� / �������Ǹ� ����
*/
-- 1) �÷� �߰� / ���� / ����
-- 1-1) �÷� �߰�(ADD) : ADD �߰��� �÷��� �ڷ��� DEFAULT �⺻��. (��, DEFAULT �⺻���� ���� ����)
SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�.
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- ���ο� �÷��� ��������� �⺻������ NULL������ ä����.

--LNAME �÷��߰� DEFAULT ����.
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '�ѱ�';
-- ���ο� �÷� �߰��ϰ� �⺻������ �ѱ����� ä����.

-- 1-2) �÷� ����(MODIFY)
--      �÷��� �ڷ��� ���� : MODIFY �������÷��� �ٲٰ����ϴ� �ڷ���
--      DEFAULT �� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ� �⺻��.

-- DEPT_COPY���̺��� DEPT_ID �÷��� �ڷ����� CHAR(3)�� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);

-- ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� Ÿ�����δ� ������ �Ұ����ϴ�.
-- DEPT_COPY ���̺��� DEPT_ID �÷��� �ڷ����� NUMBER�� ����.

ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- column to be modified must be empty to change datatype
-- ���� �����ϰ����ϴ� �÷��� �̹� ����ִ� ���� ��ġ�ϴ� �÷��̰ų� Ȥ�� �����ִ� �÷�, �׸��� �� ū ����Ʈ�� �ڷ������θ� ���� ������
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(1);
-- ORA-01441: cannot decrease column length because some value is too big

--> ���� -> ����(X) / ���ڿ����� ������ ��� (X) / ���ڿ����� ������ Ȯ��(O)

-- �ѹ��� ������ �÷� �ڷ��� �����ϱ�
--DEPT_TITLE�� ������Ÿ���� VARCHAR2(40)����
--LOCATION_ID�� ������ Ÿ���� VARCHAR2(2)��
--LNAME�÷��� �⺻���� '�̱�'
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';

-- 1-3) �÷� ���� (DROP COLUMN) : DROP COLUMN �����ϰ����ϴ� �÷���
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

-- DEPT_COPY2 DEPT_ID ����.
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;

--DDL���� ������ �Ұ����ϴ�.
ROLLBACK;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;

ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- ���� : cannot drop all columns in a table
-- ���̺� �ּ� �Ѱ��� �÷��� �����ؾ���.

/*
    2) �������� �߰� / ����
    2-2) �������� �߰�
    
    - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
    -FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ������ ���̺��[(������ �÷���)];
    
    -UNIQUE : ADD UNIQUE(�÷���)
    -CHECK : ADD CHECK(�÷��� ���� ����);
    -NOT NULL : MODIFY �÷��� NOT NULL;
    
    ������ �������Ǹ� �ο��ϰ��� �Ѵٸ�
    CONSTRAINT �������Ǹ� �տ��ٰ� ���̸��.
    -> CONSTRAINT �������Ǹ��� ������������.
    -> ���ǻ��� : ���� ������ ������ �̸����� �ο��ؾ���.
*/

--DEPT_COPY���̺�κ��� 
--DEPT_ID �÷��� PRIMARY_KEY ���������߰�
--DEPT_TITLE �÷��� UNIQUE ���������߰�
--LNAME�÷��� NOT NULL �������� �߰�.
ALTER TABLE DEPT_COPY
ADD PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME NOT NULL;


/*
    2-2) �������� ����
    
    PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�;
    NOT NULL : MODIFY �÷��� NULL;
*/
--DEPT_COPY ���̺�κ��� PK�� �ش��ϴ� ���������� ����.
ALTER TABLE DEPT_COPY DROP CONSTRAINT SYS_C007402;

--DEPT_COPY ���̺�κ��� UNIQUE�� �ش��ϴ� ���������� ����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_UQ;

--NOT NULL �������� ����.
ALTER TABLE DEPT_COPY MODIFY LNAME NULL;

-- 3) �÷��� / �������Ǹ� / ���̺�� ����

-- 3-1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���.
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3-2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- DEPT_COPY�� SYS_C007391���������� DEPT_COPY_DI_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007391 TO DEPT_COPY_DI_NN;

-- 3-3) ���̺�� ���� : RENAME �������̺�� TO �ٲ����̺��.
--                          �������̺�� ��������.(ALTER TABLE���� ��������Ƿ� ���������ϴ�)
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
--------------------------------------------------------------------------------------
/*
    2. DROP 
    ��ü�� �����ϴ� ����.
    
    [ǥ����]
    DROP TABLE �����ϰ����ϴ� ���̺��̸�;
*/
-- EMP_NEW ���̺� ����
DROP TABLE EMP_NEW;

-- �θ����̺��� �����ϴ� ��쿡 ���� �׽�Ʈ.
-- 1. DEPT_TEST�� DEPT_ID PRIMARY_KEY �������� �߰�.
ALTER TABLE DEPT_TEST ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);

--2. EMPLOYEE_COPY3�� �ܷ�Ű(DEPT_CODE)�� �߰� (�ܷ�Ű �̸� : ECOPY_FK)
--   �̋� �θ����̺��� DEPT_TEST���̺�, DEPT_ID�� ����
ALTER TABLE EMPLOYEE_COPY3 
ADD CONSTRAINT ECOPY_FK FOREIGN KEY(DEPT_CODE) REFERENCES DEPT_TEST(DEPT_ID);

--�θ����̺� ����.(���� ���� ����)
DROP TABLE DEPT_TEST;
-- unique/primary keys in table referenced by foreign keys

-- �θ����̺� �����ϴ� ���
-- 1) �ڽ����̺��� ���� �������� �θ����̺� �����Ѵ�.
DROP TABLE  �ڽ����̺�;
DROP TABLE �θ����̺�;

-- 2) �θ����̺� �����ϵ� , �¹����ִ� �ܷ�Ű �������ǵ� �Բ� �����Ѵ�.
DROP TABLE DEPT_TEST CASCADE CONSTRAINT;





