/*
    <INDEX>
    책에서 목차같은 역할
    
    만약 목차가 없다면? 내가 원하는 쳅터, 칼럼이 어디에 있는지 모르니 모든 책을 하나하나 훑어 봐야 함.
    
    마찬가지로 테이블에서 JOIN 혹은 서브쿼리로 데이터를 조회(SELECT)할 때
    인덱스가 없다면 테이블의 모든 데이터를 하나하나 뒤져서(FULL-SCAL)내가 원하는 데이터를 가져올 것임.
    
    따라서 인덱스 설정을 해두면 모든 테이블을 뒤지지 읺고 내가 원하는 조건만 빠르게 가져올 수 있을 것임.
    
    인덱스 특징
    - 인텍스로 설정한 칼럼의 데이터들을 별도로 '오름차순'으로 정렬하여 특정메모리 공간에 물리적주소(ROWID)와 함께 저장시킴
    => 즉, 메모리에 공간을 차지한다.
*/
-- (100만건 이상정도 됬을때 꼭 필요함.)
-- 현재 계정에 생성된 인덱스들 확인.
SELECT * FROM USER_INDEXES; -- 12건 생성되어 있음. PRIMARY KEY(PK)가 자동으로 인덱스로 만들어짐.
-- PK설정시 자동으로 인덱스가 생성된다.

-- 현재 계정의 인덱스와 인덱스가 적용된 칼럼을 확인시 
SELECT * FROM USER_IND_COLUMNS;

-- 실행계획확인.
SELECT * 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '송종기';

-- EMP_NAME으로 INDEX만들고 실행계획 비교
-- 인덱스 생성방법
-- [표현법]
-- CREATE INDEX 인덱스명 ON 테이블명(칼럼명);
CREATE INDEX EMPLOYEE_EMP_NAME ON EMPLOYEE(EMP_NAME);

-- 실행계획 다시 확인
SELECT * 
FROM EMPLOYEE 
JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
WHERE EMP_NAME = '송종기';

-- (INDEX과정이 추가되었음. (RANGE SCAN))
-- (테이블 전체내용 조회에는 필요없고 10 ~ 15% 사이에 사용하면 효율이 좋다고 함.)
-- 우리가 인덱스를 만들고 조건절에 해당 컬럼을 사용해도, 인덱스를 사용하지 않는 경우도 있음. 
-- 해당 인덱스를 탈지 안탈지는 옵티마이저가 판단한다.

-- 인덱스 삭제
DROP INDEX EMPLOYEE_EMP_NAME;

-- 여러칼럼에 인덱스를 부여할 수 있음. 
CREATE INDEX EMPLOYEE_EMP_NAME_DEPT_CODE ON EMPLOYEE(EMP_NAME, DEPT_CODE);

SELECT * FROM EMPLOYEE
WHERE EMP_NAME = '박나라' AND DEPT_CODE = 'D5';
-- 실행계획 확인하면 만들어둔 INDEX를 타지 않음.

DROP INDEX EMPLOYEE_EMP_NAME_DEPT_CODE;

/*
    인덱스를 효율적으로 쓰기 위해선?
    데이터의 분포도가 높고, 조건절에 자주 호출되며, 중복값은 적은 컬럼이 제일 좋다.
    => 즉 PK칼럼이 제일 효율이 좋다.
    
    1) 조건절에 자주 등장하는 칼럼
    2) 항상 = 으로 비교되는 칼럼
    3) 중복되는 데이터가 최소한인 컬럼( == 분포도가 높다.)
    4) ORDER BY 절에서 자주 사용되는 칼럼
    5) JOIN 조건으로 자주 사용되는 칼럼
*/

-- INDEXTEST 아이디 계정생성
CREATE USER INDEXTEST IDENTIFIED BY INDEXTEST;
--RESOURCE, CONNECT 권한 부여
GRANT RESOURCE, CONNECT TO INDEXTEST;