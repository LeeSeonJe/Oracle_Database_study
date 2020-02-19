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
  &nbsp;&nbsp; 예외처리부 : EXCEPTION  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 예외 상황 발생 시 해결하기 위한 문장 기술 
  <BR>

  > 예시
  ```SQL
  SET SERVEROUTPUT ON;
  * 프로시저를 사용하여 출력하는 내용을 화면에 보여주도록 설정하는 환경변수로
  기본 값은 OFF여서 ON으로 변경
  BEGIN
  DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
  END;
  /
  * PUT_LINE이라는 프로시저를 이용하여 출력(DBMS_OTUPUT패키지에 속해있음)
  ```
    
