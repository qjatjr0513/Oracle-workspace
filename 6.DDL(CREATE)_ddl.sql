/*
    DDL(DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)��
    ������ �����(CREATE), ������ �����ϰ�(ALTER), ���� ��ü�� ����(DROP)�ϴ� ��ɹ�.
    ��, ���� ��ü�� �����ϴ� ���� DB������, �����ڰ� �����.
    
    ����Ŭ������ ��ü(DB�� �̷�� ��������)
    ���̺�(TABLE), �����(USER), �Լ�(FUNCTION), ��(VIEW), ������(SEQUENCE), 
    �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER), ���ν���(PROCEDURE), 
    ���Ǿ�(SYNONYM)
*/

/*
    < CREATE TABLE >
    ���̺� : ��(ROW), ��(COLUMN)���� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü ���� �� �ϳ�.
            ��� �����ʹ� ���̺��� ���ؼ� �����(�����͸� �����ϰ��� �Ϸ��� ������ ���̺��� ��������)
            
    [ǥ����]
    CREATE TABLE ���̺�� (
    �÷��� �ڷ���,
    �÷��� �ڷ���,
    �÷��� �ڷ���,
    NAME DATE
    ...
    )
    
    <�ڷ���>
    - ���� (CHAR(ũ��)/VARCHAR2(ũ��)) : ũ��� BYTE������. (����, ����, Ư������ -> ���ڴ� 1 BYTE),
            
            CHAR(����Ʈ��) : �ִ� 2000BYTE���� ���� ����.
                            ��������(�ƹ��� ���� ���� ���͵� �������� ä���� ó�� �Ҵ��� ũ�⸦ ������)
                            �ַ� ���� ���� ���ڼ��� ������ ���� ��� ���
                            EX) ���� : M/F, �ֹι�ȣ : 14����
                    
            VARCHAR2(����Ʈ��) : �ִ� 4000BYTE���� ���� ����
                               ��������(�������� ���� ��� �� ��� ���� ���� ũ�Ⱑ �پ���.)
                               VAR�� '����' , 2�� 2�踦 �ǹ��Ѵ�.
                               �ַ� ���� ���� ���ڼ��� �������� ���� ��� ���.
                               EX) �̸� , ���̵� , ��й�ȣ ����.
                               
            ����(NUMBER) : ����/�Ǽ� ��� ���� NUMBER �ϳ�.
           
            ��¥(DATE) : ��/��/��/��/��/�� �������� �ð� ����.    
*/
--ȸ������ ������(���̵�, ��й�ȣ, �̸�, �������)�� ��� ���� ���̺� MEMBER����
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20), -- ��ҹ��� ����X, ��Ÿ�� ǥ����� �ǹ̰���� ������ھ�� ǥ��.
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);

--���̺� Ȯ�ι��
-- 1) ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ��ִ� �ý��� ���̺�.
SELECT *
FROM USER_TABLES;
-- 2) ���� �ǿ��� Ȯ���ϱ�.
-- 3) ���� ��ȸ
SELECT * FROM MEMBER;

--���� ���� : �÷��� Ȯ�ι�.
SELECT *
FROM USER_TAB_COLUMNS;
--USER_TAB_COLUMNS : ���� �� ����� ������ ������ �ִ� ���̺��� ��� �÷������� ��ȸ�Ҽ� �ִ� �ý��� ���̺�.
-- �÷��� �ּ��ޱ�

/*
    [ǥ����]
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ� ����';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
--ȸ����й�ȣ
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
--ȸ���̸�
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
--�������
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '�������';

SELECT *
FROM MEMBER;
--������ �߰�
--INSERT(DML) : �����͸� �߰��� �� �ִ� ����.
--�� ������ �߰�(���� �������� �߰�), �߰��� ���� ���(���� ���� �߿�)
--[ǥ����]
--INSERT INTO ���̺�� VALUSES(ù��° �÷��� ��, �ι�° �÷��� ��, ...)
INSERT INTO MEMBER VALUES ('user01', 'pass01', 'ȫ�浿1', '1980-10-06');

INSERT INTO MEMBER VALUES ('user02', 'pass02', 'ȫ�浿2', '1980-10-07');

INSERT INTO MEMBER VALUES ('user03', 'pass03', 'ȫ�浿3', '1980-10-08');

INSERT INTO MEMBER VALUES (NULL, NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES ('user03', 'pass03', 'ȫ�浿3', '1980-10-08');

--���� null���̳� �ߺ��Ȱ��� ��ȿ���� �������̴�.
-- ������ �����Ͱ��� �����ϱ� ���ؼ� ���������̶����� �ɾ������.
--���������� ���� �������� ���Ἲ ������ ��������.

--�������� : ���̺��� ���鶧 ��������, �Ŀ� ����, �߰� ����.

/*
    <�������� CONATRAINTS>
    -
    ���ϴ� �����Ͱ��� �����ϱ� ���ؼ�(�����ϱ� ���ؼ�)Ư�� �÷����� �����ϴ� ����
    (������ ���Ἲ ������ ��������)
    - ���������� �ο��� �÷��� ���� �����Ϳ� ������ �ִ��� ������ �ڵ����� �˻��� ����
    
    - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    -�÷��� ���������� �ο��ϴ� ��� : �÷����� ��� / ���̺� ���� ���.
*/
/*
    1. NOT NULL ��������
    -> ��, NULL���� ���� ���ͼ��� �ȵǴ� �÷��� �ο��ϴ� ��������
        ���� / ���� �� NULL���� ������� �ʵ��� �����ϴ� ��������
        ���ǻ��� : �÷����� ��Ĺۿ� �ȵ�.
    �ش��÷��� �ݵ�� ���� �����ؾ߸� �Ҷ� ���.
*/
-- �÷�������� : �÷��� �ڷ��� �������� => ���������� �ο��ϰ��� �ϴ� �÷��ڿ� ��ٷ� ���.
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

INSERT INTO MEM_NOTNULL VALUES
(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-4121-5555', 'ghdrlfehd@iei.or.kr');

INSERT INTO MEM_NOTNULL VALUES
(2, 'user02', NULL, NULL, NULL, NULL, NULL);
-- DDL������ MEM_NOTNULL���̺��� MEM_PWD��� �÷��� �ִµ� �ű⿡�� NULL�� ������ ����.
--> NOT NULL �������ǿ� ����Ǿ���.
INSERT INTO MEM_NOTNULL VALUES
(2, 'user02', 'pass02', 'ȫ�浿2', NULL, NULL, NULL);

select * from mem_notnull;
/*
    2. UNIQUE ��������
    �÷��� �ߺ����� �����ϴ� ��������.
    ���� / ���� �� ������ �ش� �÷��� �߿� �ߺ��� ���� �ִ� ���
    �߰� �Ǵ� ������ ���� �ʰԲ� �����Ŵ.
    
    �÷�������� / ���̺������ �Ѵ� ����.
*/
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(20),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_UNIQUE;

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER VARCHAR2(20),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEM_ID) -- ���̺��� ���.
);

INSERT INTO MEM_UNIQUE 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-4121-5555', 'ghdrlfehd@iei.or.kr');
--������ ������ �ι� ����������� UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ������
--unique constraint (DDL.SYS_C007039) violated
--��� �÷��� ��� ������ �ִ��� ��ü������ �˷����� ����.
--DDL.SYS_C007039 : ���������� �̸����θ� �������� ���踦 �˷���.
--�������� �ο��� ���� �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ� �ο�.

INSERT INTO MEM_UNIQUE 
VALUES(2, 'user02', 'pass02', 'ȫ�浿2', NULL, NULL, NULL);
select * FROM MEM_UNIQUE;
/*
    * �������� �ο��� �������� �� �����ϴ� ǥ����.
    
    >�÷����� ���
    CREATE TABLE ���̺�� (
         �÷��� �ڷ��� ��������1 ��������2,
         �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������,
         �÷��� �ڷ���
    );
    
    > ���̺��� ���
    CREATE TABLE ���̺�� (
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        �÷��� �ڷ���,
        ...
        CONSTRAINT  �������Ǹ� ��������(�÷���)
    )
    
    -> �� ��� ��� CONSTRAINT�������Ǹ� �κ��� ��������.
*/
CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_ID_UQ UNIQUE, --�÷��������
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    --,CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) --���̺��� ���
);
INSERT INTO MEM_CON_NM VALUES(
1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);
-- �ι� INSERT�� �����߻� : unique constraint (DDL.MEM_ID_UQ) violated
-- � �÷��� � ������ ������������ �� �����ؼ� ����.
select * from mem_con_nm;

INSERT INTO MEM_CON_NM VALUES(
2, 'user02', 'pass02', 'ȫ�浿2', '��', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);

INSERT INTO MEM_CON_NM VALUES(
3, 'user03', 'pass03', 'ȫ�浿', '��', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);

/*
    3. CHECK ��������
    
    �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �ִ�.
    EX) ���� '��' �Ǵ� '��'�� �����Բ� �ϰ� �ʹ�.
    
    [ǥ����]
    CHECK (���ǽ�)
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE, -- �÷��������,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('��' , '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL -- ȸ��������
);

INSERT INTO MEM_CHECK VALUES(
1, 'u1', 'pass01', 'ȫ�浿', '��', '010-1111-1111', 'ghdrlfehd@iei.or.kr', SYSDATE);

select * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(
2, 'u2', 'pass02', 'ȫ�浿2', NULL, '010-1111-1111', 'ghdrlfehd@iei.or.kr', SYSDATE);
-- ���࿡ CHECK���������� �ɰ� �ȿ� NULL�� ���°�� ���������� INSERT����.
-- �߰������� NULL���� �������� �ϰ�ʹٸ� NOT NULL �������ǵ� ���� �ɾ��ָ��.
/*
    DEFAULT ����.
        Ư�� �÷��� ���� ���� ���� �⺻�� ���� ����
        ���������� �ƴ�.
        EX) ȸ�������� �÷��� ȸ�������� ���Ե� ������ �ð��� ����ϰ� �ʹ�.
        -> DEFAULT �������� SYSDATE �������
*/

DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('��' , '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- ȸ��������
    --DEFAULT ������ '�ݵ��' �����ϰ� ���������� �ɾ������.
);

INSERT INTO MEM_CHECK VALUES
(1, 'user01', 'pass02', 'ȫ�浿', '��', '010-1111-1111', 'ghdrlfehd@iei.or.kr');

/*
    INSERT INTO MEM_CHECK(�÷���� ����)
    VALUES(���� ����)
*/
INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user01', 'pass01', 'ȫ�浿', '��');

/*
    PRIMARY KEY(�⺻Ű) ��������
    ���̺��� �� ����� ������ �����ϰ� �ĺ� �� �� �ִ� �÷��� �ο��ϴ� ��������.
    => �� ����� ������ �� �ִ� �ĺ����� ����.
    ��) ���, �μ����̵�, �����ڵ�, ȸ����ȣ ...
    => �ĺ����� ���� : �ߺ��Ǿ�� �ȵ�, ���� ������ �ȵ� => (NOT NULL + UNIQUE)
    
    ���ǻ��� : �� ���̺� �� �Ѱ��� �÷����� �⺻Ű�� ���� ����.
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('��' , '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- ȸ��������
    --DEFAULT ������ '�ݵ��' �����ϰ� ���������� �ɾ������.
);
INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user01', 'pass01', 'ȫ�浿', '��');

INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user02', 'pass02', 'ȫ�浿2', '��');
-- �⺻Ű �÷��� �ߺ����� ���� ������ �߻��ߴ�.
-- ORA-00001: unique constraint (DDL.MEM_PK) violated

INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(NULL, 'user02', 'pass02', 'ȫ�浿2', '��');
-- �⺻Ű �÷��� null ���� ���������ϸ� ���� �߻�
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY1"."MEM_NO")

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- �÷��������,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('��' , '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- ȸ��������
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO) --���̺������
);
-- name already used by an existing constraint
-- ���������� �̸��� �ߺ��� �� ����. �ٸ� ���̺� �ִ���.

-- table can have only one primary key
-- primary key�� �����̺� �ΰ� �̻��� �� �� ����.
-- ��, �� �÷��� ��� �ѹ��� primary key�� ���� ����. => ���̺���������θ� ����.

DROP TABLE MEM_PRIMARYKEY2;
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20), -- �÷��������,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('��' , '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- ȸ��������
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO, MEM_ID) --���̺������
);
-- �� �÷��� ��� �ϳ��� PRIMARY KEY�� ���� -> ����Ű.
INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��');

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user02', 'pass01', 'ȫ�浿', '��');

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��');
-- ����Ű�� ��쿡�� �� �÷��� ���� ������ �ߺ��Ǿ�߸� �������ǿ� ���谡 �ȴ�.

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, NULL, 'pass01', 'ȫ�浿', '��');
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY2"."MEM_ID")
-- ����Ű�� ��� �� �÷��� ���̶� null�̸� �������ǿ� ����ȴ�.

/*
    5. FOREIGN KEY (�ܷ�Ű)
        �ش� �÷��� �ٸ� ���̺� �����ϴ� ���� ���;� �ϴ�
        �÷��� �ο��ϴ� ��������
        => "�ٸ����̺�(�θ� ���̺�)�� �����Ѵ�"��� ǥ��
            ��, ������ �ٸ����̺�(�θ� ���̺�)�� �����ϴ� �ִ� ���� ���� �� �ִ�.
            EX) KH ��������
             EMPLOYEE ���̺�(�ڽ����̺�) <----------------------DEPARTMENT���̺�(�θ� ���̺�)
                    DEPT_CODE                                       DEPT_ID
                => DEPT_CODE���� DEPT_ID�� �����ϴ� ���鸸 ���� �� �ִ�.
                
            => FORIGN KEY �������� (==�����)���� �ٸ� ���̺�� ���踦 ������ �� �ִ�. (== JOIN)
            
            [ǥ����]
            > �÷����� ���
            �÷��� �ڷ��� CONSTRAINT ���� ���Ǹ� REFERENCES ������ ���̺��(������ �÷���)
            > ���̺� ���� ���
            CONSTRAINT �������Ǹ� FOREIGN KEY(�÷���) REFERENCES ������ ���̺��(������ �÷���)
            
            ������ ���̺� == �θ� ���̺�
            ���� �����Ѱ� : CONSTRAINT �������Ǹ�, ������ �÷���(�� ��� ��� �ش��)
            -> �ڵ������� ������ ���̺��� PRIMARY KEY�� �ش�Ǵ� �÷��� ������ �÷������� ����.
            
            ���ǻ��� : ������ �÷�Ÿ�԰� �ܷ�Ű�� ������ �÷�Ÿ���� ���ƾ��Ѵ�. 
*/
--�θ����̺�
-- ȸ���� ��޿� ���� ���̺�(����ڵ�, ��޸�) �����ϴ� ���̺�.
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --����ڵ� / ���ڿ�('G1', 'G2', 'G3',....)
    GRADE_NAME VARCHAR2(20) NOT NULL -- ��޸� / ���ڿ� ('�Ϲ�ȸ��', '���ȸ��', 'Ư��ȸ��')
);

INSERT INTO MEM_GRADE VALUES('G1', '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES('G2', '���ȸ��');
INSERT INTO MEM_GRADE VALUES('G3', 'Ư��ȸ��');
SELECT * FROM MEM_GRADE;

-- ȸ�������� ��� �ڽ����̺� ����
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE, --�÷��������
    GENDER CHAR(3) CHECK(GENDER IN('��', '��')) NOT NULL, -- CHECK ������������ ��, �� �� �� �ֵ���
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL --����Ʈ������ ����ð��� �����ϰ� NOT NULL���������� ����
    -- FORDIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --���̺������
);
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (1, 'user01', 'pass01', 'ȫ�浿', '��', 'G1');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (2, 'user02', 'pass02', 'ȫ�浿', '��', 'G2');


INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (3, 'user03', 'pass03', 'ȫ�浿', '��', 'G3');

--�ܷ�Ű �������ǿ��� NULL���� �� �� �ִ�.
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (4, 'user04', 'pass04', 'ȫ�浿', '��', NULL);

--G4����� MEM_GRADE ���̺��� GRADE_CODE�� �ִ� ���� �ƴ�
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (5, 'user05', 'pass05', 'ȫ�浿', '��', 'G4');

SELECT * FROM MEM;

-- ����) �θ����̺��� �����Ͱ� �����ȴٸ�?
-- MEM_GRADE ���̺�κ��� GRADE_CODE G1�� �����͸� �����غ���
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--�ڽ����̺�(MEM)�߿� GRADE_ID�÷����� G1���� �̹� �����ؼ� ������̱� ������ ������ �� ����.
--���� : ORA-02292: integrity constraint (DDL.SYS_C007098) violated - child record found

-- ���� �ܷ�Ű �������� �ο��� ������ ���� �ɼ��� ���� �ο����� ����.
-- -> �⺻������ ���� ���� �ɼ��� �ɷ�����.

DROP TABLE MEM;

/*
    �ڽ����̺� ������(==�ܷ�Ű ���������� �ο�������)
    �θ����̺��� �����Ͱ� �����Ǿ����� �ڽ����̺��� ��� ó���� ���� �ɼ����� ���ص� �� �ִ�.
    
    FOREIGN KEY �����ɼ�
    -ON DELETE SET NULL : �θ����͸� �����Ҷ� �ش� �����͸� ����ϴ� �ڽĵ����͸� NULL�� �ٲٰڴ�.
    -ON DELETE CASCADE : �θ����͸� �����Ҷ� �ش絥���͸� ����ϴ� �ڽĵ����͸� ���� �����ϰڴ�.
    -ON DELETE RESTRICTED : �������� -> �⺻�ɼ�.
*/
-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE SET NULL , --�÷��������
    GENDER CHAR(3) CHECK(GENDER IN ('��','��')) NOT NULL,-- CHECK������������ �� , �� �����ְ�, NOT NULL ���������� ����.
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- ����Ʈ������ ����ð��� �����ϰ� NOTNULL ���������� ����
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- ���̺������
);

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (1 , 'user01' , 'pass01', 'ȫ�浿','��','G1');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (2 , 'user02' , 'pass02', 'ȫ�浿','��','G2');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (3 , 'user03' , 'pass03', 'ȫ�浿','��','G3');

SELECT * FROM MEM;

-- �θ����̺��� GRADE_CODE 'G1'�� ���� ����.
DELETE FROM MEM_GRADE
WHERE GRADE_CODE ='G1';
-- �ڽ����̺��� GRADE_ID�� G1�� �κ��� ��� NULL�� �ٲ�.

-- ON DELETE CASCADE 
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2), -- �÷����� �ݽ�
    GENDER CHAR(3) CHECK (GENDER IN ('��' , '��')) NOT NULL, -- CHECK������������ �� , �� �����ְ� , NOT NULL ���������� ����.
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- ����Ʈ������ ����ð��� �����ϰ� NOT NULL ���������� ����
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- ���̺������
); 

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (1 , 'user01' , 'pass01' , 'ȫ�浿' , '��' , 'G1');

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (2 , 'user02' , 'pass02' , 'ȫ�浿' , '��' , 'G2');

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (3 , 'user03' , 'pass03' , 'ȫ�浿' , '��' , 'G3');




SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';
-- �ڽ����̺��� GRADE_ID�� G3�� ����� ��� ������.

--���ι���
-- ��ü ȸ���� ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ��޸� ��ȸ
-- ����Ŭ ���뱸��
SELECT
    MEM_NO,
    MEM_ID,
    MEM_PWD,
    MEM_NAME,
    grade_name
FROM MEM, MEM_GRADE
WHERE MEM.GRADE_ID = MEM_GRADE.GRADE_CODE(+);
-- ANSI ���� ����
SELECT
    MEM_NO,
    MEM_ID,
    MEM_PWD,
    MEM_NAME,
    grade_name
FROM MEM
LEFT JOIN MEM_GRADE ON GRADE_ID = GRADE_CODE;
/*
    ���� �ܷ�Ű ���������� �ɷ� ���� �ʴ��� JOIN������.
    �ٸ�, �� �÷��� ������ �ǹ��� �����Ͱ� ����־����.(�ڷ����� ����, ��谣�� ����, �ǹ̵� ����ؾ���)
*/
--------------------------------------------------------------------------------------------

--����ڰ���_kh�� ����
/*
        SUBQUERY�� �̿��� ���̺� ����(���̺� ������ ����)
        
        ���� SQL��(SELECT, CREATE, INSERT, UPDATE....)�� �����ϴ� ������ �������� ������������.
        
        [ǥ����]
        CREATE TABLE ���̺��
        AS ��������;
*/

--EMPLOYEE ���̺��� �������̺����
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
-- �÷���, �ڷ���, NOT NULL ���������� ����� �����.
--PRIMARY KEY ���������� ����� ���簡 �ȵ�.
--> ���������� ���� ���̺��� ������ ��� ���������� ��� NOT NULL �������Ǹ� ����ȴ�.
SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE ���̺��� �����ʹ� �ʿ����, �÷� ������ �����ϰ� ������.

SELECT * FROM EMPLOYEE
WHERE 1 = 0; -- 1 0 FALSE�� �ǹ���.
--WHERE 1=1; 1=1�� TRUE�� �ǹ���.

CREATE TABLE EMPLOYEE_COPY2
AS SELECT * FROM EMPLOYEE WHERE 1=0;

-- ��ü ������� �޿��� 300���� �̻��� ������� ���, �̸�, �μ��ڵ�, �޿� �÷� ����(���빰�� ����)
--EMPLOYEE_COPY3
--1) ��ȸ
CREATE TABLE EMPLOYEE_COPY3 AS
SELECT
    emp_id,
    emp_name,
    dept_code,
    salary
FROM EMPLOYEE
WHERE SALARY >= 3000000;

DROP TABLE EMPLOYEE_COPY3;
CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY FROM EMPLOYEE WHERE SALARY >= 3000000;

-- 2. ��ü ����� ���, �����, �޿� ���� ��ȸ�� ����� ������ ���̺� ���� (���빰�� ����)
-- ���̺�� : EMPLOYEE_COPY4
CREATE TABLE EMPLOYEE_COPY4
AS SELECT 
    emp_id, 
    emp_name, 
    salary, 
    (salary*12) AS "annual_income" 
FROM EMPLOYEE;
-- ���������� SELECT���� ������� �Ǵ� �Լ��� �� ����� ��� �ݵ�� ��Ī�� �ٿ�����.
