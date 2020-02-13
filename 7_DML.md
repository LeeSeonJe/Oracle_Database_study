# DML
+
  + 데이터 조작 언어로 테이블에 값을 **삽입**(**INSERT**), **수정**(**UPDATE**), **삭제**(**DELETE**)하는 구문을 말함
  
### INSERT
+ 
  + 테이블에 새로운 행을 추가하여 테이블의 행 개수를 증가시키는 구문
  >
  ```SQL
  INSERT INTO EMPLOYEE ( EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE, JOB_CODE, SAL_LEVEL, SALARY, BONUS, MANAGER_ID, HIRE_DATE, ENT_DATE, ENT_YN)
  VALUES(900,'장채현','901123-1080503' ,'JANG_CH@kh.or.kr', '01055569512', 'D1', 'J7', 'S3', 4300000,0.2, '200', SYSDATE, NULL, DEFAULT);
  -- 모든 컬럼에 대해 INSERT할 때 모든 컬럼을 다 기입하지 않고 생략할 수 있다.
  -- 대신 순서를 잘 지켜 값을 넣어야한다.
  INSERT INTO EMPLOYEE
  VALUES(900,'장채현','901123-1080503' ,'JANG_CH@kh.or.kr', '01055569512', 'D1', 'J7', 'S3', 4300000,0.2, '200', SYSDATE, NULL, DEFAULT);
  ```
  + 서브쿼리를 이용한 INSERT
  >
  ```SQL
  CREATE TABLE EMP_01(
      EMP_ID NUMBER,
      EMP_NAME VARCHAR2(30),
      DEPT_TITLE VARCHAR2(20)
  );

  INSERT INTO EMP_01(
      SELECT EMP_ID, EMP_NAME, DEPT_TITLE
      FROM EMPLOYEE 
          LETF JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE)
  );
  
  SELECT * FROM EMP_01;
  ```
  + INSERT INTO 테이블명 ( 서브쿼리 ); ==> 기존 INSERT문과 조금 다르다. VALUES가 빠지고 서브쿼리문이 들어간걸 볼 수 있다.
### INSERT ALL
+
  + INSERT시 서브쿼리가 사용하는 테이블 같은 경우, 두 개 이상의 테이블에 INSERT ALL을 이용하여 한 번에 삽입 가능
  + **단. 각 서브쿼리의 조건절이 같아야 함**
  + **INSERT ALL INTO** 테이블명 **VALUES** 컬럼명 **WHERE절이 같은 서브쿼리**
  >
  ```SQL
  -- INSERT ALL을 사용하기 위한 TABLE 생성
  CREATE TABLE EMP_DEPT_D1
  AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
      FROM EMPLOYEE
      WHERE 1 = 0;
  -- INSERT ALL을 사용하기 위한 TABLE 생성
  CREATE TABLE EMP_MANAGER
  AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
      FROM EMPLOYEE
      WHERE 1 = 0;
  
  -- 서브쿼리의 조건이 같은 INSERT ALL
  INSERT ALL 
  INTO EMP_DEPT_D1 VALUES (EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE )
  INTO EMP_MANAGER VALUES (EMP_ID, EMP_NAME, MANAGER_ID)
      SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, HIRE_DATE
      FROM EMPLOYEE
      WHERE DEPT_CODE = 'D1';
  ```
  + INSERT ALL 부분을 보게 되면 같은 조건의 서브쿼리를 통해서 데이터가 삽입된다. 
  + 서브쿼리의 컬럼이 위에 테이블의 컬럼에 존재하면 알아서 값이 들어간다.  
  + **서브쿼리의 조건이 다를 경우**
  + **INSERT ALL** { WHEN 조건문 THEN **INTO** 테이블명 **VALUES** [컬럼명] .... } **서브쿼리**
  >
  ```SQL
  CREATE TABLE EMP_OLD -- 2000년 1월 1일 이전에 입사
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
      FROM EMPLOYEE   
      WHERE 1 = 0;

  CREATE TABLE EMP_NEW -- 그 후 입사
  AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
      FROM EMPLOYEE
      WHERE 1 = 0;
      
  -- 조건절이 다른 INSERT ALL을 사용시 WHEN THEN 조건문을 이용해서 사용가능하다.
  INSERT ALL 
  WHEN HIRE_DATE < '2000/01/01' THEN
      INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
  ELSE
      INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY)
  SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
  FROM EMPLOYEE;
  ```
### UPDATE
+
  + 테이블에 기록된 **컬럼 값**을 수정하는 구문으로 테이블 전체 행 개수는 변화 없음
  + **UPDATE** 테이블명 **SET** 수정내용 [**WHERE**] 조건문
  + 조건문을 적어주지 않을 경우 모든 행의 값이 변경됨
  >
  ```SQL
  -- 서브쿼리르 통해 테이블을 복사해 오기
  CREATE TABLE DEPT_COPY
  AS SELECT * FROM DEPARTMENT;
 
  -- 
  UPDATE DEPT_COPY
  SET DEPT_TITLE = '전략기획팀'
  WHERE DEPT_ID = 'D9';
  ```
  + **서브쿼리 UPDATE**
  
### DELETE
+
  + 테이블의 행을 삭제하는 구문으로 테이블의 행 개수가 줄어듦
  
### TRUNCATE
+
  + 테이블 전체 행 삭제 시 사용하여 DELETE보다 수행 속도가 빠르나 ROLLBACK을 통해 복구 불가능
