# JOIN

### JOIN/INNER JOIN
+ 하나 이상의 테이블에서 데이터를 조회하기 위해 사용하고 수행 결과는 **하나의 RESULT SET**으로 나옴
+ 기본적으로 JOIN은 INNER JOIN이며 두 개 이상의 테이블을 조인할 때 **일치하는 값이 없는 행**은 조인에서 **제외**됨
+ ORCLE 구문
  + FROM절에 ','로 구분하여 합치게 될 테이블 명을 기술하고 WHERE절에 합치기에 사용할 컬럼 명 명시
    >
  ```SQL
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE = DEPT_ID;
  ```
  **\* 연결에 사용할 두 컬럼 명이 다른 경우 그 자체로 사용 가능**  
  **\* 연결에 사용할 두 컬럼 명이 같은 경우 테이블명.컬럼명 / FROM절의 테이블에 별칭 이용 가능**
    >
  ```SQL
  -- 사번, 사원명, 부서 코드, 부서명 조회
  
  -- 테이블명.컬럼명 사용
  SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
  FROM EMPLOYEE, JOB
  WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;

  -- 테이블 별칭 사용
  SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
  FROM EMPLOYEE E, JOB J
  WHERE E.JOB_CODE = J.JOB_CODE;
  ```
  
  + ANSI 구문
    + 연결에 사용하려는 컬럼 명이 같은 경우 USING() 사용, 다른 경우 ON() 사용
  >
  ```SQL
  -- 사번, 사원명, 부서 코드, 부서명 조회
  
  -- USING() 사용
  SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
  FROM EMPLOYEE
       JOIN JOB USING(JOB_CODE);

  -- ON() 사용
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
  FROM EMPLOYEE
       JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
  ```
  
### OUTER JOIN
+ 두 개 이상의 테이블을 조인할 때 **일치하는 값이 없는 행도 조인**에 **포함**됨 **(!반드시 OUTER JOIN명시)**
+ #### LEFT/RIGHT/FULL
  + ANSI구문에서만 사용
  + **LEFT** : 합치기에 사용한 두 테이블 중 **왼쪽**에 기술된 테이블의 **컬럼 수**를 기준으로 JOIN
  >
  ```SQL
  -- LEFT
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
       LEFT OUTER JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
  ```
  + **RIGHT** : 합치기에 사용한 두 테이블 중 **오른쪽**에 기술된 테이블의 **컬럼 수**를 기준으로 JOIN
  >
  ```SQL
  -- RIGHT
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
       RIGHT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
  ```
  + **FULL** : 합치기에 사용한 두 테이블이 가진 **모든 행**을 결과에 포함
  >
  ```SQL
  -- FULL
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
       FULL JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
  ```
  + **ORACLE에서의 OUTER JOIN 사용
  >
  ```SQL
  -- '내가 너한테 맞춰줄게 ~' 라고 말하는 쪽에 (+)를 붙임
  -- LEFT
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE E, DEPARTMENT D
  WHERE E.DEPT_CODE = D.DEPT_ID(+); 
  
  -- RIGHT
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE , DEPARTMENT 
  WHERE DEPT_CODE(+) = DEPT_ID;
  
  -- FULL ==> ORACLE은 FULL OUTER JOIN을 제공하지 않는다.
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE, DEPARTMENT
  WHERE DEPT_CODE(+) = DEPT_ID(+);
  ```
  + **FULL OUTER JOIN은 제공하지 않는 점을 유의하자!!**
### CROSS JOIN 
+ 카테시안 곱(Cartesian Product)라고도 하며 조인되는 테이블의 **각 행들이 모두 매핑**된 데이터가 검색되어 조인 방법
+ 검색되는 데이터 수는 '행의 컬럼 수 * 또 다른 행의 컬럼 수'
  >
  ```SQL
  -- 카테시안 곱(Cartesian Product)
  SELECT EMP_NAME, DEPT_TITLE
  FROM EMPLOYEE
       CROSS JOIN DEPARTMENT;
  ```
### NON_EQU JOIN
+ '='(등호)를 사용하지 않는 조인문
+ 지정한 컬럼 값이 일치하는 경우가 아닌 값의 범위에 포함되는 행들을 연결하는 방식
+ 범위는 BETWEEN A AND B 를 사용한다.
  >
  ```SQL
  SELECT EMP_NAME, SALARY, E.SAL_LEVEL
  FROM EMPLOYEE E
       JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
  ```
### SELF JOIN
+ 두 개 이상의 서로 다른 테이블을 연결하는 것이 아닌 **같은 테이블을 조인**하는 것
+ 헷갈린 부분이 있다. 하나의 테이블을 2개를 열어 놓고 보면 이해하기 쉽다.
  >
  ```SQL
  -- SELF JOIN
  SELECT E.EMP_ID, E.EMP_NAME "사원이름", E.DEPT_CODE, E.MANAGER_ID, M.EMP_NAME "관리자이름"
  FROM EMPLOYEE E, EMPLOYEE M
  WHERE E.MANAGER_ID = M.EMP_ID;
  ```
### 다중 JOIN
+ 하나 이상의 테이블에서 데이터를 조회하기 위해 사용하고 수행 결과는 **하나의 RESULT SET**으로 나옴
  >
  ```SQL
  -- 사번, 사원 명, 부서 코드, 부서 명, 지역 명(LOCAL_NAME) 조회
  
  -- 오라클
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
  FROM EMPLOYEE, DEPARTMENT, LOCATION
  WHERE DEPT_CODE = DEPT_ID 
        AND LOCATION_ID = LOCAL_CODE;

  -- ANSI 
  SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCAL_NAME
  FROM EMPLOYEE
       JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
       JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
  
  
  
  -- 직급이 대리이면서 아시아 지역에 근무하는 직원조회
  -- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요.

  -- 오라클
  SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME, SALARY
  FROM EMPLOYEE E, LOCATION L, JOB J, DEPARTMENT D
  WHERE E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%';

  -- ANSI
  SELECT E.EMP_ID, E.EMP_NAME, D.DEPT_TITLE, L.LOCAL_NAME 
  FROM EMPLOYEE E
       JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
       JOIN DEPARTMENT D ON ( D.DEPT_ID = E.DEPT_CODE)
       JOIN LOCATION L ON (L.LOCAL_CODE = D.LOCATION_ID)
  WHERE J.JOB_NAME = '대리' AND L.LOCAL_NAME LIKE 'ASIA%';
  ```
  
#### 천천히 하나하나 읽으면서 JOIN해주기!!
