# TRIGGER
+ 테이블이나 뷰에 INSERT, UPDATE, DELETE문이 발생할 경우 자동적으로 실행될 내용 저장한 객체
+ 트리거 종류
  + SQL문의 실행 시기에 따른 분류
    + BEFORE TRIGGER : SQL문 실행 전 트리거 실행
    + AFTER TRIGGER : SQL문 실행 후 트리거 실행
  + SQL문에 의해 영향을 받은 각 ROW에 따른 분류
    + POW TRIGGER  
    &nbsp;&nbsp;&nbsp;&nbsp;SQL문 각 ROW에 대해 한 번씩 실행 (FOR EACH ROW 옵션 작성)
    + STATEMENT TRIGGER  
    &nbsp;&nbsp;&nbsp;&nbsp;SQL문에 대해 한 번만 실행(DEFAULT)  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;EX. UPDATE EMPLOYEE SET SALARY = 0;  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;여러 행에 대해 자료가 변경되자만 해당 SQL에 대해 한 번만 트리거 실행
+ 표현식  
CREATE OR RPLACE TRIGGER 트리거명  
BEFORE | AFTER  
INSERT | UPDATE | DELETE  
ON 테이블명  
[FOR EACH ROW] -- ROW TRIGGER 옵션  
[WHEN 조건]  
DECLARE  
&nbsp;&nbsp;&nbsp; 선언부  
BEGIN  
&nbsp;&nbsp;&nbsp; 실행부  
[EXCEPTION  
&nbsp;&nbsp;&nbsp; 예외처리부]  
END;  
/
>
  ```SQL
  -- EMPLOYEE테이블에 사원이 추가되면 ' 신입사원이 입사했습니다' 라는 문구가 출력되는 TRG_01 트리거 생성
  CREATE OR REPLACE TRIGGER TRG_01
  AFTER INSERT ON EMPLOYEE
  BEGIN
      DBMS_OUTPUT.PUT_LINE('신입사원이 입사 했습니다.');
  END;
  /

  INSERT INTO EMPLOYEE VALUES(905, '박신우', '010101-2111111', 'SINWOO@kh.or.kr', '01711111111', 'D5','J3','S5', 3000000, 0.1,200,SYSDATE, NULL, DEFAULT);
  COMMIT;

  -- 상품 정보가 있는 PRODUCT테이블 생성
  CREATE TABLE PRODUCT(
      PCODE NUMBER PRIMARY KEY,
      PNAME VARCHAR2(30),
      BRAND VARCHAR2(30),
      PRICE NUMBER,
      STOCK NUMBER DEFAULT 0
  );

  -- 상품 입출고 상세 이력 정보가 있는 PRO_DETAIL테이블 생성
  CREATE TABLE PRO_DETAIL(
      DCODE NUMBER PRIMARY KEY, -- 상세코드
      PCODE NUMBER,
      PDATE DATE,
      AMOUNT NUMBER,
      STATUS VARCHAR2(10) CHECK(STATUS IN ('입고', '출고')),
      FOREIGN KEY(PCODE) REFERENCES PRODUCT
  );

  CREATE SEQUENCE SEQ_PCODE;
  CREATE SEQUENCE SEQ_DCODE;

  INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '갤럭시노트8', '삼성', 800000, DEFAULT);
  INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, '아이폰8', '애플', 1000000, DEFAULT);
  INSERT INTO PRODUCT VALUES(SEQ_PCODE.NEXTVAL, 'V30', 'LG', 500000, DEFAULT);

  SELECT * FROM PRODUCT;
  SELECT * FROM PRO_DETAIL;

  -- 상품 입출고 테이블에 입고나 출고가 들어갈 때마다 PRODUCT에 있는 STOCK이 바뀌어야함
  -- PRO_DETAIL 테이블에 INSERT 후에 STATUS컬럼 값에 따른 PRODUCT테이블 변경

  CREATE OR REPLACE TRIGGER TRG_02
  AFTER INSERT ON PRO_DETAIL
  FOR EACH ROW
  BEGIN
      IF (:NEW.STATUS = '입고') -- PRO_DETAIL에 STATUS 컬럼 값으로 새로 들어간 값이 '입고'명
      THEN
          UPDATE PRODUCT
          SET STOCK = STOCK + :NEW.AMOUNT
          WHERE PCODE = :NEW.PCODE;
      END IF;
      IF (:NEW.STATUS = '출고')
      THEN 
          UPDATE PRODUCT
          SET STOCK = STOCK - :NEW.AMOUNT
          WHERE PCODE = :NEW.PCODE;
      END IF;
  END;
  /

  SELECT * FROM PRODUCT;
  SELECT * FROM PRO_DETAIL;

  INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '입고');
  INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 10, '입고');
  INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 30, '입고');
  INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 50, '출고');
  ```
