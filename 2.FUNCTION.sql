/*
    <�Լ� FUNCTION>
    �ڹٷ� ������ �޼ҵ�� ���� ����
    �Ű������� ���޵� ������ �о ����� ����� ��ȯ -> ȣ���ؼ� �� ��
    
    - ������ �Լ� : N���� ���� �о N���� ����� ����(�� �ึ�� �Լ� ���� �� ��� ��ȯ)
    - �׷� �Լ� : N���� ���� �о 1���� ����� ���� (�ϳ��� �׷캰�� �Լ� ������ ��� ��ȯ)
    
    ������ �Լ��� �׷� �Լ��� �Բ� ��� �� �� ���� : ��� ���� ������ �ٸ��� ����
*/
-----------------< ������ �Լ� >----------------------------
/*
    <���ڿ��� ���õ� �Լ�>
    LENGTH / LENGTHB
    
    - LENGTH(���ڿ�) : �ش� ���޵� ���ڿ��� ���ڼ� ��ȯ.
    - LENGTHB(���ڿ�) : �ش� ���޵� ���ڿ��� ����Ʈ �� ��ȯ. (���� ��� ����)
    
    ��� ���� ���ڷ� ��ȯ -> NUMBER
    ���ڿ� : ���ڿ� ������ ���ͷ�, ���ڿ��� �ش��ϴ� �÷�
    
    �ѱ� : �� -> '��', '��', '��' => �ѱ��ڴ� 3BYTE���
    ����, ����, Ư������ : �ѱ��ڴ� 1BYTE���
*/
SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ!')
FROM DUAL; --> �������̺� : ��������̳� �����÷��� ���� �ѹ��� ����ϰ� ������ ����ϴ� ���̺�

--�̸���, ��� �̸��� �÷���, ���ڼ�, ����Ʈ ���ڼ�
SELECT 
    email,
    length(email),
    lengthb(email),
    emp_name,
    length(emp_name),
    lengthb(emp_name)
FROM EMPLOYEE;

/*
    INSTR
    - INSTR(���ڿ�, Ư������, ã�� ��ġ�� ���� ��, ����) : ���ڿ��κ��� Ư�� ��ġ�� ��ȯ.
    
    ã�� ��ġ�� ���۰�, ������ ���� ����
    ������� NUMBER Ÿ������ ��ȯ.
    
    ã�� ��ġ�� ���۰�(1 / -1)
   
*/
SELECT INSTR('AABAACAABBAA','B')FROM DUAL;
-- ã�� ��ġ , ������ ���� : �⺻������ �տ������� ù��° ������ ��ġ�� �˷���

SELECT INSTR('AABAACAABBAA','B', 1)FROM DUAL;
--���� ������ ����� ��ȯ.

SELECT INSTR('AABAACAABBAA','B', -1)FROM DUAL;
-- �ڿ��� ���� ù��° ������ ��ġ�� �˷���.

SELECT INSTR('AABAACAABBAA','B', -1, 2)FROM DUAL; -- 1 : �տ������� ã�ڴ�.(������ �⺻��)
--    -1 : �ڿ��� ���� ã�ڴ�.
-- �ڿ��� ���� �ι�° ��ġ�ϴ� B�� ���� ��ġ���� �տ��� ���� ���� �˷��ذ�.

SELECT INSTR('AABAACAABBAA','B', -1, 0)FROM DUAL;
-- ������ ��� ������ ������ ��� �����߻�.

SELECT INSTR(EMAIL, '@')
FROM EMPLOYEE;

/*
    SUBSTR (�ٸ� ���α׷������� SUBSTRING�ϼ���)
    
    ���ڿ����� Ư�� ���ڿ��� �����ϴ� �Լ�
    - SUBSTR(���ڿ�, ó����ġ, ������ ���� ����)
    
    ������� CHARACTERŸ������ ��ȯ(���ڿ�)
    ������ ���� ������ ��������(���������� ���ڿ� ������ ����.)
    ó����ġ�� ������ ���� ���� : �ڿ������� N��° ��ġ�κ��� ���ڸ� �����ϰڴ� ��� ��.
*/
SELECT SUBSTR('SHOWMETHEMONEY',7) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',5, 2) FROM DUAL;

SELECT SUBSTR('SHOWMETHEMONEY',-8, 3) FROM DUAL;
--THE
SELECT SUBSTR('SHOWMETHEMONEY',-5) FROM DUAL;
--MONEY

--�ֹε�Ϲ�ȣ���� ���� �κ��� �����ؼ� ����(1)����(2)�� üũ.
SELECT 
    emp_name,
    substr(emp_no, 8,1) AS "����"
FROM EMPLOYEE;
--�̸��Ͽ��� ID�κи� �����ؼ� ��ȸ.
SELECT
    emp_name,
    substr(email, 1, INSTR(email, '@')-1) AS "ID"
FROM EMPLOYEE;
--���ڻ���鸸 ��ȸ.
SELECT *
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8,1) ='1';

/*
    LPAD / RPAD
    
    -LPAD/RPAD(���ڿ�, ���������� ��ȯ�� ������ ����(BYTE), �����̰����ϴ� ����)
    : ������ ���ڿ��� �����̰����ϴ� ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ.
*/
SELECT LPAD(EMAIL, 16)
FROM EMPLOYEE;
-- �ڹ��� %5s�� ���� ����

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT 
    emp_name,
    emp_no
FROM EMPLOYEE;

-- 1�ܰ� : SUBSTR�Լ��� �̿��ؼ� �ֹι�ȣ �� 8�ڸ��� ����.
SELECT
    emp_name,
    substr(emp_no,1,8) AS �ֹι�ȣ
FROM EMPLOYEE;
-- 2�ܰ� : RPAD�Լ��� ��ø�ؼ� �ֹι�ȣ �ڿ� *���̱�
SELECT
    emp_name,
    RPAD(substr(emp_no,1,8),14, '*') AS �ֹι�ȣ
FROM EMPLOYEE;

SELECT 
    LPAD(substr(phone,4),11,'*') 
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,6),8,'?')
FROM EMPLOYEE;

SELECT
    RPAD(substr(hire_date,1,3),5,'?') || substr(hire_date,6,8)
FROM EMPLOYEE;

/*
    LTRIM / RTRIM
    
    - LTRIM/RTRIM(���ڿ�, ���Ž�Ű�����ϴ� ����)
    : ���ڿ��� ���� �Ǵ� �����ʿ��� ���Ž�Ű���� �ϴ� ���ڵ��� ã�Ƽ� ������ ������ ���ڿ��� ��ȯ.
    
    ������� CHARACTER ���·� ����. ���Ž�Ű���� �ϴ� ���� ���� ����(DEFAULT ' ')
*/

SELECT LTRIM('            K     H        ')
FROM DUAL;

SELECT RTRIM('            K     H        ')
FROM DUAL;

SELECT LTRIM('0001230456000' , '0')
FROM DUAL;

SELECT RTRIM('0001230456000' , '0')
FROM DUAL;

SELECT LTRIM('123123KH123', '132')
FROM DUAL;
--�ϳ��� ���ڿ� ���� �����ϰ��� �ϴ� ���ڰ� ��ġ�ϸ� ���ŵ� (���ڿ� ��°�� ���ŵǴ� ���� �ƴ�)
SELECT RTRIM('123123KH123', '123')
FROM DUAL;

SELECT LTRIM('ACABACCKH', 'ABC')
FROM DUAL; -- ���Ž�Ű���� �ϴ� ���ڿ��� ������ �����ִ°� �ƴ϶� ���� �ϳ��ϳ��� �� �����ϸ� �����ִ� ����.

/*
    TRIM
    
    - TRIM(BOTH/LEADING/TRAILING '�����ϰ��� �ϴ� ����' FROM '���ڿ�')
    : ���ڿ� ����, ����, ���ʿ� �ִ� Ư�� ���ڸ� ������ ������ ���ڿ� ��ȯ.
    
    ������� CHARACTER Ÿ�Թ�ȯ BOTH/LEADING/TRAILING�� ��������(DEFAULT BOTH)
*/

SELECT TRIM('         K    H          ')
FROM DUAL;

SELECT TRIM(BOTH 'Z' FROM 'ZZZZZZZZZZZZZZKHZZZZZZZZZZZ')
FROM DUAL;

SELECT TRIM(LEADING 'Z' FROM 'ZZZZZZZZZZZZZZKHZZZZZZZZZZZ')
FROM DUAL;
-- LEADING == LTRIM

SELECT TRIM(TRAILING 'Z' FROM 'ZZZZZZZZZZZZZZKHZZZZZZZZZZZ')
FROM DUAL;
-- TRAILING == RTRIM

/*
    LOWER/UPPER/INITCAP
    
    -LOWER(���ڿ�)
    : ���ڿ� ���� �ҹ��ڷ� ����
    
    -UPPER(���ڿ�)
    :���ڿ� ���� �빮�ڷ� ����
    
    -LINTCAP(���ڿ�)
    :�� �ܾ��� �ձ��ڸ� �빮�ڷ� ����.
*/

SELECT LOWER('Welcom to B class!'), UPPER('Welcom to B class!'), INITCAP('Welcom to B class!')
FROM DUAL;

/*
    CONCAT
    
    -CONCAT(���ڿ�1, ���ڿ�2)
    : ���޵� ���ڿ� �ΰ��� �ϳ��� ���ڿ��� ���ļ� ��ȯ.
*/

SELECT CONCAT('������', 'ABC')
FROM DUAL;

SELECT '������' || 'ABC'
FROM DUAL;

SELECT CONCAT(CONCAT('������','ABC'),'DEF')
FROM DUAL; --CONCAT�� �ΰ��� ���ڿ��� ����

/*
    REPLACE
    
    -REPLACE(���ڿ�, ã������, �ٲܹ���)
    : ���ڿ��κ��� ã�����ڸ� ã�Ƽ� �ٲܹ��ڷ� �ٲ� ���ڿ��� ��ȯ.
*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��')
FROM DUAL;

SELECT 
    emp_name,
    email,
    replace(email, 'kh.or.kr', 'iei.or.kh') as new_email
FROM EMPLOYEE;

-----------------------------------------------------------------

/*
    <���ڿ� ���õ� �Լ�>
    ABS
    
    - ABS(���밪�� ���� ����) : ���밪�� �����ִ� �Լ�
*/

-- 10 , -10 => 10

SELECT ABS(-10)
FROM DUAL;

SELECT ABS(-10.9)
FROM DUAL;

/*
    MOD
    -MOD(����, ������) : �� ���� ���� ���������� ��ȯ���ִ� �Լ�(�ڹ��� %)
*/

SELECT MOD(10, 3)
FROM DUAL;

SELECT MOD(-10, 3)
FROM DUAL;

SELECT MOD(10.9, 3)
FROM DUAL;

/*
    ROUND 
    
    -ROUND(�ݿø��ϰ����ϴ� ��, �ݿø��ϰ����ϴ� ��ġ) : �ݿø� ó�����ִ� �Լ�.
    
    �ݿø��� ��ġ : �Ҽ��� �������� �Ʒ� N��° ������ �ݿø��ϰڴ�.
                    ��������(�⺻���� 0, => �Ҽ��� ù��°���� �ݿø��ϰڴ�.)
*/

SELECT ROUND(123.456, 0)
FROM DUAL;

SELECT ROUND(123.456, 1)
FROM DUAL;

SELECT ROUND(123.456, -1)
FROM DUAL; --�Ҽ��� �Ʒ��� �ƴ϶� �����ڸ������� ��� ����.

/*
    CEIL
    
    -CEIL(�ø�ó���� ����) : �Ҽ��� �Ʒ��� ���� ������ �ø� ó�����ִ� �Լ�
*/

SELECT CEIL(123.456)
FROM DUAL;

SELECT CEIL(456.001)
FROM DUAL;

/*
    FLOOR
    
    -FLOOR(����ó���ϰ��� �ϴ� ����) : �Ҽ��� �Ʒ��� ���� ������ ����ó���ϴ� �Լ�.
*/

SELECT FLOOR(123.954)
FROM DUAL;

SELECT FLOOR(207.68)
FROM DUAL;

-- 1�ܰ� �� �������� �ٹ��ϼ�(����ð� - ��� ��¥) ���ϱ� ��, �Ҽ��� �Ʒ� ������
SELECT
    emp_name,
    FLOOR(SYSDATE - hire_date)AS "�ٹ��ϼ�"
FROM EMPLOYEE;
--2�ܰ� �ٹ��ϼ��� '��' �߰����ֱ�, ��Ī�ο� "�ٹ��ϼ�"
SELECT
    emp_name,
     CONCAT(FLOOR(SYSDATE - hire_date),'��') AS "�ٹ��ϼ�"
FROM EMPLOYEE
WHERE ENT_YN != 'Y';

SELECT
    emp_name,
     CONCAT(FLOOR(SYSDATE - ent_date),'��') AS "�ٹ��ϼ�"
FROM EMPLOYEE
WHERE ENT_YN = 'Y';

/*
    TRUNC
    - TRUNC(����ó���� ����, ��ġ) : ��ġ�� ���� ������ ���� ó���� ���ִ� �Լ�.
    
    ��ġ ��������, ������ DEFUALT = 0 => FLOOR
*/

SELECT TRUNC(123.786)
FROM DUAL;

SELECT TRUNC(123.786, 1)
FROM DUAL;

SELECT TRUNC(123.786, -1)
FROM DUAL;

------------------------------------------------------------------
/*
    <��¥ ���� �Լ�>
    DATE Ÿ�� : �⵵, ��, ��, ��, ��, �� �� �ִ� �ڷ���.
    
    SYSDATE : ���� �ý��� ��¥�� ��ȯ
*/

--1. MONTHS_BETWEEN(DATE1, DATE 2): �� ��¥ ������ �������� ��ȯ(NUMBER Ÿ�� ��ȯ)
--DATE�� �� �̷��� ��� ������ ����

--�� ������ �ٹ��ϼ�, �ٹ� ������
SELECT 
    emp_name,
    FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�",
    ABS(FLOOR(MONTHS_BETWEEN(HIRE_DATE, SYSDATE))) AS "�ٹ�������"
FROM EMPLOYEE;

SELECT 
    emp_name,
    FLOOR(SYSDATE - HIRE_DATE) AS "�ٹ��ϼ�",
    FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS "�ٹ�������"
FROM EMPLOYEE;

-- 2. ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ �������� ���� ��¥ ��ȯ(������� DATE Ÿ��)
SELECT ADD_MONTHS(SYSDATE, 12)
FROM DUAL;

--��ü ������� 1�� �ټ���(==�Ի��Ϸκ��� 1�ֳ�)
SELECT 
    emp_name,
    ADD_MONTHS(HIRE_DATE,12)
FROM EMPLOYEE;

--3. NEXT_DAY(DATE, ����(����,����)) : Ư�� ��¥���� ���� ����� �ش� ������ ã�Ƽ� ��ȯ.(DATE��ȯ)

SELECT NEXT_DAY(SYSDATE, '��')
FROM DUAL;

SELECT NEXT_DAY(SYSDATE, 7) -- 1. �Ͽ���, 2. ������, 3. ȭ���� .... 7. �����
FROM DUAL; --�ǵ��� ���ڷ� ���

-- �� �����ؼ� ������ ����.
-- DDL
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

SELECT NEXT_DAY(SYSDATE, 'SATURDAY') --���� ���õ� �� �ѱ����̱⶧���� ������ �߻���.
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- 4. LAST_DAY(DATE) : �ش� Ư����¥ ���� ������ ��¥�� ���ؼ� ��ȯ(DATE ��ȯ)
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--�̸�, �Ի���, �Ի��� ��¥�� ������ ��¥ ��ȸ.
SELECT
    emp_name,
    hire_date,
    LAST_DAY(hire_date)
FROM EMPLOYEE;

-- 5. EXTRACT : �⵵, ��, ���� ������ �����ؼ� ��ȯ(������� NUMBER)
/*
    -EXTRACT(YEAR FROM ��¥) : Ư����¥�κ��� �⵵�� ����.
    -EXTRACT(MONTH FROM ��¥) : Ư����¥�κ��� ���� ����.
    -EXTRACT(DAY FROM ��¥) : Ư����¥�κ��� �ϸ� ����.
    
    90/02/06
    
*/

SELECT 
    EXTRACT(YEAR FROM SYSDATE),
    EXTRACT(MONTH FROM SYSDATE),
    EXTRACT(DAY FROM SYSDATE)
FROM DUAL;
-- 2022 - 08 - 22

--1�ܰ� �����, �Ի� �⵵, �Ի��, �Ի��� ��ȸ
--2�ܰ�, �Ի�⵵, �Ի��, �Ի��� �������� �������� ����.

SELECT
    emp_name,
    EXTRACT(YEAR FROM hire_date) AS "�Ի�⵵",
    EXTRACT(MONTH FROM hire_date) AS "�Ի��",
    EXTRACT(DAY FROM hire_date) AS "�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";
----------------------------------------------------------------
/*
    <����ȯ�Լ�>
    NUMBER/DATE => CHARCTER
    
    -TO_CHAR(NUMBER/DATE, ����)
    : ������ �Ǵ� ��¥�� �����͸� ������ Ÿ������ ��ȭ(���˿� ���缭)
*/
SELECT TO_CHAR(1234)
FROM DUAL;

SELECT TO_CHAR(1234,'00000')
FROM DUAL; --> 1234 -> '01234'(������) : ��ĭ�� 0���� ä��

SELECT TO_CHAR(1234, '99999')
FROM DUAL; --> 1234 = '1234' : ��ĭ�� ' ' ���� ä��

SELECT TO_CHAR(1234, 'L00000')
FROM DUAL; -- L : LOCAL => ���� ������ ������ ȭ�����.
-- 1234 => '\01234'

SELECT TO_CHAR(1234, 'L99999')
FROM DUAL; -- 1234 -> \ 1234

SELECT TO_CHAR(1234, 'L99,999')
FROM DUAL;

-- �޿������� 3�ڸ����� ,�� ��� Ȯ��
SELECT 
    emp_name, 
    TO_CHAR(SALARY, 'L999,999,999') AS "�޿�"
FROM EMPLOYEE;

--��¥�� ���ڿ��� ����
SELECT TO_CHAR(SYSDATE)
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

-- �� �� �� : HH:MI:SS
--PM ���� / AM ����
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS')
FROM DUAL;

--�� �� �� 24�ð� ����
SELECT TO_CHAR(SYSDATE, 'HH24:MI:SS')
FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM DUAL; -- ��(���) ��(����), 2022(��) : MONTH, DY - DAY ���, �� ����

SELECT 
    TO_CHAR(SYSDATE, 'YYYY'),
    TO_CHAR(SYSDATE, 'RRRR'),
    TO_CHAR(SYSDATE, 'YY'),
    TO_CHAR(SYSDATE, 'YEAR')
FROM DUAL;
-- YY�� RR�� ������
-- R�� ROUND�� ����.
-- YY : ���ڸ��� ������ (�⵵ 20)�� ���� (YY�� ���� ���)
-- RR : 50�� �������� ������20�� �ٰ�, ũ�� 19�� ���� -> (19)89 / (20)49

SELECT 
    TO_CHAR(SYSDATE , 'MM'),
    TO_CHAR(SYSDATE , 'MON'),
    TO_CHAR(SYSDATE , 'MONTH'),
    TO_CHAR(SYSDATE , 'RM')
FROM DUAL;

SELECT
    TO_CHAR(SYSDATE, 'D'),
    TO_CHAR(SYSDATE, 'DD'),
    TO_CHAR(SYSDATE, 'DDD')
FROM DUAL;
--D : 1���� �������� �Ͽ��Ϻ��� ��ĥ°���� �˷��ִ� ����(1-�Ͽ���, 2-������)
--DD : 1�� �������� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����
--DDD : 1�� �������� 1�� 1�Ϻ��� ��ĥ°���� �˷��ִ� ����

SELECT 
    TO_CHAR(SYSDATE, 'DY'),
    TO_CHAR(SYSDATE, 'DAY')
FROM DUAL; --������ �ֳ� ���� ����

--1�ܰ� �����, �Ի��� 0000�� 00�� 00�� (��)���� ��Ī AS "�Ի���"
SELECT
    emp_name, 
    TO_CHAR(HIRE_DATE,'YYYY"��" MM"��" DD"��" DAY') AS "�Ի���"
FROM EMPLOYEE;
--2�ܰ� �Ի����� 10/01/01 �̻��� ����� ���
SELECT
    emp_name, 
    TO_CHAR(hire_date,'YYYY"��" MM"��" DD"��" DAY') AS "�Ի���"
FROM EMPLOYEE
--WHERE HIRE_DATE >= '10/01/01';
WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2010;

/*
    NUMBER/CHARACTER -> DATE
    -TO_DATE(NUMBER/CHARACTER , ����) : ������ �Ǵ� ������ �����͸� ��¥������ ��ȯ.
*/

SELECT TO_DATE('20220821')
FROM DUAL;

SELECT TO_DATE('000101')
FROM DUAL; --0���� �����ϴ� �⵵�� �ݵ�� Ȧ����ǥ�� ��� ���ڿ��� �ٷ�� ��.

SELECT TO_DATE('20100101','YYYYMMDD')
FROM DUAL;

SELECT TO_DATE('041030 143021', 'YYMMDD HH24:MI:SS')
FROM DUAL;

SELECT TO_DATE('980630', 'RRMMDD')
FROM DUAL;--�⵵�� ���ڸ��� 1900�⵵�̸� RR���

SELECT TO_DATE('19980630', 'YYYYMMDD')
FROM DUAL;

/*
    CHARACTER => NUMBER
    
    -TO_NUMBER(CHARCATER, ����) : ������ �����͸� ���������� ��ȯ
*/

--�ڵ�����ȯ ����(���ڿ� => ����)
SELECT '123' + '123'
FROM DUAL;

SELECT TO_NUMBER('123')+TO_NUMBER('123')
FROM DUAL;

SELECT '10,000,000' + '550,000'
FROM DUAL;--����(,)�� ���ԵǾ� �־ �ڵ� ����ȯ�� �ȵ�

SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000','999,999')
FROM DUAL; --10550000 : ����ȯ �� �� ���������� �����. 

SELECT TO_NUMBER('0123')
FROM DUAL;
--------------------------------------------------

/*
    <NULL ó�� �Լ�>
    --NVL(�ķ���, �ش� �÷����� NULL�� ��� ��ȯ�� ��ȯ��)
    --�ش� �÷����� ������ ���(NULL�� �ƴѰ��) ������ �÷����� ��ȯ.
    --�ش� �÷����� �������� ���� ���(NULL�� ���) ���� ������ Ư������ ��ȯ.
*/

--�����, ���ʽ�, ���ʽ��� ���� ��� 0���� ���
SELECT
    emp_name,
    NVL(BONUS, 0) AS "���ʽ�"
FROM EMPLOYEE;

SELECT
    emp_name,
    (salary + (salary * NVL(bonus, 0))) AS "���ʽ� ���� ����"
FROM EMPLOYEE;

--������, �μ��ڵ�(���� ��� '����')��ȸ
SELECT
    emp_name,
    NVL(dept_code, '����') AS "�μ��ڵ�"
FROM EMPLOYEE;

--NVL2(�÷���, �����1, �����2)
--�ش� �÷����� NULL�� �ƴ� ��� ����� 1 ��ȯ.
--�ش� �÷����� NULL�� ��� ����� 2 ��ȯ.

--���ʽ��� �ִ� ����� '���ʽ� ����', '���ʽ� ����' ��Ī "���ʽ� ����"
SELECT
    emp_name,
    bonus,
    NVL2(bonus, '���ʽ� ����', '���ʽ� ����') AS "���ʽ� ����"
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2) : �����
--�� ���� ������ ��� NULL ��ȯ.
--�� ���� �������� ���� ��� �񱳴��1 ��ȯ.
SELECT NULLIF('123','123')
FROM DUAL;

SELECT NULLIF('123','456')
FROM DUAL;

--���� �Լ� : DECODE => SWITCH��
--���� �Լ� ģ�� : CASE WHEN THEN ���� => IF��

/*
    <�����Լ�>
    
    -DECODE(�񱳴��, ���ǰ�1, �����1, ���ǰ�2, �����2 ....., ���ǰ�N, �����N, ����� N+1)
    
    �񱳴�󿡴� �÷���, �������(����� ����), �Լ��� �� �� �ִ�.
*/

--���, �����, �ֹε�Ϲ�ȣ, �ֹε�Ϲ�ȣ�κ��� ���� �ڸ��� ����(1, 3�̸� ����, 2 4�� ����)
SELECT
    emp_id,
    emp_name,
    emp_no,
    DECODE(SUBSTR(emp_no, 8, 1), '1', '��', '3', '��', '2', '��', '4', '��') AS "����"
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
--�����ڵ尡 'J7'�� ����� �޿��� 10%�λ��ؼ� ��ȸ
--�����ڵ尡 'J6'�� ����� �޿��� 15%�λ��ؼ� ��ȸ
--�����ڵ尡 'J5'�� ����� �޿��� 20%�λ��ؼ� ��ȸ
--�׿� �����ڵ��� ����� �޿��� 5%�λ��ؼ� ��ȸ.
--�����, �����ڵ�, ���� �� �޿�, ���� �� �޿�
SELECT
    emp_name,
    job_code,
    salary,
    DECODE(job_code, 
                    'J7', salary * 1.1, 
                    'J6', salary * 1.15, 
                    'J5', salary * 1.2, 
                    salary * 1.05) AS "������ �޿�"
FROM EMPLOYEE;

/*
    CASE WHEN TEHN ����
    - DECODE ���� �Լ��� ���ϸ� DECODE�� �ش� ���� �˻� �� ���� �񱳸� ����.
      CASE WHEN THEN ������ ��� Ư�� ������ �� ������� ���� ����.
    
    [ǥ����]
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         WHEN ���ǽ�N THEN �����N
         ELSE �����
    END
*/
-- ���, �����, �ֹε�Ϲ�ȣ, �ֹε�Ϲ�ȣ�κ��� �����ڸ� �����ؼ�(1,3 ��)(2,4 ��)
SELECT
    emp_id,
    emp_name,
    emp_no,
    CASE WHEN SUBSTR(emp_no, 8, 1) IN (1,3) THEN '��'
         WHEN SUBSTR(emp_no, 8, 1) IN (2,4) THEN '��'
    END AS "����"
FROM EMPLOYEE;

SELECT
    emp_name,
    job_code,
    salary,
    CASE WHEN JOB_CODE = 'J7' THEN salary * 1.1
         WHEN JOB_CODE = 'J6' THEN salary * 1.15
         WHEN JOB_CODE = 'J5' THEN salary * 1.2
         ELSE salary * 1.05
    END AS "������ �޿�"
FROM EMPLOYEE;

-- �����, �޿�, �޿� ���
-- �޿� ��� SALARY ���� 500���� �ʰ��� ��� '���'
-- 500���� ���� 350���� �ʰ��� ��� '�߱�'
--350���� ������ ��� '�ʱ�'

SELECT
    emp_name,
    salary,
    CASE WHEN SALARY > 5000000 THEN '���'
         WHEN SALARY > 3500000 THEN '�߱�'
         WHEN SALARY <= 3500000 THEN '�ʱ�'
    END AS "�޿����"
FROM EMPLOYEE;

-------------------------------<�׷��Լ�>---------------------------------
-- �׷��Լ� : �����͵��� ��(SUM), ���(AVG)
/*
    N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ���� ��� ��ȯ)
*/
--1. SUM(����Ÿ�� Ŀ��) : �ش� �÷������� �� �հ踦 ��ȯ���ִ� �Լ�.
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �μ��ڵ尡 'D5'�� ������� �� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--���� ������� �� �޿� �հ�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

--2. AVG(����Ÿ���� �÷�) : �ش��÷������� ����� ���ؼ� ��ȯ.
SELECT ROUND(AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(ANYŸ��) : �ش� �÷����߿� ���� ������ ��ȯ
-- 4. MAX(ANYŸ��) : �ش� �÷����߿� ���� ū �� ��ȯ

SELECT MAX(SALARY), MIN(EMP_NAME), MAX(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT 
    emp_name,
    EMAIL,
    HIRE_DATE
FROM EMPLOYEE
ORDER BY EMAIL;

-- 5. COUNT(*/�÷��̸�*/DISTINCT �÷��̸�) : ��ȸ�� ���� ������ ���� ��ȯ.
--COUNT(*) : ��ȸ����� �ش��ϴ� ������� �� ���� ��ȯ (����ȿ�� 1��)
--COUNT(�÷��̸�) : ������ �ش� �÷����� NULL �ƴѰ͸� ���� ������ ���� ��ȯ. (����ȿ�� 2��)
--COUNT(DISTINICT �÷��̸�) : ������ �ش� �÷����� �ߺ����� ���� ��� �ϳ��θ� ���� ��ȯ. NULL ���� X (����ȿ�� 3��)

-- ��ü ������� ���� ��ȸ
SELECT COUNT(*)
FROM EMPLOYEE;

--���� ������� ��ȸ
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

--�μ���ġ�� �Ϸ�� �����
-- DEPT_CODE NULL �ƴ� ���
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- �μ���ġ�� �Ϸ�� ���� �����
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = 2;

--����� �ִ� ��� ��
SELECT 
    COUNT(MANAGER_ID)
FROM EMPLOYEE;

--���� ������� �����ִ� �μ��� ����.
SELECT 
    COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

--���� ������� ��ȿ�� ������ ����
SELECT 
    COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ������, �μ��ڵ�, �������, ���� ��ȸ.
-- ��, ��������� �ֹι�ȣ���� �����ؼ� 00�� 00�� 00�Ϸ� ��µǰ��ϰ�,
-- ���̴� �ֹι�ȣ���� ����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���
SELECT 
    emp_name,
    dept_code,
    TO_CHAR(TO_DATE(SUBSTR(emp_no,1,6)),'YY"��" MM"��" DD"��"') AS "�������",
    --����⵵ - ����⵵
    EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM TO_DATE(SUBSTR(emp_no,1,6),'RR MM DD'))   AS "����"
FROM EMPLOYEE;

SELECT 
    emp_name,
    dept_code,
    TO_CHAR(TO_DATE(SUBSTR(emp_no,1,6)),'YYYY"��" MM DD"��"') AS "�������",
    EXTRACT (YEAR FROM SYSDATE) - EXTRACT (YEAR FROM TO_DATE(SUBSTR(emp_no,1,2),'RR'))   AS "����"
FROM EMPLOYEE;
