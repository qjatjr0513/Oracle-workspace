/*
    <INDEX>
    å���� �������� ����
    
    ���� ������ ���ٸ�? ���� ���ϴ� ����, Į���� ��� �ִ��� �𸣴� ��� å�� �ϳ��ϳ� �Ⱦ� ���� ��.
    
    ���������� ���̺��� JOIN Ȥ�� ���������� �����͸� ��ȸ(SELECT)�� ��
    �ε����� ���ٸ� ���̺��� ��� �����͸� �ϳ��ϳ� ������(FULL-SCAL)���� ���ϴ� �����͸� ������ ����.
    
    ���� �ε��� ������ �صθ� ��� ���̺��� ������ �ݰ� ���� ���ϴ� ���Ǹ� ������ ������ �� ���� ����.
    
    �ε��� Ư¡
    - ���ؽ��� ������ Į���� �����͵��� ������ '��������'���� �����Ͽ� Ư���޸� ������ �������ּ�(ROWID)�� �Բ� �����Ŵ
    => ��, �޸𸮿� ������ �����Ѵ�.
*/
-- (100���� �̻����� ������ �� �ʿ���.)
-- ���� ������ ������ �ε����� Ȯ��.
SELECT * FROM USER_INDEXES; -- 12�� �����Ǿ� ����. PRIMARY KEY(PK)�� �ڵ����� �ε����� �������.
-- PK������ �ڵ����� �ε����� �����ȴ�.

-- ���� ������ �ε����� �ε����� ����� Į���� Ȯ�ν� 
SELECT * FROM USER_IND_COLUMNS;

-- �����ȹȮ��.
SELECT * 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '������';

-- EMP_NAME���� INDEX����� �����ȹ ��
-- �ε��� �������
-- [ǥ����]
-- CREATE INDEX �ε����� ON ���̺��(Į����);
CREATE INDEX EMPLOYEE_EMP_NAME ON EMPLOYEE(EMP_NAME);

-- �����ȹ �ٽ� Ȯ��
SELECT * 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '������';

-- (INDEX������ �߰��Ǿ���. (RANGE SCAN))
-- (���̺� ��ü���� ��ȸ���� �ʿ���� 10 ~ 15% ���̿� ����ϸ� ȿ���� ���ٰ� ��.)
-- �츮�� �ε����� ����� �������� �ش� �÷��� ����ص�, �ε����� ������� �ʴ� ��쵵 ����. 
-- �ش� �ε����� Ż�� ��Ż���� ��Ƽ�������� �Ǵ��Ѵ�.

-- �ε��� ����
DROP INDEX EMPLOYEE_EMP_NAME;

-- ����Į���� �ε����� �ο��� �� ����. 
CREATE INDEX EMPLOYEE_EMP_NAME_DEPT_CODE ON EMPLOYEE(EMP_NAME, DEPT_CODE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '�ڳ���' AND DEPT_CODE = 'D5';
-- �����ȹ Ȯ���ϸ� ������ INDEX�� Ÿ�� ����.

DROP INDEX EMPLOYEE_EMP_NAME_DEPT_CODE;

/*
    �ε����� ȿ�������� ���� ���ؼ�?
    �������� �������� ����, �������� ���� ȣ��Ǹ�, �ߺ����� ���� �÷��� ���� ����.
    => �� PKĮ���� ���� ȿ���� ����.
    
    1) �������� ���� �����ϴ� Į��
    2) �׻� = ���� �񱳵Ǵ� Į��
    3) �ߺ��Ǵ� �����Ͱ� �ּ����� �÷�( == �������� ����.)
    4) ORDER BY ������ ���� ���Ǵ� Į��
    5) JOIN �������� ���� ���Ǵ� Į��
*/

-- INDEXTEST ���̵� ��������
CREATE USER INDEXTEST IDENTIFIED BY INDEXTEST;
--RESOURCE, CONNECT ���� �ο�
GRANT RESOURCE, CONNECT TO INDEXTEST;