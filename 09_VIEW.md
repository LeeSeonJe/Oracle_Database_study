#  VIEW
+
  + SELECT 쿼리의 실행 결과를 화면에 저장한 **논리적 가상테이블**
  + 실제 데이터를 저장하고 있지 않지만 테이블 사용하는 것과 동일하게 사용 가능
### CREATE VIEW
  + 표현식  
  ***CREATE [OR REPLACE] VIEW*** 뷰이름 ***AS*** 서브쿼리
    + OR REPLACE : 뷰 생성 시 같은 이름의 뷰가 있다면 기본 뷰에 덮어씀
    + OR REPLACE를 사용하지 않고 뷰를 생성 후 같은 이름의 뷰를 생성 시 이미 존재한다는 오류 발생
  + VIEW 또한 권한을 받아야 생성이 가능하다.
  + **GRANT CREATE VIEW TO 사용자명;**
  >
  ```SQL
  GRANT CREATE VIEW TO KH;
  
  -- 사번, 이름, 부서 명, 근무 지역을 조회하고 그 결과를 V_EMPLOYEE라는 뷰를 생성하여 저장
  CREATE OR REPLACE VIEW V_EMPLOYEE
  AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_NAME
      FROM EMPLOYEE
          LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
          LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
          LEFT JOIN NATIONAL USING(NATIONAL_CODE);
  ```
### VIEW DML
> VIEW INSERT / UPDATE / DELETE
+ 생성된 뷰에 요청한 DML구문이 **베이스 테이블**도 변경함 (주의할 것)
  > 
  ```SQL
  -- 생성된 뷰를 이용해 DML문 사용 가능
  CREATE OR REPLACE VIEW V_JOB
  AS SELECT JOB_CODE, JOB_NAME
      FROM JOB;

  -- 뷰에 INSERT 사용
  INSERT INTO V_JOB
  VALUES ('J8', '인턴');

  SELECT * FROM V_JOB;
  SELECT * FROM JOB;
  -- 뷰에서 요청한 DML구문은 베이스 테이블도 변경됨

  -- 뷰에 UPDATE 사용
  UPDATE V_JOB
  SET JOB_NAME = '알바'
  WHERE JOB_CODE = 'J8';

  -- 뷰에 DELETE 사용
  DELETE FROM V_JOB
  WHERE JOB_CODE = 'J8';
  ```
+ DML로 VIEW 조작이 불가능한 경우
  + **1\. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우**
  >
  ```SQL
  CREATE OR REPLACE VIEW V_JOB2
  AS SELECT JOB_CODE
      FROM JOB;

  SELECT * FROM V_JOB2;

  INSERT INTO V_JOB2 VALUES('J8', '인턴');
  -- SQL 오류: ORA-00913: too many values
  
  UPDATE V_JOB2
  SET JOB_NAME = '인턴'
  WHERE JOB_CODE = 'J7';
  -- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier
  
  DELETE FROM V_JOB2
  WHERE JOB_NAME = '사원';
  -- SQL 오류: ORA-00904: "JOB_NAME": invalid identifier
  ```
  + **2\. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우**
  >
  ```SQL
  -- JOB_NAME만 가진 V_JOB3 뷰 생성
  CREATE OR REPLACE VIEW V_JOB3
  AS SELECT JOB_NAME
  FROM JOB;

  INSERT INTO V_JOB3 VALUES('인턴');
  -- cannot insert NULL into ("KH"."JOB"."JOB_CODE")
  -- JOB_CODE에 제약조건이 NOT NULL이므로 인턴을 추가 하였을시 불가능
  -- INSERT에서만 오류가 발생한다.

  INSERT INTO JOB VALUES('J8','인턴');
  SELECT * FROM V_JOB3;

  UPDATE V_JOB3
  SET JOB_NAME = '알바'
  WHERE JOB_NAME = '인턴';

  SELECT * FROM V_JOB3;
  SELECT * FROM JOB;

  DELETE FROM V_JOB3
  WHERE JOB_NAME = '알바';

  SELECT * FROM V_JOB3;
  SELECT * FROM JOB;

  COMMIT;
  ```
  + VIEW 자체는 JOB_NAME 컬럼으로만 생성이 되었는데 INSERT시에 베이스 테이블에 추가가 되기 때문에 JOB_CODE가 NULL이 되므로 오류발생
  + DELETE는 그 값을 찾아 삭제하는 것이므로 사용가능하다.
  >
  + **3\. 산술 표현식으로 정의된 경우**
  >
  ```SQL
  -- 사번, 사원 명, 급여, 보너스가 포함된 연봉으로 이루어진 EMP_SAL 뷰 생성
  CREATE OR REPLACE VIEW EMP_SAL
  AS SELECT EMP_ID, EMP_NAME, SALARY,
            (SALARY + (SALARY*NVL(BONUS,0)))*12 "연봉"
     FROM EMPLOYEE;

  INSERT INTO EMP_SAL VALUES(800, '정신훈', 3000000,36000000);
  -- SQL 오류: ORA-01733: virtual column not allowed here

  UPDATE EMP_SAL
  SET 연봉 = 80000000
  WHERE EMP_ID = 200;
  -- SQL 오류: ORA-01733: virtual column not allowed here

  COMMIT;

  DELETE FROM EMP_SAL
  WHERE 연봉 = 124800000;
  ```
  + DELETE는 그 값을 찾아 삭제하는 것이므로 사용가능하다.
  >
  + **4\. 그룹함수나 GROUP BY절을 포함한 경우**
  >
  ```SQL
  -- 부서코드, 부서 코드 별 급여, 합계, 부서코드 별 급여 평균을 가지고 있는 V_GROUPDEPT 뷰 생성
  CREATE OR REPLACE VIEW V_GROUPDEPT
  AS SELECT DEPT_CODE, SUM(SALARY) 합계, AVG(SALARY) 평균
     FROM EMPLOYEE
     GROUP BY DEPT_CODE;

  SELECT * FROM V_GROUPDEPT;
  INSERT INTO V_GROUPDEPT
  VALUES('D10', 6000000,4000000);
  -- "virtual column not allowed here"

  UPDATE V_GROUPDEPT
  SET DEPT_CODE = 'D10'
  WHERE DEPT_CODE = 'D1';
  -- "data manipulation operation not legal on this view"

  DELETE FROM V_GROUPDEPT
  WHERE DEPT_CODE = 'D1';
  -- "data manipulation operation not legal on this view"
  ```
  + 모든 DML 사용불가
  >
  + **5\. DISTINCT를 포함한 경우**
  >
  ```SQL
  CREATE OR REPLACE VIEW V_DT_EMP
  AS SELECT DISTINCT JOB_CODE
     FROM EMPLOYEE;

  SELECT * FROM V_DT_EMP;

  INSERT INTO V_DT_EMP VALUES ('J9');
  -- "data manipulation operation not legal on this view"

  UPDATE V_DT_EMP
  SET JOB_CODE = 'J9'
  WHERE JOB_CODE = 'J7';
  -- "data manipulation operation not legal on this view"

  DELETE FROM V_DT_EMP
  WHERE JOB_CODE = 'J1';
  -- "data manipulation operation not legal on this view"
  ```
  + 모든 DML 사용불가
  >
  + **6\. JOIN을 이용해 여러 테이블을 연결한 경우**
  >
  ```SQL
  -- 사번, 사원 명, 부서 명 정보를 가지고 있는 V_JOINEMP 뷰 생성
  CREATE OR REPLACE VIEW V_JOINEMP
  AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
      FROM EMPLOYEE
          JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

  SELECT * FROM V_JOINEMP;

  INSERT INTO V_JOINEMP VALUES (888,'조세오', '인사관리부');
  -- "cannot modify more than one base table through a join view"

  UPDATE V_JOINEMP
  SET DEPT_TITLE = '인사관리부'
  WHERE EMP_ID = 219;
  -- "cannot modify a column which maps to a non key-preserved table"

  COMMIT;

  DELETE FROM V_JOINEMP
  WHERE EMP_ID = 219;
  ```
  
### VIEW OPTION
> OR REPLACE, FORCE / NOFORCE, WITH CHECK OPTION. WITH READ ONLY
+ 
  + **OR REPLACE** : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
  >
  ```SQL
  CREATE OR REPLACE VIEW V_EMP1
  AS SELECT EMP_NO, EMP_NAME
      FROM EMPLOYEE;

  CREATE OR REPLACE VIEW V_EMP1
  AS SELECT EMP_NO, EMP_NAME, SALARY
      FROM EMPLOYEE;


  CREATE VIEW V_EMP1
  AS SELECT EMP_NO, EMP_NAME
      FROM EMPLOYEE;
  -- name is already used by an existing object
  -- OR REPLACE 옵션이 없으므로 덮어쓰지 못하고 존재하는 테이블이라는 에러를 발생
  ```
+ **FORCE / NOFORCE**
  + **FORCE** : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
  >
  ```SQL
  CREATE OR REPLACE FORCE VIEW V_EMP2
  AS SELECT TCODE, TNAME, TCONTENT
      FROM TT;
  -- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
  ```
  + **NOFORCE** : 서브쿼리에 사용된 테이블이 존재해야함 뷰 생성 (DEFAULT)
  >
  ```SQL
  CREATE OR REPLACE VIEW V_EMP2
  AS SELECT TCODE, TNAME, TCONTENT
      FROM TT;
  -- table or view does not exist
  ```
  + NOFORE 옵션을 주지 않아도 기본값이므로 존재하지 않는 테이블 에러를 발생하며 생성되지 않는다.
+
  + **WITH CHECK OPTION** : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
  >
  ```SQL
  CREATE OR REPLACE VIEW V_EMP3
  AS SELECT *
      FROM EMPLOYEE
      WHERE DEPT_CODE = 'D9' 
      WITH CHECK OPTION;

  SELECT * FROM V_EMP3;

  UPDATE V_EMP3
  SET DEPT_CODE = 'D8'
  WHERE EMP_ID = 200;
  -- ORA-01402: view WITH CHECK OPTION where-clause violation
  -- WHERE절에 대한 값을 변경시 WITH CHECK OPTION에 위배된다.
  ```
  + INSERT시에는 WHERE절의 조건에 해당해야 삽입 가능하다.
  
+
  + **WITH READ ONLY** : 뷰에 대해 조회만 가능, DML 사용 불가능
  >
  ```SQL
  CREATE OR REPLACE VIEW V_DEPT
  AS SELECT * FROM DEPARTMENT
  WITH READ ONLY;

  SELECT * FROM V_DEPT;

  DELETE FROM V_DEPT;
  -- "cannot perform a DML operation on a read-only view"
  ```
  
  
