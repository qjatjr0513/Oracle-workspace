--1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" 
--���� ǥ���ϵ��� ����.
SELECT
    department_name AS "�а���",
    category AS "�迭"
FROM TB_DEPARTMENT;

-- 2. �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.
SELECT
    department_name ||'�� ������ ' || capacity || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;

--3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û��
--���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ�
--ã�� ������ ����)
SELECT
    student_name
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
WHERE  ABSENCE_YN = 'Y' AND DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�') AND SUBSTR(STUDENT_SSN, 8, 1) IN ('2', '4');

--4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� ����. �� ����ڵ���
--�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT
    student_name
FROM TB_STUDENT
WHERE STUDENT_NO IN('A513079', 'A513090', 'A513091',  'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

--5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT
    department_name,
    category
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

--6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. �׷� ��
--������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT
    professor_name
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� ����. 
--��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT
    student_name
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;
--8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
--������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT
    CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

--9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT
    category
FROM TB_DEPARTMENT
GROUP BY CATEGORY
ORDER BY CATEGORY;

--10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ ��������
--�л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT
    student_no,
    student_name,
    student_ssn
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_NO,6,2) = '02' AND ABSENCE_YN = 'N';

--[Additional SELECT - �Լ�]
--1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
--������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
--ǥ�õǵ��� ����.)
SELECT
    student_no AS "�й�",
    student_name AS "�̸�",
    TO_CHAR(entrance_date, 'YYYY-MM-DD') AS "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO =(SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�')
-- WHERE DEPARTMENT_NO = '002'
ORDER BY ���г⵵;

--2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� ����. �� ������
--�̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
--������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT
    professor_name,
    professor_ssn
FROM TB_PROFESSOR
--WHERE NOT PROFESSOR_NAME LIKE '___'
WHERE LENGTH(PROFESSOR_NAME) != 3;

--3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
--�̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
--2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ����������
--����Ѵ�.)
SELECT
    professor_name AS "�����̸�",
    EXTRACT(YEAR FROM SYSDATE) -  EXTRACT(YEAR FROM TO_DATE(19||SUBSTR(professor_ssn,1,2), 'YYYY')) AS "����"
FROM TB_PROFESSOR
WHERE SUBSTR(professor_ssn,8,1) = 1 
ORDER BY ����;

--4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
--?�̸�? �� �������� ����. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT
    SUBSTR(professor_name,2,2) AS "�̸�"
FROM TB_PROFESSOR;

--5. �� ������б��� ����� �����ڸ� ���Ϸ��� ����. ��� ã�Ƴ� ���ΰ�? �̶�, 
--19 �쿡 �����ϸ� ����� ���� ���� ������ �A������.

SELECT
    student_no,
    student_name
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)- EXTRACT(YEAR FROM TO_DATE(SUBSTR(student_ssn,1,6))) > 19;

--6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE('20/12/25'), 'DAY') FROM DUAL;

--7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� ���� �� �� ��
--�� �� ���� �ǹ��ұ�? �� TO_DATE('99/10/11','RR/MM/DD'), 
--TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?

SELECT 
    TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'), 'YYYY'),
    TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'), 'YYYY'),
    TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'), 'YYYY'),
    TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'), 'YYYY')
FROM DUAL;

-- 8.�� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 2000 �⵵
--���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT
    student_no,
    student_name
FROM TB_STUDENT
--WHERE ENTRANCE_DATE < '2000/01/01';
WHERE SUBSTR(student_no, 1, 1) != 'A';

--9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��,
--�̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ��
--�ڸ������� ǥ���Ѵ�.
SELECT
    ROUND(AVG(point), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

--10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� �������
--��µǵ��� �Ͻÿ�.
SELECT 
    department_no AS "�а���ȣ",
    COUNT(*)
FROM TB_STUDENT 
group by department_no
ORDER BY �а���ȣ;

--11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL �����ۼ��Ͻÿ�.
SELECT
    COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

--12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
--�̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ�
--�Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT
    TO_CHAR(SUBSTR(term_no, 1,4)) AS "�⵵",
    ROUND(AVG(POINT), 1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY TO_CHAR(SUBSTR(term_no, 1,4))
ORDER BY �⵵;

--13. �а� �� ���л� ���� �ľ��ϰ��� ����. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������
--�ۼ��Ͻÿ�.
SELECT
    department_no AS "�а��ڵ��",
    COUNT(DECODE(ABSENCE_YN, 'Y', 1)) AS "���л� ��"
FROM TB_STUDENT 
GROUP BY DEPARTMENT_NO
ORDER BY �а��ڵ��;

--14. �� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� ����. � SQL 
--������ ����ϸ� �����ϰڴ°�?
SELECT
    student_name AS "�����̸�",
    COUNT(student_name) AS "������ ��"
FROM TB_STUDENT 
GROUP BY student_name
HAVING COUNT(student_name) > 1
ORDER BY �����̸�;

--15. �й��� A112113 �� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ���� , ��
--������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ�
--ǥ���Ѵ�.)
SELECT
    SUBSTR(term_no, 1, 4) AS "�⵵",
    SUBSTR(term_no, 5, 2) AS "�б�",
    ROUND(AVG(point), 1) AS "����"
FROM TB_GRADE 
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(term_no, 1, 4), SUBSTR(term_no, 5, 2))
ORDER BY �⵵;

--[Additional SELECT - Option]
--1. �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
--������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT
    student_name AS "�л� �̸�",
    student_address AS "�ּ���"
FROM TB_STUDENT
ORDER BY 1;

--2. �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT
    student_name,
    student_ssn
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

--3. �ּ����� �������� ��⵵�� �л��� �� 1900 ��� �й��� ���� �л����� �̸��� �й�, 
--�ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. ��, ���������� "�л��̸�","�й�",
--"������ �ּ�" �� ��µǵ��� ����.
SELECT 
    student_name AS "�л��̸�",
    student_no AS "�й�",
    student_address AS "������ �ּ�"
FROM TB_STUDENT
--WHERE SUBSTR(STUDENT_ADDRESS,1,3) IN('������', '��⵵') AND SUBSTR(STUDENT_NO,1,1) != 'A'
WHERE (STUDENT_ADDRESS LIKE '���%' OR STUDENT_ADDRESS LIKE '������%') AND SUBSTR(STUDENT_NO,1,1) = '9'
ORDER BY 1;

--4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������
--�ۼ��Ͻÿ�. (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã��
--������ ����)
SELECT
    professor_name,
    professor_ssn 
FROM TB_PROFESSOR P
JOIN TB_DEPARTMENT D ON P.DEPARTMENT_NO = D.DEPARTMENT_NO
WHERE D.DEPARTMENT_NO = '005'
ORDER BY PROFESSOR_SSN;

--5. 2004 �� 2 �б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. ������
--���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
--�ۼ��غ��ÿ�.
SELECT
    student_no,
    point
FROM TB_GRADE
WHERE CLASS_NO = 'C3118100' AND TERM_NO = '200402'
ORDER BY POINT DESC ,student_no;

--6. �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL 
--���� �ۼ��Ͻÿ�.
SELECT
    student_no,
    student_name,
    department_name
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY STUDENT_NAME;

--7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
    class_name,
    department_name
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

--8. ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ����
--�ۼ��Ͻÿ�.
SELECT
    class_name,
    professor_name
FROM TB_CLASS A
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
ORDER BY A.DEPARTMENT_NO, CLASS_NAME;

--9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. �̿�
--�ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT
    class_name,
    professor_name
FROM TB_CLASS A
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON D.DEPARTMENT_NO = P.DEPARTMENT_NO
WHERE D.CATEGORY = '�ι���ȸ'
ORDER BY D.DEPARTMENT_NO, CLASS_NAME;
--10. �������а��� �л����� ������ ���Ϸ��� ����. �����а� �л����� "�й�", "�л� �̸�", 
--"��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��, ������ �Ҽ��� 1 �ڸ�������
--�ݿø��Ͽ� ǥ������.)
SELECT
    student_no,
    student_name,
    ROUND(AVG(point), 1)
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NO = (SELECT
                            DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NO = '059'
                        )
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY STUDENT_NO;

--11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ�
--���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ����
--�ۼ��Ͻÿ�. ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?����
--��µǵ��� ����.
SELECT
    department_name AS "�а��̸�",
    student_name AS "�л��̸�",
    professor_name AS "���������̸�"
FROM TB_DEPARTMENT
JOIN TB_STUDENT S USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
WHERE S.STUDENT_NO = 'A313047';

--12. 2007 �⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸦ ǥ���ϴ�
--SQL ������ �ۼ��Ͻÿ�.
SELECT
    student_name,
    term_no
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE TERM_NO LIKE '2007%' AND CLASS_NAME = '�ΰ������';

--13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ����
--�̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
    class_name,
    department_name
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
WHERE CATEGORY = '��ü��' AND PROFESSOR_NO IS NULL
ORDER BY DEPARTMENT_NO ASC , CLASS_NAME ASC;

--14. �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� ����. �л��̸���
--�������� �̸��� ã�� ���� ���� ������ ���� �л��� ��� "�������� ������?����
--ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. ��, �������� ?�л��̸�?, ?��������?��
--ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� ����.

SELECT
    student_name,
    NVL(professor_name,'�������� ������')
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR P ON S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
WHERE S.DEPARTMENT_NO = (SELECT 
                             DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME = '���ݾƾ��а�')
ORDER BY STUDENT_NO;

--15. ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а�
--�̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT
    student_no AS "�й�",
    student_name AS "�̸�",
    department_name AS "�а� �̸�",
    ROUND(AVG(point),8) AS "����"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4.0 
ORDER BY �й�;

--16. ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT
    C.class_no,
    C.class_name,
    ROUND(AVG(POINT),8)
FROM TB_CLASS C
JOIN TB_GRADE G ON C.CLASS_NO = G.CLASS_NO
WHERE C.CLASS_TYPE = '��������' AND DEPARTMENT_NO = (SELECT 
                            DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        WHERE DEPARTMENT_NAME = 'ȯ�������а�'
                        )
 
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY C.CLASS_NO;

--17. �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ�
--SQL ���� �ۼ��Ͻÿ�.
SELECT 
    student_name,
    student_address
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT
                            DEPARTMENT_NO
                        FROM TB_DEPARTMENT
                        JOIN TB_STUDENT USING(DEPARTMENT_NO)
                        WHERE STUDENT_NAME = '�ְ���');

--18. ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ����
--�ۼ��Ͻÿ�.
SELECT
    student_no,
    student_name
FROM(SELECT
    student_no,
    student_name
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO) 
JOIN TB_DEPARTMENT D USING(DEPARTMENT_NO)
WHERE D.DEPARTMENT_NAME = '������а�'
group by student_name, student_no
ORDER BY AVG(POINT)DESC)E
WHERE ROWNUM =1;

--19. �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� �а� �� �������� ������
--�ľ��ϱ� ���� ������ SQL ���� ã�Ƴ��ÿ�. ��, �������� "�迭 �а���", 
--"��������"���� ǥ�õǵ��� �ϰ�, ������ �Ҽ��� �� �ڸ������� �ݿø��Ͽ� ǥ�õǵ���
--�Ѵ�.
SELECT
    department_name AS "�迭 �а���",
    ROUND(AVG(POINT),1) AS "��������"
FROM TB_DEPARTMENT
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT
                        CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = 'ȯ�������а�')
AND CLASS_TYPE LIKE '����%'
GROUP BY DEPARTMENT_NAME
ORDER BY "�迭 �а���";

--[DDL]
--1. �迭 ������ ������ ī�װ� ���̺��� ������� ����. ������ ���� ���̺���
--�ۼ��Ͻÿ�.
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

--2. ���� ������ ������ ���̺��� ������� ����. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

--3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
--(KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������
--�˾Ƽ� ������ �̸��� ����Ѵ�.)
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

--4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

--5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
--NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20);

--6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
--���� ���·� ��������.
--(ex. CATEGORY_NAME)
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

--7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
--�����Ͻÿ�.
--Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007248 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007245 TO PK_CLASS_TYPE_NO;

--8. ������ ���� INSERT ���� ��������.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT; 

--9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
--������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
--FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

--10. �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� ����. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
DROP VIEW VW_�л��Ϲ�����;
CREATE VIEW VW_�л��Ϲ�����
AS SELECT 
    STUDENT_NO AS "�й�", 
    STUDENT_NAME AS "�л��̸�", 
    STUDENT_ADDRESS AS "�ּ�" 
FROM TB_STUDENT ;

--11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� ��������. 
--�̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
--�̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
--���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE VIEW VW_�������
AS SELECT
    STUDENT_NAME,
    DEPARTMENT_NAME,
    PROFESSOR_NAME
FROM TB_STUDENT 
JOIN TB_DEPARTMENT  USING(DEPARTMENT_NO)
LEFT JOIN TB_PROFESSOR ON (PROFESSOR_NO = COACH_PROFESSOR_NO);


--12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
CREATE VIEW VW_�а����л���
AS SELECT
    DEPARTMENT_NAME,
   COUNT(*) AS "STUDENT_COUNT"
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
GROUP BY DEPARTMENT_NAME;

--13. ������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
--�̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
UPDATE VW_�л��Ϲ�����
SET �л��̸� = '�̹���'
WHERE �й� = 'A213046';

--14. 13 �������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
--��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.
CREATE VIEW VW_�л��Ϲ�����
AS SELECT 
    STUDENT_NO AS "�й�", 
    STUDENT_NAME AS "�л��̸�", 
    STUDENT_ADDRESS AS "�ּ�" 
FROM TB_STUDENT WITH READ ONLY;

--15. �� ������б��� �ų� ������û �Ⱓ�� �Ǹ� Ư�� �α� ����鿡 ���� ��û�� ����
--������ �ǰ� �ִ�. �ֱ� 3 ���� �������� �����ο��� ���� ���Ҵ� 3 ������ ã�� ������
--�ۼ��غ��ÿ�.
SELECT
    E."�����ȣ", E."�����̸�", E."������������(��)"
FROM(SELECT
    class_no AS "�����ȣ",
    class_name AS "�����̸�",
    COUNT(*) AS "������������(��)"
FROM TB_CLASS C
JOIN TB_GRADE G  USING(CLASS_NO)
WHERE SUBSTR(TERM_NO,1,4) BETWEEN 2005 AND 2009
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY "������������(��)" DESC)E
WHERE ROWNUM <4;


--[DML]
--1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT INTO TB_CLASS_TYPE VALUES('01', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('02', '��������');
INSERT INTO TB_CLASS_TYPE VALUES('03', '�����ʼ�');
INSERT INTO TB_CLASS_TYPE VALUES('04', '���缱��');
INSERT INTO TB_CLASS_TYPE VALUES('05', '������');
SELECT * FROM TB_CLASS_TYPE;
--2. �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. 
--�Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
CREATE TABLE TB_�л��Ϲ�����
AS SELECT
    student_no,
    student_name,
    student_address
FROM TB_STUDENT;

SELECT * FROM TB_�л��Ϲ�����;

--3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�. �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ� �ۼ��Ͻÿ�)
CREATE TABLE TB_������а�(�й�, �л��̸�, ����⵵, �����̸�)
AS SELECT 
    student_no,
    student_name,
    EXTRACT(YEAR FROM TO_DATE(SUBSTR(student_ssn,1,6))),
    professor_name
FROM TB_STUDENT TS
LEFT JOIN TB_PROFESSOR ON COACH_PROFESSOR_NO = PROFESSOR_NO
WHERE TS.DEPARTMENT_NO = (SELECT DEPARTMENT_NO FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME = '������а�');
DROP TABLE TB_������а�;
SELECT * FROM TB_������а�;
--4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
--SELECT 
--    DEPARTMENT_NAME,
--    CAPACITY,
--    ROUND(CAPACITY * 1.1)
--FROM TB_DEPARTMENT;

UPDATE TB_DEPARTMENT
SET CAPACITY = ROUND(CAPACITY*1.1);

SELECT * FROM TB_DEPARTMENT;
ROLLBACK;
--5. �й� A413042�� �ڰǿ� �л��� �ּҰ� "����� ���α� ���ε� 181-21 "�� ����Ǿ��ٰ� ����. �ּ����� �����ϱ� ���� ����� SQL ���� �ۼ��Ͻÿ�.
UPDATE TB_STUDENT
SET STUDENT_ADDRESS ='����� ���α� ���ε� 181-21'
WHERE STUDENT_NO = 'A413042';

--6. �ֹε�Ϲ�ȣ ��ȣ���� ���� �л����� ���̺��� �ֹι�ȣ ���ڸ��� �������� �ʱ�� �����Ͽ���. �� ������ �ݿ��� ������ SQL ������ �ۼ��Ͻÿ�.
--(��. 830530-2124663 ==> 830530 )
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN,1,6);

SELECT * FROM TB_STUDENT;

ROLLBACK;

--7. ���а� ����� �л��� 2005�� 1�б⿡ �ڽ��� ������ '�Ǻλ�����' ������ �߸��Ǿ��ٴ� ���� �߰��ϰ�� ������ ��û�Ͽ���.
--��� ������ Ȯ�� ���� ��� �ش� ������ ������ 3.5�� ����Ű�� �����Ǿ���. ������ SQL ���� �ۼ��Ͻÿ�.
UPDATE TB_GRADE
SET POINT = 3.5
WHERE TERM_NO = 200501 AND (CLASS_NO, STUDENT_NO)= (SELECT
                        CLASS_NO,
                        STUDENT_NO
                    FROM TB_CLASS
                    JOIN TB_STUDENT USING(DEPARTMENT_NO)
                    WHERE CLASS_NAME = '�Ǻλ�����' AND STUDENT_NAME = '�����');

UPDATE TB_GRADE
SET POINT = 3.5
WHERE STUDENT_NO = (SELECT STUDENT_NO FROM TB_STUDENT
                                        JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                                        WHERE STUDENT_NAME = '�����' AND DEPARTMENT_NAME = '���а�')
AND TERM_NO = 200501
AND CLASS_NO = (SELECT CLASS_NO FROM TB_CLASS WHERE CLASS_NAME = '�Ǻλ�����');

SELECT
* FROM TB_GRADE
WHERE CLASS_NO = 'C3843900' AND STUDENT_NO = 'A331101';

ROLLBACK;

--8. ���� ���̺�(TB_GRADE) ���� ���л����� �����׸��� �����Ͻÿ�.
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (
                SELECT
                    STUDENT_NO
                FROM TB_STUDENT
                WHERE ABSENCE_YN = 'Y');
SELECT
    STUDENT_NO,
    POINT
FROM TB_GRADE
JOIN TB_STUDENT USING(STUDENT_NO)
WHERE ABSENCE_YN = 'Y';


ROLLBACK;



