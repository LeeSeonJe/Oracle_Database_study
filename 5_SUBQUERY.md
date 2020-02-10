# SUBQUERY

### SUBQUERY 
+ 
  + SELECT 문장 안에 포함된 또 다른 SELECT 문장으로 **메인쿼리가 실행되기 전 한 번만 실행**되며 반드시 괄호로 묶어야 함.
  + 서브쿼리와 비교할 항목은 반드시 서브쿼리의 SELECT한 항목의 **개수**와 **자료형**을 **일치**시켜야 함
  + 서브쿼리는 당연히! **WHERE절** 이나 **HAVING절**에만 사용가능하다.
  + 서브쿼리를 사용하는 이유
    + 사실 서브쿼리를 어느 때 사용하는지 아직 잘 파악하지 못하였다. 그래서 구글 검색을 해보았다....
      + **알려지지 않은 기준을 이용한 검색을 하기 위해서이다.**
    + **알려지지 않은 기준**이 잘 먼지 모르겠지만 정리하면서 생각해 보자..!!
    >
  ```SQL
  SUBQUERY 맛보기!!
  
  -- 전체 급여 평균보다 많이 받는 직원의 번호, 이름, 직책, 급여를 구하시오.
  SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY >= (SELECT AVG(SALARY)
                   FROM EMPLOYEE;
                   
  -- 부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
  -- 1) 노옹철 사원의 부서코드 조회
  SELECT DEPT_CODE
  FROM EMPLOYEE
  WHERE EMP_NAME = '노옹철';

  -- 2) 부서코드가 D9인 사원 조회
  SELECT EMP_NAME
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D9';

  -- 1) + 2)
  SELECT EMP_NAME
  FROM EMPLOYEE
  WHERE DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME = '노옹철');    
                      
  -- 1) 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
  SELECT AVG(SALARY)
  FROM EMPLOYEE;

  -- 2) 급여가 3047662.60869565217391304347826086956522원보다 많이 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
  SELECT EMP_ID, EMP_NAME, SALARY
  FROM EMPLOYEE
  WHERE SALARY>3047662.60869565217391304347826086956522;

  -- 1) + 2) : 전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
  SELECT EMP_ID, EMP_NAME, SALARY
  FROM EMPLOYEE
  WHERE SALARY > (SELECT AVG(SALARY)
                  FROM EMPLOYEE);                 
  ```
  + 단계적으로 풀이해보면 쉽게 이해할 수 있다.
  
### SUBQUERY 유형
+ 
  | 유형 | 내용 |
  |:---:|---|
  |1. 단일행|서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리|
  |2. 다중행|서브쿼리의 조회 결과 값의 개수가 여러 개인 서브쿼리|
  |3. 다중열|서브쿼리의 조회 결과 컬럼의 개수가 여러 개인 서브쿼리|
  |4. 다중행|서브쿼리의 조회 결과 컬럼의 개수와 행의 개수가 여러개인 서브쿼리|
  |5. 상(호연)관|서브쿼리가 만든 결과 값을 메인 쿼리가 비교 연산할 때 메인 쿼리 테이블의 값이 변경되면 서브쿼리의 결과 값도 바뀌는 서브쿼리|
  |6. 스칼라|상관쿼리이면서 결과 값이 한 개인 서브쿼리|
