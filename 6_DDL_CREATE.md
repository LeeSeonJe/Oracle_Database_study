# DDL_CREATE
### Data Dictionary 명령어
+ USER_TABLES : 사용자가 작성한 테이블을 확인하는 뷰
+ USER_TAB_COLUMNS : 테이블, 뷰의 컬럼들과 관련된 정보 조회
+ USER_CONSTRAINTS : 테이블에 적용되어 있는 제약조건 조회
+ DESC (TABLE NAME) : 테이블 구조 표시
+ 더 많은 DD 명령어가 있지만 배우면서 추가할 예정

### DDL
+
  + DDL (Data Definition Language)
  + 데이터 정의 언어로 **객체**(**OBJECT**)를 **만들고**(**CREATE**), **수정**하고(**ALTER**), **삭제**(**DROP**)하는 구문을 말함
  + 오라클 객체의 종류
    + 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE),  
  프로시저(PROCEDUAL), 함수(FUNCTION), 트리거(TRIGGER), 동의어(SYNONYM), 사용자(USER)


### CREATE
+
  + 테이블(TABLE)이나 인덱스(INDEX), 뷰(VIEW) 등 데이터베이스 객체를 생성하는 구문
  + 표현식
  >
  ```SQL
  CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        ....
  );
                       
  EX)
  CREATE TABLE MEMBER(
        MEMBER_ID VARCHAR2(20),
        MEMBER_PWD VARCHAR2(20),
        MEMBER_NAME VARCHAR2(20)
  );
  ```
  
### Oracle Data Type
+ 
  |데이터형|설명|
  |:-----:|:--:|
  |CHAR(크기)|고정길이 문자 데이터|
  |VARCHAR2(크기)|가변길이 문자 데이터 (최대 4,000Byte)|
  |NUMBER|숫자 데이터 (최대 40자리)|
  |NUMBER(길이)|숫자 데이터로, 길이 지정 가능 (최대 38자리)|
  |DATE|날짜 데이터 (BC 4712년 1월 1일 ~ AD 4712년 12월 31일)|
  |LONG|가변 길이 문자형 데이터 (최대 2GB)|
  |LOB|2GB까지의 가변길이 바이너리 데이터 저장 가능 (이미지, 실행파일 등 저장 가능)|
  |ROWID|DB에 저장되지 않는 행을 식별할 수 있는 고유 값|
  |BFILE|대용량의 바이너리 데이터 저장가능 (최대 4GB)|
  |TIMESTAMP|DATE형의 확장된 형태|
  |INTERVAL YEAR TO MONTH|년과 월을 이용하여 기간 저장|
  |INTERVAL DAY TO SEOCND|일, 시, 분, 초를 이용하여 기간 저장|

+ VARCHAR2 선언에 대한 검색 결과
  + 가변길이로써 데이터를 저장할 때 남는 공백없이 저장하게 해주어 메모리 낭비를 하지않는다.
  + 또한 VARCHAR2의 선언방법이 2가지 방법이 있다.
    + 1\. VARCHAR2(20 BYTE) == VARCHAR2(20)
    + 2\. VARCHAR2(20 CHAR)
  + **이렇게 2가지로 선언이 가능하다.  
  1번의 같은 경우는 20 BYTE의 크기의 공간을 만들어 주는 것이며  
  2번의 같은 경우는 20자 즉, 20글자를 넣을 수 있는 공간이 만들어진다.  
  검색 결과 NON-ENGLISH, 한글과 같은 경우  
  1BYTE의 공간을 차지하는 것이 아니라 2BYTE의 공간을 차지하기 때문에  
  1번과 같이 선언하면 20글자가 들어가는 것이 아니라 10글자 내로 들어가게 될 것이다.  
  2번과 같이 선언하면 BYTE와 상관없이 20글자가 들어가게 되어 좀 더 폭 넓게 사용할 수 있을 것 같다.**
### TABLE COLUMN COMMENT
+
  + 테이블의 컬럼에 주석을 다는 구문
  >
  ```SQL
  COMMENT ON COLUMN 테이블명.컬럼명 IS 'COMMENT 내용';
  
  EX)
  COMMENT ON COLUMN MEMBER.MEMBER_ID IS ‘회원아이디’;
  COMMENT ON COLUMN MEMBER.MEMBER_PWD IS ‘비밀번호’;
  COMMENT ON COLUMN MEMBER.MEMBER_NAME IS ‘회원이름’;
  ```
  
### CONSTRAINTS
+ 
  + 테이블 작성 시 **각 컬럼**에 기록될 데이터에 대해 **제약 조건**을 설정할 수 있다.
  + 이는 데이터 무결성 보장을 주 목적으로 한다.
    + 무결성 ?  
    ==> **데이터베이스에 저장된 데이터 값과 그것이 표현하는 현실 세계의 실제값이 일치하는 정확성을 의미한다.**
    + 데이터 무결성 ?  
    ==> **데이터의 정확성, 일관성, 유효성이 유지되는 것**  
    ==> **데이터 입력, 수정, 삭제에 대해 문제가 없는지 자동 검사**
  + 입력 데이터에 문제가 없는지에 대한 검사와 데이터 수정/삭제 가능 여부 검사 등을 위해 사용한다.  
  
    |제약 조건|설명|
    |:------:|:---:|
    |NOT NULL|데이터에 NULL을 허용하지 않음|
    |UNIQUE|중복된 값을 허용하지 않음|
    |PRIMARY KEY|NULL과 중복 값을 허용하지 않음 (**컬럼의 고유식별자**로 사용하기 위해)|
    |FOREIGN KEY|참조되는 테이블의 컬럼의 값이 존재하면 허용|
    |CHECK|저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만 허용|  
>
+ 제약조건 기술방법
  >
  ```SQL
  CREATE TABLE USER_UNIQUE2(
      USER_NO NUMBER,
      USER_ID VARCHAR2(20) NOT NULL, <-- 컬럼레벨
      USER_PWD VARCHAR2(30) NOT NULL, <-- 컬럼레벨
      USER_NAME VARCHAR2(30),
      GENDER VARCHAR2(10),
      PHONE VARCHAR2(30),
      EMAIL VARCHAR2(50),
      UNIQUE(USER_ID) <-- 테이블 레벨
  );
  ```
  >
+ 제약조건 이름설정
  + 컬럼레벨 : {컬럼명} {자료형} CONSTRAINT {제약조건명} {제약조건}
  + 테이블레벨 : CONSTRAINT {제약조건명} {제약조건(테이블명)}
  >
  ```SQL
  CREATE TABLE CONS_NAME (
      TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL, <--컬럼레벨
      TEST_DATA2 VARCHAR2(20) CONSTRAINT UK_TEST_DATA1 NOT NULL, <--컬럼레벨
      TEST_DATA3 VARCHAR2(30),
      CONSTRAINT UK_TEST_DATA3 UNIQUE(TEST_DATA3) <-- 테이블레벨
  );
  ```
+ 컬럼레벨
  + 컬럼을 정의할때 바로 뒤에 제약조건을 선언하는 것으로 **NOT NULL**은 무조건 컬럼레벨에 선언해야한다.
+ 테이블레벨
  + 모든 컬럼 정의 후 맨아래에 제약조건을 선언하는 것으로 **NOT NULL**을 제외한 나머지는 되도록이면 테이블레벨에 작성한다.
  + **복합키**를 사용할 때는 컬럼레벨 형식으로 만들 수 없으며 테이블레벨에 작성해야 **가독성**이 더 좋다.
  + EX) UNIQUE(USER_NO, USER_ID)는 쌍을 이루므로 두 가지 조건중 하나만 다르면 행에 삽입이 가능하다.
  >
  ```SQL
  CREATE TABLE USER_UNIQUE3(
      USER_NO NUMBER,
      USER_ID VARCHAR2(20),
      USER_PWD VARCHAR2(30) NOT NULL,
      USER_NAME VARCHAR2(30),
      GENDER VARCHAR2(10),
      PHONE VARCHAR2(30),
      EMAIL VARCHAR2(50),
      UNIQUE(USER_NO, USER_ID) <-- 쌍으로 이루어진 제약조건이다.
  );
  INSERT INTO USER_UNIQUE3 VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr'); 
  -- 행 삽입 가능 ==> 아무것도 없으므로..
  INSERT INTO USER_UNIQUE3 VALUES(2, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr'); 
  -- 행 삽입 가능 ==> 위에 행 user01과 중복되지만 2가 중복되지 않아 삽입가능
  INSERT INTO USER_UNIQUE3 VALUES(1, 'user02', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 행 삽입 가능 ==> 맨 위에 행 1과 중복되지만 user02가 중복되지 않아 삽입가능
  INSERT INTO USER_UNIQUE3 VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 행 삽입 불가 ==> 맨위와 NO와 ID가 같아 삽입 불가
  ```
> NOT NULL / UNIQUE / PRIMARY KEY / FOREIGN KEY / CHECK
+ ##### NOT NULL
  + 데이터의 NULL을 허용하지 않는다.
  >
  ```SQL
  CREATE TABLE USER_UNIQUE3(
        USER_NO NUMBER,
        USER_ID VARCHAR2(20),
        USER_PWD VARCHAR2(30) NOT NULL,
        USER_NAME VARCHAR2(30),
        GENDER VARCHAR2(10),
        PHONE VARCHAR2(30),
        EMAIL VARCHAR2(50),
        UNIQUE(USER_NO, USER_ID)
    );
    
    INSERT INTO USER_UNIQUE3 VALUES(1, 'user01', NULL, '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
    -- 오류 보고 - ORA-01400: cannot insert NULL into ("KH"."USER_UNIQUE3"."USER_PWD")
    -- PWD는 NOT NULL이기 때문에 NULL 값이 들어가게 되면 나오는 에러이다.
  ```
+ ##### UNIQUE
  + 중복 값을 허용하지 않는다.
  >
  ```SQL
  CREATE TABLE USER_UNIQUE2(
      USER_NO NUMBER,
      USER_ID VARCHAR2(20),
      USER_PWD VARCHAR2(30),
      USER_NAME VARCHAR2(30),
      GENDER VARCHAR2(10),
      PHONE VARCHAR2(30),
      EMAIL VARCHAR2(50),
      UNIQUE(USER_ID)
  );

  INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 행 삽입 가능 ==> 아무 것도 없으므로...
  INSERT INTO USER_UNIQUE2 VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 오류 보고 - ORA-00001: unique constraint (KH.SYS_C007253) violated
  -- 행 삽입 불가 ==> UNIQUE 제약조건을 위반하였다고 에러가 난다. USER_ID가 존재하는데 또 삽입하려고 하기 때문에 나는 에러
  ```
+ ##### PRIMARY KEY
  + NOT NULL + UNIQUE
  + 한 행을 구분할 수 있는 고유 식별자 역할
  + 한 테이블 당 하나만 설정 가능, 컬럼레벨 / 테이블레벨 둘다 생성 가능
  + 한 개 컬럼에 설정할 수 있고 여러 개 컬럼을 묶어서 설정(복합키) 할 수 있음
  >
  ```SQL
  CREATE TABLE USER_PRIMARYKEY(
      USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
      USER_ID VARCHAR2(20) UNIQUE,
      USER_PWD VARCHAR2(30) NOT NULL,
      USER_NAME VARCHAR2(30),
      GENDER VARCHAR2(10),
      PHONE VARCHAR2(30),
      EMAIL VARCHAR2(50)
  );
  INSERT INTO USER_PRIMARYKEY VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 행 삽입 가능 ==> 아무 것도 없으므로...
  INSERT INTO USER_PRIMARYKEY VALUES(1, 'user02', 'pass02', '이순신', '남', '010-2222-3333','lee123@kh.or.kr');
  -- 오류 보고 - ORA-00001: unique constraint (KH.PK_USER_NO) violated 
  -- 행 삽입 불가 ==> 이미 NO에 1이 있으므로 PRIMARY KEY의 UNIQUE 제약조건을 위반함.
  INSERT INTO USER_PRIMARYKEY VALUES(NULL, 'user02', 'pass02', '이순신', '남', '010-2222-3333','lee123@kh.or.kr');
  -- 오류 보고 - ORA-01400: cannot insert NULL into ("KH"."USER_PRIMARYKEY"."USER_NO")
  -- 행 삽입 불가 ==> PRIMARY KEY의 NOT NULL 제약조건을 위반함.
  ```
+ ##### FOREIGN KEY
  + 참조 무결성을 위한 제약조건으로 참조된 다른 테이블이 제공한 값만 사용하도록 제한을 거는 것
  + 참조할 테이블의 참조할 컬럼 명을 **생략할 경우 PRIMARY KEY로 설정된 컬럼**이 자동으로 참조할 컬럼이 됨
  + 참조된 다른 테이블이 제공하는 값만 사용할 수 있음
  + 제공 되는 값 외에는 NULL 사용 가능
  >
  ```SQL
  -- 참조할 테이블
  CREATE TABLE USER_GRADE(
      GRADE_CODE NUMBER PRIMARY KEY,
      GRADE_NAME VARCHAR2(30) NOT NULL
  );

  INSERT INTO USER_GRADE VALUES(10, '일반회원');
  INSERT INTO USER_GRADE VALUES(20, '우수회원');
  INSERT INTO USER_GRADE VALUES(30, '특별회원');

  CREATE TABLE USER_FOREIGNKEY(
      USER_NO NUMBER PRIMARY KEY,
      USER_ID VARCHAR2(20) UNIQUE,
      USER_PWD VARCHAR2(30) NOT NULL,
      USER_NAME VARCHAR2(30),
      GENDER VARCHAR2(10),
      PHONE VARCHAR2(30),
      EMAIL VARCHAR2(50),
      GRADE_CODE NUMBER,
      CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE) <-- 
  );

  INSERT INTO USER_FOREIGNKEY VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr',10);
  -- 행 삽입 가능 ==> 아무 것도 없으므로... AND 참조하는 테이블에서 참조할 행이 있으므로 삽입 가능
  INSERT INTO USER_FOREIGNKEY VALUES(2, 'user02', 'pass02', '이순신', '남', '010-2222-3333','lee123@kh.or.kr',10);
  -- 행 삽입 가능 ==> 제약조건을 모두 허용하며 참조하는 테이블에서 참조할 행이 있으므로 삽입 가능
  INSERT INTO USER_FOREIGNKEY VALUES(3, 'user03', 'pass03', '유관순', '남', '010-3333-4444','yoo123@kh.or.kr',30);
  -- 행 삽입 가능 ==> 제약조건을 모두 허용하며 참조하는 테이블에서 참조할 행이 있으므로 삽입 가능
  INSERT INTO USER_FOREIGNKEY VALUES(4, 'user04', 'pass04', '안중근', '남', '010-4444-5555','ahn123@kh.or.kr',null);
  -- 행 삽입 가능 ==> 제약조건을 모두 허용하며 참조하는 테이블에서 제공 되는 값 외에는 NULL 사용 가능하므로 삽입 가능
  INSERT INTO USER_FOREIGNKEY VALUES(5, 'user05', 'pass05', '윤봉길', '남', '010-5555-6666','ahn123@kh.or.kr',50
  -- 오류 보고 - ORA-02291: integrity constraint (KH.FK_GRADE_CODE) violated - parent key not found
  -- 오류 내용 : 참조하는 테이블에서 부모키를 찾을 수 없다고 한다.
  -- 행 삽입 불가 ==> 제약조건은 모두 허용했지만 참조하는 테이블에 50이라는 값이 존재 하지 않으므로 삽입 불가, 없는 값은 NULL만 가능하다!!
  ```
+ ##### CHECK
  + 컬럼에 기록되는 값에 조건 설정 (변하는 값, 함수 사용 불가능)
  + 성별 또는 숫자 범위등에 사용한다.
  >
  ```SQL
  -- CHECK 제약조건 (성별)
  CREATE TABLE USER_CHECK(
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
  );

  INSERT INTO USER_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222','hong123@kh.or.kr');
  -- 행 삽입 가능 ==> 제약조건을 모두 허용하므로.. 
  INSERT INTO USER_CHECK VALUES(2, 'user02', 'pass02', '홍길동', '남자', '010-1111-2222','hong123@kh.or.kr');
  -- 오류 보고 - ORA-02290: check constraint (KH.SYS_C007212) violated
  -- 오류 내용 : CHECK 제약조건 위반 
  -- 행 삽입 불가 ==> '남'으로 지정하였기 때문에 '남자'는 제약조건에 위반된다.
  
  -- CHECK 제약조건(숫자 범위)
  CREATE TABLE USER_CHECK2(
      TEST_NUMBER NUMBER,
      CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
  );


  INSERT INTO USER_CHECK2 VALUES(10);
  -- 행 삽입 가능 ==> CHECK 제약조건에 허용되어 삽입 가능
  INSERT INTO USER_CHECK2 VALUES(-1);
  -- 오류 보고 - ORA-02290: check constraint (KH.CK_TEST_NUMBER) violated
  -- 오류 내용 : CHECK 제약조건 위반 
  -- 행 삽입 불가 ==> 지정한 범위인 0보다 커야하는데 -1은 0보다 작으므로 제약조건 위반
  ```
  
+ **CREATE와 제약조건... 많은 양을 한번에 해서 정리하기가 쉽지 않았다.  
  가급적으로 에러 내용에 관해서만 기술 하였으며 에러가 발생하였을 때 당황하지 말고 천천히 풀어보자.  
  제약조건을 잘 생각하면서 천천히 CREATE TABLE을 하면 잘 만들 수 있을 것 같다.**
