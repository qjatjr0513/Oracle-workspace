-- 3-1.
-- CREATE TABLE ���� �ο��ޱ� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- insufficient privileges
-- ������� ���� :  SAMPLE ������ ���̺��� ������ �� �ִ� ������ ���༭ �߻�.

-- 3_2.
-- CREATE TABLE ������ �ο����� ��.
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- no privileges on tablespace 'SYSTEM'
-- TABLESPACE : ���̺��� ���ִ� ����
--SAMPLE �������� TABLESPACE�� ���� �Ҵ���� �ʾƼ� ���� �߻�.

-- TABLESPACE �Ҵ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ�.

-- �� ���̺� ���� ������ �ο��ްԵǸ�
-- ������ �����ϰ� �ִ� ���̺���� ����(SELECT, INSERT, DELETE, UPDATE .. DML)�ϴ°��� ��������.

INSERT INTO TEST VALUES(1);

SELECT * FROM TEST;

-- 4. �� �����
CREATE VIEW VIEW_TEST
AS SELECT * FROM TEST;
-- insufficient privileges(������� ����)

--���� �ο����� ��
CREATE VIEW VIEW_TEST
AS SELECT * FROM TEST;
-- �� ���� �Ϸ�.

-- 5. SAMPLE �������� KH������ ���̺� �����ؼ� ��ȸ�غ���.
SELECT *
FROM KH.EMPLOYEE;
--table or view does not exist
--KH ������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�

-- SELECT ON ���� �ο� ���� �� ��ȸ.
SELECT *
FROM KH.EMPLOYEE;

-- 6. SAMPLE�������� KH������ DEPARTMENT���̺� �����ؼ� �� �����غ���.
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');
-- KH������ DEPARTMENT���̺� �����ؼ� �����Ҽ� �ִ� ������ ���⶧���� ���� �߻�.

--���Ѻο���
INSERT INTO KH.DEPARTMENT VALUES('D0', 'ȸ���', 'L2');

COMMIT;

--7. ���̺� ����
CREATE TABLE TESET2(
    TEST_ID NUMBER
);
-- SAMPLE �������� ���̺��� ������ �� ������ ������ ȸ���Ͽ��� ������ �����߻�.