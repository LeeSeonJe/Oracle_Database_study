# 2020/02/03

## 트렌젝션 : 데이터베이스의 상태를 변경해주는 것 !!외우자!!
>
### 주요용어
+ 행, 튜플
  + 테이블에는 기본적으로 **기본키**의 역할을 하는 컬럼이 필요하다. 
  + 각 행(튜플)을 구분할 수 있는 **구분자**이다. OR **고유값**
  + 무조건 테이블에는 한 개이상의 **기본키**가 존재해야한다.
+ 컬럼, 도메인
+ 외래키(Foreign Key)
  + 한 테이블의 기본키, 일반컬럼이 다른 테이블의 컬럼 안으로 들어가면 그 컬럼은 **외래키**가 된다.
>
### SQL
+ DQL(Data Query Language) - 데이터 검색
  + SELECT
>
+ DML(Date Manipulation Language) - 데이터 조작
  + INSERT : 삽입
  + UPDATE : 수정
  + DELETE : 삭제
>  
+ DDL(Date Definition Language) - 데이터 정의
  + CREATE : 생성
  + DROP : 삭제
  + ALTER : 수정
>
+ TCL(Transaction Control Language) - 트랜잭션 제어
  + COMMIT : 데이터베이스의 상태 변경을 확정지어준다.
  + ROLLBACK : 마지막 커밋 지점으로 되돌린다.
>
### DQL - SELECT
+ 데이터를 조회한 결과를 Result Set이라고 하는데 SELECT구문에 의해 반환된 행들의 집합을 의미함
+ Result Set은 0개 이상의 행이 포함될 수 있고 특정 기준에 의해 정렬 가능
+ 한(여러) 테이블의 특정 컬럼, 행, 행/컬럼 조회 가능


  + 작성법
  ```sql
    SELECT 컬럼명[,컬럼명, ...]  // 조회하고자 하는 컬럼명 기술
    FROM 테이블명 // 조회 대상 컬럼이 포함된 테이블명
    WHERE 조건식; // 행을 선택하는 조건 기술
  ```
    + SELECT 예시
    ```sql
      -- 직원 전부의 모든 정보를 조회하는 구문
      SELECT * FROM EMPLOYEE
      
      -- 컬럼 값에 대해 산술 연산한 결과 조회 
      SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) * 12
      FROM EMPLOYEE;
      
      -- *(아스트로)는 혼자사용해야 한다.
      SELECT *, SALARY * 12 
      -- 2개의 * 가 들어갔다. 허용되지 않아 에러가 발생된다. 
      -- 전체를 뽑거나 곱하기를 하거나 둘 중 하나만 해야한다.
      FROM EMPLOYEE;
      
      -- 반올림, 올림, 내림, 버림 사용하기
      SELECT SYSDATE - HIRE_DATE 근무일수, ROUND(SYSDATE-HIRE_DATE) 반올림, CEIL(SYSDATE-HIRE_DATE) 올림,
              FLOOR(SYSDATE - HIRE_DATE) 내림, TRUNC(SYSDATE - HIRE_DATE) 버림
      FROM EMPLOYEE;      
      
      -- 컬럼 별징
      -- 컬럼명 AS 별칭
      -- 컬럼명 "별칭" // 별칭에 띄어쓰기, 특수문자, 숫자가 포함될 경우 무조건 ""으로 묶는다.
      -- 컬럼명 AS "별칭" 
      -- 컬럼명 별칭
      
      -- EMPLOYEE테이블에서 직원의 직원명(별칭 : 이름), 연봉(별칭 : 연봉(원)), 보너스를 추가한 연봉(별칭 : 총소득(원)) 조회
      SELECT EMP_NAME 이름, SALARY * 12 "연봉(원)", (SALARY * (1+BONUS))*12 AS "총소득(원)"
      FROM EMPLOYEE;

      -- EMPLOYEE테이블에서 이름, 고용일, 근무일수(오늘날짜 - 고용일) 조회
      SELECT EMP_NAME AS "이름", HIRE_DATE AS "고용일", SYSDATE-HIRE_DATE "근무일수"
      FROM EMPLOYEE;
    ```
+
  + 컬럼명 "별칭" // 별칭에 띄어쓰기, 특수문자, 숫자가 포함될 경우 무조건 ""으로 묶는다.
  + 가급적 ""(더블 커텐션)으로 묶도록 연습하자.!
