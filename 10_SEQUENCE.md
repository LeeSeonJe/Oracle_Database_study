# SEQUENCE
+ 
  + 순차적으로 정수 값을 자동으로 생성하는 객체로 **자동 번호 발생기** 역할을 함
  + 표현식  
  CREATE SEQUENCE 시퀀스명  
  1\. [**START WITH** 숫자] --> 처음 발생시킬 시작 값, DEFAULT 1  
  2\. [**INCREMENT BY** 숫자] --> 다음 값에 대한 증가치, DEFAULT 1  
  3\. [**MAXVALUE** 숫자 | **NOMAXVALUE**] --> 발생시킬 최대값, 10의 27승-1 까지 가능  
  4\. [**MINVALUE** 숫자 | **NOMINVALUE**] --> 발생시킬 최소값, -10의 26승  
  5\. [**CYCLE** | **NOCYCLE**] --> 시퀀스가 최대값까지 증가 완료 시 CYCLE은 START WITH 설정 값으로 돌아감 / NOCYCLE은 에러 발생  
  6\. [**CACHE** | **NOCACHE**] --> CACHE는 메모리 상에서 시퀀스 값 관리, DEFAULT 20
  + SEQUENCE 사용
    + 시퀀스명.CURRVAL : 현재 생성된 시퀀스의 값
    + 시퀀스명.NEXTVAL : 시퀀스를 증가시키거나 최초로 시퀀스 실행
  >
  ```SQL
  CREATE SEQUENCE SEQ_EMPID
  START WITH 300 -- 처음 시작값 300
  INCREMENT BY 5 -- 증가량 5
  MAXVALUE 310   -- 최대값 310
  NOCYCLE
  NOCACHE; 
  DROP SEQUENCE SEQ_EMPID;

  SELECT * FROM USER_SEQUENCES;
  
  SELECT SEQ_EMPID.CURRVAL FROM DUAL;
  -- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
  -- 먼저 NEXTVAL을 사용하여 최초로 시퀀스를 실행해야한다.

  SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
  SELECT SEQ_EMPID.CURRVAL FROM DUAL;

  SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
  SELECT SEQ_EMPID.CURRVAL FROM DUAL;

  SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
  SELECT SEQ_EMPID.CURRVAL FROM DUAL;

  SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
  -- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
  SELECT SEQ_EMPID.CURRVAL FROM DUAL;
  ```
+ NEXTVAL / CURRVAL 사용 가능 여부  

|사용가능|사용불가|
|:-----:|:-----:|
|서브쿼리가 아닌 SELECT문|VIEW의 SELECT절|
|INSERT문의 SELECT절|DISTINCT 키워드가 있는 SELECT문|
|INSERT문의 VALUE절|GROUP BY, HAVING, ORDER BY절이 있는 SELECT문|
|UPDATE문의 SET절|SELECT, DELETE, UPDATE의 서브쿼리|
||CREATE TABLE, ALTER TABLE 명령의 DEFAULT값|

+
  + 시퀀스 수정 시 CREATE에 사용한 옵션을 변경 가능
  + 단 START WITH 값 변경은 불가하기 때문에 변경하려면 삭제 후 다시 생성
