# GROUPBY & HAVING
### SELECT문 실행순서!!
+ 
  + 실행 순서  
  
      |순서|쿼리문|
      |:---:|:-----:|
      |5|SELECT|
      |1|FROM|
      |2|WHERE|
      |3|GROUP BY|
      |4|HAVING|
      |6|ORDER BY|

### ORDER BY
+ 
  + SELECT한 컬럼에 대해 정렬을 할 때 작성하는 구문
  + SELECT 구문의 가장 마지막에 작성하며 실행 순서 역시 가장 마지막에 수행됨
    + 표현식
      + SELECT 컬럼명, [,컬럼명, .....]  
      FROM 테이블명  
      WHERE 조건식  
      ORDER BY 컬럼명 | 별칭 | 컬럼 순번 정렬방식[NULLS FIRST | LAST];
      + \* 정렬 방식  
      \- ASC : 오름차순  
      \- DESC : 내림차순
  >
  ```SQL
  SELECT EMP_ID, JOB_CODE, EMP_NAME, SALARY "급여", DEPT_CODE
  FROM EMPLOYEE
  --ORDER BY EMP_NAME; -- DAFAULT 오름차순
  --ORDER BY EMP_NAME ASC; -- 오름차순
  --ORDER BY EMP_NAME DESC; -- 내림차순
  --ORDER BY DEPT_CODE NULLS FIRST; -- NULL을 먼저 뽑고 나머지를 정렬해서 출력
  --ORDER BY 2; -- 숫자로 쓸 경우 위에 행의 위치로 정렬되기 때문에 
                -- 중간에 추가하면 계속해서 바꿔줘야하게 때문에 되도록 사용말자!!
  ORDER BY 급여;
  ```
  >
### GROUP BY
+
  + 여러 개의 결과 값을 산출하기 위해 그룹 함수가 적용될 그룹의 기준을 GROUP BY절에 기술하여 사용
  >
  ```SQL
  SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE;
  -- ERROR ==> DEPT_CODE의 결과는 여러행, SUM(SALARY)의 결과는 단일행

  SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY DEPT_CODE;

  -- EMPLOYEE테이블에서 부서코드와 보너스를 받는 사원수를 조회하고 부서코드 순으로 정렬
  SELECT DEPT_CODE, COUNT(BONUS)
  FROM EMPLOYEE
  GROUP BY DEPT_CODE
  ORDER BY DEPT_CODE;

  -- EMPLOYEE테이블에서 부서 코드 별 그룹을 지정하여 부서코드, 그룹 별 급여의 합계, 그룹 별 급여의 평균,
  -- 인원수를 조회하고 부서코드 순으로 정렬
  SELECT DEPT_CODE, SUM(NVL(SALARY,0)) "급여 합계", FLOOR(AVG(NVL(SALARY,0))) "급여 평균", COUNT(*) "부서 인원"
  FROM EMPLOYEE
  GROUP BY DEPT_CODE
  ORDER BY DEPT_CODE;

  -- EMPLOYEE테이블에서 직급코드, 보너스를 받는 사원수를 조회하여 직급코드 순으로 오름차순 정렬
  SELECT JOB_CODE, COUNT(BONUS)
  FROM EMPLOYEE
  WHERE BONUS IS NOT NULL -- COUNT(BONUS)가 0인 직급은 보고 싶지 않을 때
  GROUP BY JOB_CODE
  ORDER BY JOB_CODE;

  -- EMPLOYEE테이블에서 성별과 성별 별 급여 평균, 급여 합계, 인원 수 조회하고 인원 수로 내림차순 정렬
  SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') 성별,
         FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) "인원수"
  FROM EMPLOYEE
  GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여')
  ORDER BY 인원수 DESC;

  -- EMPLOYEE테이블에서 부서 코드별로 같은 직급인 사원의 급여 합계 조회
  SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY DEPT_CODE, JOB_CODE; -- 여러 컬럼 묶을 수 있음.
  ```
  
### HAVING
+
  + 그룹 함수로 값을 구해올 그룹에 대해 조건을 설정할 때 HAVING절에 기술
  + WHERE절은 SELECT에 대한 조건 / HAVING절은 GROUP BY에 대한 조건
  >
  ```SQL
  -- 부서코드와 급여 300만원 이상인 직원의 그룹별 평균(반올림) 급여 조회
  SELECT DEPT_CODE, ROUND(AVG(SALARY))
  FROM EMPLOYEE
  WHERE SALARY >= 3000000
  GROUP BY DEPT_CODE;

  -- 부서코드와 급여 평균(반올림)이 300만원 이상인 그룹 조회
  SELECT DEPT_CODE, ROUND(AVG(SALARY))
  FROM EMPLOYEE
  GROUP BY DEPT_CODE
  HAVING AVG(SALARY) >= 3000000;

  -- 부서 별 그룹의 급여 합계 중 900만원을 초화하는 부서 코드와 급여 합계(부서 코드 순으로 정렬)
  SELECT DEPT_CODE, SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY DEPT_CODE
  HAVING SUM(SALARY) > 9000000
  ORDER BY DEPT_CODE;
  ```
### ROLLUP & CUBE
+ 그룹 별 산출한 결과 값의 집계를 계산하는 함수
+ #### ROLLUP/CUBE
  + **ROLLUP** : 인자로 전달 받은 것 중에서 가장 먼저 지정한 인자에 대해 그룹별 중간 집계
  >
  ```SQL
  SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
  ORDER BY DEPT_CODE;
  ```

  + **CUBE** : 인자로 전달 받은 것 모두에 대해 그룹별 중간 집계
  >
  ```SQL
  SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
  FROM EMPLOYEE
  GROUP BY CUBE(DEPT_CODE, JOB_CODE)
  ORDER BY DEPT_CODE;
  ```
  
### 집합 연산자
+
  + 여러 개의 SELECT 결과물을 하나의 쿼리로 만드는 연산자
  + **SELECT문에 들어가는 컬럼이 동일해야한다.**

+ #### UNION/UNION ALL/INTERSECT/MINUS
  + **UNION** : 여러 개의 쿼리 결과를 합치는 연산자로 중복된 영역은 제외하여 합침 (합집합, OR)
  >
  ```SQL
  SELECT EMP_ID, EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_ID = 200
  UNION
  SELECT EMP_ID, EMP_NAME
  FROM EMPLOYEE
  WHERE EMP_ID = 201;
  
  -- UNION 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  UNION
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  
  -- OR 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000 OR DEPT_CODE = 'D5';
  ```
  + **UNION ALL** : 여러 쿼리 결과를 합치는 연산자로 중복된 영역 모두 포함하여 합침
  + 합집합(OR) + 교집합(AND) ==> 공통부분이 2번나옴
  >
  ```SQL
  -- DEPT_CODE가 D5이거나 급여가 300만원을 초과하는 직원의 사번, 이름, 부서코드, 급여 조회
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  UNION ALL
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  ```
  + **INTERSECT** : 여러 개의 SELECT 결과에서 공통된 부분만 결과로 추출(AND)
  >
  ```SQL
  -- INTERSECT 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  INTERSECT
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  
  -- AND 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000 AND DEPT_CODE = 'D5';
  ```
  + **MINUS** : 여러 쿼리 결과를 합치는 연산자로 중복된 영역 모두 포함하여 합침
  >
  ```SQL
  -- MINUS 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE DEPT_CODE = 'D5'
  MINUS
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY > 3000000;
  
  -- AND 사용 (조건식이 반대로 만들어진다.)
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
  FROM EMPLOYEE
  WHERE SALARY <= 3000000 AND DEPT_CODE = 'D5';
  ```
### GROUPING SETS
+
  + 그룹 별로 처리된 여러 개의 SELECT문을 하나로 합친 결과를 원할 때 사용 (집합 연산자 사용과 동일)
  >
  ```SQL
  -- 같은 부서코드, 직급코드, 관리자 사번의 평균 급여를 조회
  SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
  FROM EMPLOYEE
  GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

  SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
  FROM EMPLOYEE
  GROUP BY DEPT_CODE, MANAGER_ID;

  SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
  FROM EMPLOYEE
  GROUP BY JOB_CODE, MANAGER_ID;

  SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
  FROM EMPLOYEE
  GROUP BY GROUPING SETS(
          (DEPT_CODE,JOB_CODE, MANAGER_ID),
          (DEPT_CODE, MANAGER_ID),
          (JOB_CODE, MANAGER_ID))
  ORDER BY DEPT_CODE;
  ```
