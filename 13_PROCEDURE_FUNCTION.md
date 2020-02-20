# PROCEDURE & FUNCTION
+
  + PL/SQL문을 저장하는 객체
  + 필요할 때 마다 복잡한 구문을 다시 입력할 필요 없이 간단하게 호출해서 실행 결과를 얻을 수 있음 
  <BR>
  
  > 얘시
  ```SQL
  -- 호출시 EMP_DUP테이블에 있는 모든 데이터를 삭제하는 DEL_ALL_EMP프로시저 생성
  CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
  IS 
  BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
  END;
  /
  -- 프로시저 생성
  
  EXECUTE DEL_ALL_EMP;
  -- 프로시저 실행
  -- EXECUTE를 EXEC로 줄여서 사용가능
  
  -- 입력 받은 사원번호의 정보를 삭제하는 DEL_EMP_ID프로시저
  CREATE OR REPLACE PROCEDURE DEL_EMP_ID(
      V_EMP_ID EMPLOYEE.EMP_ID%TYPE
  )
  IS 
  BEGIN
      DELETE FROM EMPLOYEE
      WHERE EMP_ID = V_EMP_ID;
  END;
  /
  
  EXEC DEL_EMP_ID('&EMP_ID');
  -- 매개변수로 EMP_ID를 입력 받아와서 실행
  ```
  <BR>
  
  > IN / OUT
+
  + IN 매개변수 : 프로시저 내부에서 사용 될 변수
  + OUT 매개변수 : 프로시저 외부(호출부)에서 사용된 변수
  + BIND
  ```SQL
  -- 사용자가 입력한 사번으로 사원의 이름, 급여, 보너스 조회하는 SELECT_EMP_ID프로시저
  CREATE OR REPLACE PROCEDURE SELECT_EMP_ID (
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE;
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE;
    V_SALARY OUT EMPLOYEE.SALARY%TYPE;
    V_BONUS OUT EMPLOYEE.BONUS%TYPE;
  )
  IS
  BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0);
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
  END;
  /
  
  -- 바인드 변수(VARIABLE OR VAR)
  -- SQL문을 실행할 때 SQL에 사용 값을 전달할 수 있는 통로 역할
  VAR VAR_EMP_NAME VARCHAR2(30);
  VAR VAR_SALARY NUMBER;
  VAR VAR_BONUS NUMBER;

  PRINT VAR_EMP_NAME;
  PRINT VAR_SALARY;
  PRINT VAR_BONUS;

  EXEC SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);

  ```
  
