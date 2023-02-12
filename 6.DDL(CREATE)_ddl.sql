/*
    DDL(DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를
    새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 명령문.
    즉, 구조 자체를 정의하는 언어로 DB관리자, 설계자가 사용함.
    
    오라클에서의 객체(DB를 이루는 구조물들)
    테이블(TABLE), 사용자(USER), 함수(FUNCTION), 뷰(VIEW), 시퀀스(SEQUENCE), 
    인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER), 프로시저(PROCEDURE), 
    동의어(SYNONYM)
*/

/*
    < CREATE TABLE >
    테이블 : 행(ROW), 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체 종류 중 하나.
            모든 데이터는 테이블을 통해서 저장됨(데이터를 조작하고자 하려면 무조건 테이블을 만들어야함)
            
    [표현법]
    CREATE TABLE 테이블명 (
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형,
    NAME DATE
    ...
    )
    
    <자료형>
    - 문자 (CHAR(크기)/VARCHAR2(크기)) : 크기는 BYTE단위임. (숫자, 영어, 특수문자 -> 글자당 1 BYTE),
            
            CHAR(바이트수) : 최대 2000BYTE까지 지정 가능.
                            고정길이(아무리 작은 값이 들어와도 공백으로 채워서 처음 할당한 크기를 유지함)
                            주로 들어올 값의 글자수가 정해져 있을 경우 사용
                            EX) 성별 : M/F, 주민번호 : 14글자
                    
            VARCHAR2(바이트수) : 최대 4000BYTE까지 지정 가능
                               가변길이(적은값이 들어올 경우 그 담긴 값에 맞춰 크기가 줄어든다.)
                               VAR는 '가변' , 2는 2배를 의미한다.
                               주로 들어올 값의 글자수가 정해지지 않은 경우 사용.
                               EX) 이름 , 아이디 , 비밀번호 등등등.
                               
            숫자(NUMBER) : 정수/실수 상관 없이 NUMBER 하나.
           
            날짜(DATE) : 년/월/일/시/분/초 형식으로 시간 지정.    
*/
--회원들의 데이터(아이디, 비밀번호, 이름, 생년월일)를 담기 위한 테이블 MEMBER생성
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20), -- 대소문자 구분X, 낙타봉 표기법이 의미가없어서 언더스코어로 표기.
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_BDATE DATE
);

--테이블 확인방법
-- 1) 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고있는 시스템 테이블.
SELECT *
FROM USER_TABLES;
-- 2) 접속 탭에서 확인하기.
-- 3) 직접 조회
SELECT * FROM MEMBER;

--참고 사항 : 컬럼들 확인법.
SELECT *
FROM USER_TAB_COLUMNS;
--USER_TAB_COLUMNS : 현재 이 사용자 계정이 가지고 있는 테이블의 모든 컬럼정보를 조회할수 있는 시스템 테이블.
-- 컬럼에 주석달기

/*
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석 내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
--회원비밀번호
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
--회원이름
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
--생년월일
COMMENT ON COLUMN MEMBER.MEMBER_BDATE IS '생년월일';

SELECT *
FROM MEMBER;
--데이터 추가
--INSERT(DML) : 데이터를 추가할 수 있는 구문.
--한 행으로 추가(행을 기준으로 추가), 추가할 값을 기술(값의 순서 중요)
--[표현법]
--INSERT INTO 테이블명 VALUSES(첫번째 컬럼의 값, 두번째 컬럼의 값, ...)
INSERT INTO MEMBER VALUES ('user01', 'pass01', '홍길동1', '1980-10-06');

INSERT INTO MEMBER VALUES ('user02', 'pass02', '홍길동2', '1980-10-07');

INSERT INTO MEMBER VALUES ('user03', 'pass03', '홍길동3', '1980-10-08');

INSERT INTO MEMBER VALUES (NULL, NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES ('user03', 'pass03', '홍길동3', '1980-10-08');

--위의 null값이나 중복된값은 유효하지 않은값이다.
-- 유요한 데이터값을 유지하기 위해서 제약조건이란것을 걸어줘야함.
--제약조건을 통해 데이터의 무결성 보장이 가능해짐.

--제약조건 : 테이블을 만들때 지정가능, 후에 수정, 추가 가능.

/*
    <제약조건 CONATRAINTS>
    -
    원하는 데이터값만 유지하기 위해서(보관하기 위해서)특정 컬럼마다 설정하는 제약
    (데이터 무결성 보장을 목적으로)
    - 제약조건이 부여된 컬럼에 들어올 데이터에 문제가 있는지 없는지 자동으로 검사할 목적
    
    - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
    
    -컬럼에 제약조건을 부여하는 방식 : 컬럼레벨 방식 / 테이블 레벨 방식.
*/
/*
    1. NOT NULL 제약조건
    -> 즉, NULL값이 절대 들어와서는 안되는 컬럼에 부여하는 제약조건
        삽입 / 수정 시 NULL값을 허용하지 않도록 제한하는 제약조건
        주의사항 : 컬럼레벨 방식밖에 안됨.
    해당컬럼에 반드시 값이 존재해야만 할때 사용.
*/
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건 => 제약조건을 부여하고자 하는 컬럼뒤에 곧바로 기술.
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
(1, 'user01', 'pass01', '홍길동', '남', '010-4121-5555', 'ghdrlfehd@iei.or.kr');

INSERT INTO MEM_NOTNULL VALUES
(2, 'user02', NULL, NULL, NULL, NULL, NULL);
-- DDL계정에 MEM_NOTNULL테이블에는 MEM_PWD라는 컬럼이 있는데 거기에는 NULL을 넣을수 없다.
--> NOT NULL 제약조건에 위배되었다.
INSERT INTO MEM_NOTNULL VALUES
(2, 'user02', 'pass02', '홍길동2', NULL, NULL, NULL);

select * from mem_notnull;
/*
    2. UNIQUE 제약조건
    컬럼에 중복값을 제한하는 제약조건.
    삽입 / 수정 시 기존에 해당 컬럼값 중에 중복된 값이 있는 경우
    추가 또는 수정이 되지 않게끔 제약시킴.
    
    컬럼레벨방식 / 테이블레벨방식 둘다 가능.
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
    UNIQUE(MEM_ID) -- 테이블레벨 방식.
);

INSERT INTO MEM_UNIQUE 
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-4121-5555', 'ghdrlfehd@iei.or.kr');
--동일한 쿼리문 두번 실행시켰을때 UNIQUE 제약조건에 위배되었으므로 INSERT 실패함
--unique constraint (DDL.SYS_C007039) violated
--어느 컬럼에 어느 문제가 있는지 구체적으로 알려주지 않음.
--DDL.SYS_C007039 : 제약조건의 이름으로만 제약조건 위배를 알려줌.
--제약조건 부여시 직접 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명 부여.

INSERT INTO MEM_UNIQUE 
VALUES(2, 'user02', 'pass02', '홍길동2', NULL, NULL, NULL);
select * FROM MEM_UNIQUE;
/*
    * 제약조건 부여시 제약조건 명도 지정하는 표현법.
    
    >컬럼레벨 방식
    CREATE TABLE 테이블명 (
         컬럼명 자료형 제약조건1 제약조건2,
         컬럼명 자료형 CONSTRAINT 제약조건명 제약조건,
         컬럼형 자료형
    );
    
    > 테이블레벨 방식
    CREATE TABLE 테이블명 (
        컬럼형 자료형,
        컬럼형 자료형,
        컬럼형 자료형,
        ...
        CONSTRAINT  제약조건명 제약조건(컬럼명)
    )
    
    -> 두 방식 모두 CONSTRAINT제약조건명 부분은 생략가능.
*/
CREATE TABLE MEM_CON_NM(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_ID_UQ UNIQUE, --컬럼레벨방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
    --,CONSTRAINT MEM_ID_UQ UNIQUE(MEM_ID) --테이블레벨 방식
);
INSERT INTO MEM_CON_NM VALUES(
1, 'user01', 'pass01', '홍길동', '남', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);
-- 두번 INSERT시 오류발생 : unique constraint (DDL.MEM_ID_UQ) violated
-- 어떤 컬럼에 어떤 종류의 제약조건인지 잘 조합해서 짓기.
select * from mem_con_nm;

INSERT INTO MEM_CON_NM VALUES(
2, 'user02', 'pass02', '홍길동2', '여', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);

INSERT INTO MEM_CON_NM VALUES(
3, 'user03', 'pass03', '홍길동', '나', '010-1111-1111', 'ghdrlfehd@iei.or.kr'
);

/*
    3. CHECK 제약조건
    
    컬럼에 기록될 수 있는 값에 대한 조건을 설정할 수 있다.
    EX) 성별 '남' 또는 '여'만 들어오게끔 하고 싶다.
    
    [표현법]
    CHECK (조건식)
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT MEM_CHECK_ID_UQ UNIQUE, -- 컬럼레벨방식,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL -- 회원가입일
);

INSERT INTO MEM_CHECK VALUES(
1, 'u1', 'pass01', '홍길동', '남', '010-1111-1111', 'ghdrlfehd@iei.or.kr', SYSDATE);

select * FROM MEM_CHECK;

INSERT INTO MEM_CHECK VALUES(
2, 'u2', 'pass02', '홍길동2', NULL, '010-1111-1111', 'ghdrlfehd@iei.or.kr', SYSDATE);
-- 만약에 CHECK제약조건을 걸고 안에 NULL이 들어가는경우 정상적으로 INSERT가됨.
-- 추가적으로 NULL값을 못들어오게 하고싶다면 NOT NULL 제약조건도 같이 걸어주면됨.
/*
    DEFAULT 설정.
        특정 컬럼에 들어온 값에 대한 기본값 설정 가능
        제약조건은 아님.
        EX) 회원가입일 컬럼에 회원정보가 삽입된 순간의 시간을 기록하고 싶다.
        -> DEFAULT 설정으로 SYSDATE 넣으면됨
*/

DROP TABLE MEM_CHECK;
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨방식,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- 회원가입일
    --DEFAULT 설정을 '반드시' 먼저하고 제약조건을 걸어줘야함.
);

INSERT INTO MEM_CHECK VALUES
(1, 'user01', 'pass02', '홍길동', '남', '010-1111-1111', 'ghdrlfehd@iei.or.kr');

/*
    INSERT INTO MEM_CHECK(컬럼명들 나열)
    VALUES(값들 나열)
*/
INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user01', 'pass01', '홍길동', '남');

/*
    PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들의 정보를 유일하게 식별 할 수 있는 컬럼에 부여하는 제약조건.
    => 각 행들을 구분할 수 있는 식별자의 역할.
    예) 사번, 부서아이디, 직급코드, 회원번호 ...
    => 식별자의 조건 : 중복되어서는 안됨, 값이 없으면 안됨 => (NOT NULL + UNIQUE)
    
    주의사항 : 한 테이블 당 한개의 컬럼값만 기본키로 지정 가능.
*/

CREATE TABLE MEM_PRIMARYKEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨방식,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- 회원가입일
    --DEFAULT 설정을 '반드시' 먼저하고 제약조건을 걸어줘야함.
);
INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user01', 'pass01', '홍길동', '남');

INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES('1', 'user02', 'pass02', '홍길동2', '남');
-- 기본키 컬럼의 중복으로 인한 오류가 발생했다.
-- ORA-00001: unique constraint (DDL.MEM_PK) violated

INSERT INTO MEM_PRIMARYKEY1(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(NULL, 'user02', 'pass02', '홍길동2', '남');
-- 기본키 컬럼에 null 값을 넣으려고하면 에러 발생
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY1"."MEM_NO")

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, -- 컬럼레벨방식,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- 회원가입일
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO) --테이블레벨방식
);
-- name already used by an existing constraint
-- 제약조건의 이름은 중복될 수 없다. 다른 테이블에 있더라도.

-- table can have only one primary key
-- primary key가 한테이블에 두개 이상이 될 수 없다.
-- 단, 두 컬럼을 묶어서 한번에 primary key로 설정 가능. => 테이블레벨방식으로만 가능.

DROP TABLE MEM_PRIMARYKEY2;
CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20), -- 컬럼레벨방식,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) NOT NULL CHECK (GENDER IN ('남' , '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- 회원가입일
    CONSTRAINT MEM_PK2 PRIMARY KEY(MEM_NO, MEM_ID) --테이블레벨방식
);
-- 두 컬럼을 묶어서 하나의 PRIMARY KEY로 설정 -> 복합키.
INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user01', 'pass01', '홍길동', '남');

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user02', 'pass01', '홍길동', '남');

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, 'user01', 'pass01', '홍길동', '남');
-- 복합키일 경우에는 두 컬럼의 값이 완전히 중복되어야만 제약조건에 위배가 된다.

INSERT INTO MEM_PRIMARYKEY2(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER)
VALUES(1, NULL, 'pass01', '홍길동', '남');
-- cannot insert NULL into ("DDL"."MEM_PRIMARYKEY2"."MEM_ID")
-- 복합키일 경우 한 컬럼의 값이라도 null이면 제약조건에 위배된다.

/*
    5. FOREIGN KEY (외래키)
        해당 컬럼에 다른 테이블에 존재하는 값만 들어와야 하는
        컬럼에 부여하는 제약조건
        => "다른테이블(부모 테이블)을 참조한다"라고 표현
            즉, 참조된 다른테이블(부모 테이블)이 제공하는 있는 값만 들어올 수 있다.
            EX) KH 계정에서
             EMPLOYEE 테이블(자식테이블) <----------------------DEPARTMENT테이블(부모 테이블)
                    DEPT_CODE                                       DEPT_ID
                => DEPT_CODE에는 DEPT_ID에 존재하는 값들만 들어올 수 있다.
                
            => FORIGN KEY 제약조건 (==연결고리)으로 다른 테이블과 관계를 형성할 수 있다. (== JOIN)
            
            [표현법]
            > 컬럼레벨 방식
            컬럼명 자료형 CONSTRAINT 제약 조건명 REFERENCES 참조할 테이블명(참조할 컬럼명)
            > 테이블 레벨 방식
            CONSTRAINT 제약조건명 FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명(참조할 컬럼명)
            
            참조할 테이블 == 부모 테이블
            생략 가능한것 : CONSTRAINT 제약조건명, 참조할 컬럼명(두 방식 모두 해당됨)
            -> 자동적으로 참조할 테이블의 PRIMARY KEY에 해당되는 컬럼이 참조할 컬럼명으로 잡힘.
            
            주의사항 : 참조할 컬럼타입과 외래키로 지정한 컬럼타입이 같아야한다. 
*/
--부모테이블
-- 회원의 등급에 대한 테이블(등급코드, 등급명) 보관하는 테이블.
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY, --등급코드 / 문자열('G1', 'G2', 'G3',....)
    GRADE_NAME VARCHAR2(20) NOT NULL -- 등급명 / 문자열 ('일반회원', '우수회원', '특별회원')
);

INSERT INTO MEM_GRADE VALUES('G1', '일반회원');
INSERT INTO MEM_GRADE VALUES('G2', '우수회원');
INSERT INTO MEM_GRADE VALUES('G3', '특별회원');
SELECT * FROM MEM_GRADE;

-- 회원정보를 담는 자식테이블 생성
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE, --컬럼레벨방식
    GENDER CHAR(3) CHECK(GENDER IN('남', '여')) NOT NULL, -- CHECK 제약조건으로 남, 여 들어갈 수 있도록
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL --디폴트값으로 현재시간을 저장하고 NOT NULL제약조건을 가짐
    -- FORDIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) --테이블레벨방식
);
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (1, 'user01', 'pass01', '홍길동', '남', 'G1');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (2, 'user02', 'pass02', '홍길동', '남', 'G2');


INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (3, 'user03', 'pass03', '홍길동', '남', 'G3');

--외래키 제약조건에는 NULL값이 들어갈 수 있다.
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (4, 'user04', 'pass04', '홍길동', '남', NULL);

--G4등급은 MEM_GRADE 테이블의 GRADE_CODE에 있는 값이 아님
INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID)
VALUES (5, 'user05', 'pass05', '홍길동', '남', 'G4');

SELECT * FROM MEM;

-- 문제) 부모테이블에서 데이터가 삭제된다면?
-- MEM_GRADE 테이블로부터 GRADE_CODE G1인 데이터만 삭제해보기
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
--자식테이블(MEM)중에 GRADE_ID컬럼에서 G1값을 이미 참조해서 사용중이기 때문에 삭제할 수 없음.
--오류 : ORA-02292: integrity constraint (DDL.SYS_C007098) violated - child record found

-- 현재 외래키 제약조건 부여시 삭제에 대한 옵션을 따로 부여하지 않음.
-- -> 기본적으로 삭제 제한 옵션이 걸려있음.

DROP TABLE MEM;

/*
    자식테이블 생성시(==외래키 제약조건을 부여했을때)
    부모테이블의 데이터가 삭제되었을때 자식테이블에는 어떻게 처리할 지를 옵션으로 정해둘 수 있다.
    
    FOREIGN KEY 삭제옵션
    -ON DELETE SET NULL : 부모데이터를 삭제할때 해당 데이터를 사용하는 자식데이터를 NULL로 바꾸겠다.
    -ON DELETE CASCADE : 부모데이터를 삭제할때 해당데이터를 사용하는 자식데이터를 같이 삭제하겠다.
    -ON DELETE RESTRICTED : 삭제제한 -> 기본옵션.
*/
-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2) REFERENCES MEM_GRADE ON DELETE SET NULL , --컬럼레벨방식
    GENDER CHAR(3) CHECK(GENDER IN ('남','여')) NOT NULL,-- CHECK제약조건으로 남 , 여 들어갈수있고, NOT NULL 제약조건을 가짐.
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL -- 디폴트값으로 현재시간을 저장하고 NOTNULL 제약조건을 가짐
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) -- 테이블레벨방식
);

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (1 , 'user01' , 'pass01', '홍길동','남','G1');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (2 , 'user02' , 'pass02', '홍길동','남','G2');

INSERT INTO MEM(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GENDER, GRADE_ID )
VALUES (3 , 'user03' , 'pass03', '홍길동','남','G3');

SELECT * FROM MEM;

-- 부모테이블에서 GRADE_CODE 'G1'인 행을 삭제.
DELETE FROM MEM_GRADE
WHERE GRADE_CODE ='G1';
-- 자식테이블의 GRADE_ID가 G1인 부분이 모두 NULL로 바뀜.

-- ON DELETE CASCADE 
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GRADE_ID CHAR(2), -- 컬럼레벨 반식
    GENDER CHAR(3) CHECK (GENDER IN ('남' , '여')) NOT NULL, -- CHECK제약조건으로 남 , 여 들어갈수있고 , NOT NULL 제약조건을 가짐.
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE NOT NULL, -- 디폴트값으로 현재시간을 저장하고 NOT NULL 제약조건을 가짐
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- 테이블레벨방식
); 

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (1 , 'user01' , 'pass01' , '홍길동' , '남' , 'G1');

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (2 , 'user02' , 'pass02' , '홍길동' , '남' , 'G2');

INSERT INTO MEM(MEM_NO , MEM_ID , MEM_PWD , MEM_NAME , GENDER , GRADE_ID)
VALUES (3 , 'user03' , 'pass03' , '홍길동' , '남' , 'G3');




SELECT * FROM MEM;

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';
-- 자식테이블의 GRADE_ID가 G3인 행들이 모두 삭제됨.

--조인문제
-- 전체 회원의 회원번호, 아이디, 비밀번호, 이름, 등급명 조회
-- 오라클 전용구문
SELECT
    MEM_NO,
    MEM_ID,
    MEM_PWD,
    MEM_NAME,
    grade_name
FROM MEM, MEM_GRADE
WHERE MEM.GRADE_ID = MEM_GRADE.GRADE_CODE(+);
-- ANSI 전용 구문
SELECT
    MEM_NO,
    MEM_ID,
    MEM_PWD,
    MEM_NAME,
    grade_name
FROM MEM
LEFT JOIN MEM_GRADE ON GRADE_ID = GRADE_CODE;
/*
    굳이 외래키 제약조건이 걸려 있지 않더라도 JOIN가능함.
    다만, 두 컬럼에 동일한 의미의 데이터가 담겨있어야함.(자료형이 같고, 담김간의 종류, 의미도 비슷해야함)
*/
--------------------------------------------------------------------------------------------

--사용자계정_kh로 변경
/*
        SUBQUERY를 이용한 테이블 생성(테이블 복사의 개념)
        
        메인 SQL문(SELECT, CREATE, INSERT, UPDATE....)을 보조하는 역할의 쿼리문이 섭브쿼리였음.
        
        [표현법]
        CREATE TABLE 테이블명
        AS 서브쿼리;
*/

--EMPLOYEE 테이블의 복제테이블생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
-- 컬럼들, 자료형, NOT NULL 제약조건을 제대로 복사됨.
--PRIMARY KEY 제약조건은 제대로 복사가 안됨.
--> 서브쿼리를 통해 테이블을 생성할 경우 제약조건의 경우 NOT NULL 제약조건만 복사된다.
SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE 테이블에서 데이터는 필요없고, 컬럼 구조만 복사하고 싶을때.

SELECT * FROM EMPLOYEE
WHERE 1 = 0; -- 1 0 FALSE를 의미함.
--WHERE 1=1; 1=1은 TRUE를 의미함.

CREATE TABLE EMPLOYEE_COPY2
AS SELECT * FROM EMPLOYEE WHERE 1=0;

-- 전체 사원들중 급여가 300만원 이상인 사원들의 사번, 이름, 부서코드, 급여 컬럼 복제(내용물도 같이)
--EMPLOYEE_COPY3
--1) 조회
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

-- 2. 전체 사원의 사번, 사원명, 급여 연봉 조회한 결과를 복제한 테이블 생성 (내용물도 같이)
-- 테이블명 : EMPLOYEE_COPY4
CREATE TABLE EMPLOYEE_COPY4
AS SELECT 
    emp_id, 
    emp_name, 
    salary, 
    (salary*12) AS "annual_income" 
FROM EMPLOYEE;
-- 서브쿼리의 SELECT절에 산술연산 또는 함수식 이 기술된 경우 반드시 별칭을 붙여주자.
