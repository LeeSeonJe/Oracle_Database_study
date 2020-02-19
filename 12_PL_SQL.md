# PL/SQL
+ Procedural Language extension to SQL
  + 오라클 자체에 내장되어 있는 절차적 언어
  + SQL의 단점을 보완하여 SQL문장 내에서 변수의 정의, 조건 처리, 반복 처리등 지원
  >
  |구조|설명|
  |:-----:|:-----:|
  |DECLARE SECTION <BR> (선언부)|**DECLARE**로 시작 <BR> 변수나 상수를 선언하는 부분|
  |EXECUTABLE SECTION <BR> (실행부)|**BEGIN**으로 시작 <BR> 제어문, 반복문, 함수 정의등 로직 기술|
  |EXCEPTION SECTION <BR> (예외처리부)|**EXCEOTION**으로 시작 <BR> 예외사항 발생 시 해결하기 위한 문장 기술
  
  + PL/SQL 구조  
  &nbsp;&nbsp; 선언부 : **DECLARE**로 시작  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 변수, 상수 선언  
  &nbsp;&nbsp; 실행부 : **BEGIN**으로 시작  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 로직 기술  
  &nbsp;&nbsp; 예외처리부 : **EXCEPTION**  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 예외 상황 발생 시 해결하기 위한 문장 기술 
  <BR>

  > 예시
  ```SQL
  SET SERVEROUTPUT ON;
  * 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는 환경변수로
  기본 값은 OFF여서 ON으로 변경
  ```
  + 환경설정을 해주고 실행시 출력문이 보이게 된다.
  ```SQL
  
  BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
  END;
  /
  * PUT_LINE이라는 프로시저를 이용하여 출력(DBMS_OTUPUT패키지에 속해있음)
  ```

### 타입 변수 선언
  > #### 변수의 선언 및 포기화, 변수 값 출력
  ```SQL
  DECLARE
  -- 변수명  자료형
    EMP_ID NUMBER;               ==> JAVA : int emp_id;
    EMP_NAME VARCHAR2 (30);      ==> JAVA : String emp_name;
    PI CONSTANT NUMBER := 3.14;  ==> JAVA : final double PI = 3.14;
  BEGIN
    EMP_ID := 888;        ==> 값 초기화
    EMP_NAME := '배장남';  ==> 값 초기화
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);    ==> JAVA에서의 System.out.println(); 역할
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
  END;
  /
  ```
+  + JAVA와는 다르게 ORACLE에서는 대입연산자를 ***:=*** 로 정의하고 있으므로 주의하자.
  > #### 레퍼런스 변수의 선언과 초기화, 변수 값 출력
  ```SQL
  DECLARE
    EMP_ID EMPLOYEE.EMP_ID%TYPE;  -- 변수 EMP_ID의 타입을 EMPLOYEE테이블의 EMP_ID컬럼 타입으로 지정
    EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
  BEGIN
    SELECT EMP_ID, EMP_NAME   -- 컬럼이름
    INTO EMP_ID, EMP_NAME     -- 변수이름
    FROM EMPLOYEE
    WHERE EMP_ID = '&EMP_ID';
    
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
  END;
  /
  
  -- 레퍼런스 변수로 EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY를 선언하고
  -- EMPLOYEE 테이블에서 사번, 이름, 직급코드, 부서코드, 급여를 조회하고
  -- 선언한 레퍼런스 변수에 담아 출력하시오.
  -- 단, 입력받은 이름과 일치하는 조건의 직원을 조회하세요.

  DECLARE 
      EMP_ID EMPLOYEE.EMP_ID%TYPE;
      EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
      DEPT_CODE EMPLOYEE.DEPT_CODE%TYPE;
      JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
      SALARY EMPLOYEE.SALARY%TYPE;
  BEGIN 
      SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
      INTO EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
      FROM EMPLOYEE
      WHERE EMP_NAME = '&이름';

      DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || EMP_ID);
      DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || EMP_NAME);
      DBMS_OUTPUT.PUT_LINE('DEPT_CODE : ' || DEPT_CODE);
      DBMS_OUTPUT.PUT_LINE('JOB_CODE : ' || JOB_CODE);
      DBMS_OUTPUT.PUT_LINE('SALARY : ' || SALARY);
  END;
  /
  ```
+ 
  + ORACLE에서 테이블의 있는 값을 가져오기 위해서 테이블의 해당하는 자료형을 가져오기 위해 **\%TYPE**을 사용한다.
    + 표현법 --> **변수명 테이블명.컬럼명%TYPE\;**
  + 값을 받아오기 위한 **\&(암퍼센트\)** 사용
    + 표현법 --> **\'&문구'\;**
  
  > #### 한 행에 대한 ROWTYPE변수 선언과 초기화, 값 출력
  ```SQL
  DECLARE
    E EMPLOYEE%ROWTYPE;
    -- %ROWTYPE 테이블 또는 뷰의 컬럼 데이터 형, 크기, 속성 참조
  BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = '&사번';
    
    -- 사번, 이름, 주민번호, 급여
    DBMS_OUTPUT.PUT_LINE('EMP_ID : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('EMP_NAME : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('EMP_NO : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('SALARY : ' || E.SALARY);
  END;
  /
  ```
+ 
  + 테이블이나 뷰에 대한 컬럼의 정보를 가져와 변수를 설정하기 위해서는 **\%ROWTYPE**을 사용한다.
    + 표현식 --> **변수명 테이블명%ROWTYPE\;**
