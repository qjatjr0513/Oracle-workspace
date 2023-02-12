-- PK�������� ����.

SELECT * FROM USER_MOCK_DATA;
SELECT COUNT(*) FROM USER_MOCK_DATA; --50000

--ID�÷� �˻� 22222
SELECT *
FROM USER_MOCK_DATA
WHERE ID = 22222; -- OPTION : FULL, CARDINALITY : 5, COST : 136

--EMAIL �˻�
-- kbresland@comsenz.com
SELECT
    *
FROM USER_MOCK_DATA
WHERE EMAIL = 'kbresland0@comsenz.com'; -- options : full, cardinality : 5, cost : 136

-- gender�� ���� ��ȸ
SELECT 
    *
FROM USER_MOCK_DATA
WHERE GENDER = 'Male'; --options : full, cardinality : 24548, cost : 137

-- first_name Į���� like ����
SELECT
    *
FROM USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; -- options : full, cardianlity : 2937, cost : 136

--���������߰� PK
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT PK_USER_MOCK_DATA_ID PRIMARY KEY(ID);

--���������߰� UNQIUE(EMAIL) -> �ڵ����� index�߰�
ALTER TABLE USER_MOCK_DATA
ADD CONSTRAINT UQ_USER_MOCK_DATA_EMAIL UNIQUE(EMAIL);

SELECT * FROM USER_CONSTRAINTS;

SELECT * FROM USER_CONS_COLUMNS;

-- �÷� ID�˻�
SELECT * 
FROM USER_MOCK_DATA
WHERE ID = 22222; -- OPTIONS : UNIQUE SCAN, CARDINALITY : 1, COST : 1

-- �̸����� ���� �˻�
SELECT
    *
FROM USER_MOCK_DATA
WHERE EMAIL = 'kbresland0@comsenz.com'; -- OPTIONS : UNIQUE SCAN, CARDINALITY : 1, COST : 1

CREATE INDEX UQ_USER_MOCK_DATA_GENDER ON USER_MOCK_DATA(GENDER);


SELECT 
    *
FROM USER_MOCK_DATA
WHERE GENDER = 'Male'; -- OPTIONS : RANGE SCAN, CARDINALITY : 201, COST : 59

CREATE INDEX UQ_USER_MOCK_DATA_FIRST_NAME ON USER_MOCK_DATA(FIRST_NAME);

SELECT * FROM
USER_MOCK_DATA
WHERE FIRST_NAME LIKE 'R%'; -- OPTIONS : RANGE SCAN, CARDINALITY : 453, COST : 3

/*
    �ε��� ����
    1) WHERE���� �ε��� Į���� ���� �ξ� ������ ���� �����ϴ�.
    2) ORDER BY ������ ����� �ʿ䰡 ����(�̹� ���ĵǾ��ִ�.)
    ����) ORDER BY���� �޸𸮸� ���� ��ƸԴ� �۾���
    3) MIN, MAX���� ã���� ����ӵ��� �ſ����(���ĵǾ��ֱ� ����)
    
    �ε����� ����
    1) DML�� ����� (������ ���� �����ϸ� ���� ����)
    2) INDEX�� �̿��� INDEX-SCAN���� �ܼ��� FULLCAN�� �� �����Ҷ��� ����.
    3) �ε����� �������� ���� ������ ��Ƹ���.
*/







































