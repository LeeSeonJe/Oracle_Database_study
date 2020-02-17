# DDL_ALTER
+
  + 테이블에 정의된 내용을 수정할 때 사용하는 데이터 정의어
  + 컬럼의 추가/삭제, 제약조건의 추가/삭제, 컬럼의 자료형 변경, DEFAULT 값 변경, 테이블명/컬럼명/제약조건명 변경
  
### ALTER
+ **컬럼 추가**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***ADD*** 컬럼명 자료형 [***DEFAULT*** 기본값] [제약조건];
  >
  ```SQL
  ALTER TABLE DEPT_COPY
  ADD (CNAME VARCHAR2(20));
  -- VARCHAR2(20)인 CNAME 컬럼 추가
  
  ALTER TABLE DEPT_COPY
  ADD (LNAME VARCHAR2(40) DEFAULT '한국' NOT NULL);
  -- DEFAULT 값이 '한국'이고 NOT NULL인 LNAME 컬럼 추가
  ```
  >
+ **제약조건 추가**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***ADD CONSTRAINT*** 제약조건명 제약조건(컬럼명);
  >
  ```SQL
  ALTER TABLE DEPT_COPY
  ADD CONSTRAINT DCOPY_DID_PK PRIMARY KEY(DEPT_ID);
  ADD CONSTRAINT DCOPY_DTITLE_UNQ UNIQUE(DEPT_TITLE);
  MODIFY LNAME CONSTRAINT DCOPY_LNAME_NN NOT NULL;
  ```
  + NOT NULL은 MODIFY를 통해서 추가할 수 있다.
  >
+ **컬럼 수정**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  **MODIFY** (컬럼명 [바꿀자료형] [***DEFAULT*** 기본값] [***CONSTRAINT*** 제약조건명 제약조건]);
  >
  ```SQL
  ALTER TABLE DEPT_COPY
  MODIFY DEPT_ID CHAR(3)
  MODIFY DEPT_TITLE VARCHAR2(30) NOT NULL
  MODIFY LOCATION_ID VARCHAR2(2)
  MODIFY CNAME CHAR(20) CONSTRAINT UK_CNAME UNIQUE
  MODIFY LNAME DEFAULT '미국' NOT NULL;
  ```
  + **MODEFY시 주의사항!!**
    + 해당 컬럼의 크기를 줄일 수 있다. 하지만 기존에 있던 데이터의 최대 크기보다는 줄일 수 없다.
    + 행에 NULL 값만 가지고 있으면 자료형을 변경할 수 있다.
    + 행의 DEFAULT 값을 변경하면 기존에 있던 기본값을 가진 행은 그대로 있으며 수정 후 발생하는 행에만 영향을 미친다.
    + 행에 NULL 값을 가지고 있지 않을 경우 NOT NULL 제약조건을 추가할 수 있다.
  >
+ **컬럼 삭제**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***DROP COLUMN*** 컬럼명 [***CASCADE CONSTRAINTS***];
  >
  ```SQL
  -- 제약조건이 있는 테이블 생성
  CREATE TABLE TB1(
      PK1 NUMBER PRIMARY KEY,
      COL1 NUMBER,
      CHECK(PK1 >0 AND COL1>0)
  );

  CREATE TABLE TB2(
      PK2 NUMBER PRIMARY KEY,
      FK2 NUMBER REFERENCES TB1 ON DELETE SET NULL,
      COL2 NUMBER,
      CHECK(PK2 >0 AND COL2>0)
  );
  
  ALTER TABLE TB1
  DROP COLUMN PK1 CASCADE CONSTRAINTS;

  ALTER TABLE TB2
  DROP COLUMN PK2 CASCADE CONSTRAINTS;
  ```
  + 참조(child)테이블은 컬럼 삭제가 DROP으로 되지만 부모(parent)테이블은 CASCADE CONSTRAINTS을 통해서 컬럼을 삭제해야한다.
  >
+ **제약조건 삭제** 
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***DROP CONSTRAINT*** 재약조건명;
  >
  ```SQL
  ALTER TABLE DEPT_COPY
  DROP CONSTRAINT DCOPY_DID_PK
  DROP CONSTRAINT DCOPY_DTITLE_UNQ
  MODIFY LNAME NULL;
  ```
  + NOT NULL은 MODIFY를 통해서 NULL로 바꾸게 되면 NULL 값을 넣을 수 있다.
  >
+ **컬럼이름 변경**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***RENAME*** 현재컬럼명 ***TO*** 수정할 컬럼명;
  >
  ```SQL 
  ALTER TABLE DEPT_COPY
  RENAME COLUMN DEPT_TITLE TO DEPT_NAME;
  ```
+ **제약조건이름 변경**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***RENAME*** 현재 제약조건명 ***TO*** 수정할 제약조건명;
  >
  ```SQL
  ALTER TABLE USER_FOREIGNKEY
  RENAME CONSTRAINT SYS_C007211 TO UF_UP_NN;
  ALTER TABLE USER_FOREIGNKEY
  RENAME CONSTRAINT SYS_C007212 TO UF_UN_PK;
  ALTER TABLE USER_FOREIGNKEY
  RENAME CONSTRAINT SYS_C007213 TO UF_UI_UQ;
  ALTER TABLE USER_FOREIGNKEY
  RENAME CONSTRAINT SYS_C007214 TO UF_GC_FK;
  ```
+ **테이블이름 변경**
  + 표현식  
  ***ALTER TABLE*** 테이블명  
  ***RENAME TO*** 수정할 제약조건명;
  >
  ```SQL
  ALTER TABLE DEPT_COPY
  RENAME TO DEPT_TEST;
  ```
# DDL_DROP
+
  + 데이터베이스 객체를 삭제하는 구문
  + TABLE, VIEW, SEQUENCE, SYNONYM 등 객체 삭제
  
### DROP
+ **테이블 삭제**
  + 표현식  
  ***DROP TABLE*** 테이블명 [***CASCADE CONSTRAINT***];
  >
  ```SQL
  DROP TABLE DEPT_TEST CASCADE CONSTRAINT;
  ```
  + 제약조건이 걸려있을 경우 CASCADE CONSTRAINT를 사용하여 테이블 삭제.
