-----------ù��° ���� ����-------------
--���ʽ��� ���� �ʰ�, �μ� ��ġ�� �Ǿ��ִ� ��� ��ȸ�ϰ� ����!
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- ������ : NULL�� ���Ҷ��� �ܼ��� �Ϲݺ� �����ڸ� ���� ���� �� ����.
-- �ذ��� : IS NULL / IS NOT NULL �����ڸ� ���� �񱳸� �ؾ���.

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;