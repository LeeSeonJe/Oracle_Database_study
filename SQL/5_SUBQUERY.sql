-- SUBQUERY
-- SELECT 문장 안에 포함된 또 다른 SELECT 문장
-- 메인 쿼리가 실행되기 전 한 번만 실행 되며 반드시 괄호로 묶어야함
-- 서브쿼리와 비교할 항목은 반드시 서브쿼리의 SELECT한 항목의 개수와 자료형을 일치시켜야 함

-- 메인쿼리(기존쿼리)를 위해 보조 역할을 하는 쿼리문

-- 서브쿼리 맛보기
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

SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE ='D9'
AND EMP_NAME = '노옹철';
                   
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
                
-- 서브쿼리 유형
-- 단일 행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리
-- 다중 행 서브쿼리 : 서브쿼리의 조회 결과 값의 행이 여러 개인 서브쿼리
-- 다중 열 서브쿼리 : 서브쿼리의 조회 결과 컬럼의 개수가 여러 개인 서브쿼리
-- 다중 행 다중 열 서브쿼리 : 서브쿼리의 조회 결과 컬럼의 개수와 행의 개수가 여러 개인 서브쿼리
-- 서브쿼리의 유형에 따라 서브쿼리 앞에 붙는 연산자가 달라짐

-- 1. 단일 행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 1개인 서브쿼리
-- 일반적으로 단일 행 서브쿼리 앞에는 일반 연산자 사용
-- <, >, <=, >=, =, !=, <>, ^=
-- '노옹철' 사원의 급여보다 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여 조회
-- 1) '노옹철' 사원의 급여
SELECT SALARY
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

-- 2) 3700000보다 급여를 많이 받는 직원의 사번, 이름, 부서코드, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY>3700000;

-- 1) + 2)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEE
                WHERE EMP_NAME = '노옹철');

-- 가장 작은 급여를 받는 직원의 사번, 이름, 직급코드, 부서코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE);

-- 전 직원의 급여 평균보다 적은 급여를 받는 직원의 이름, 직급코드, 부서코드, 급여조회(직급코드 순으로 정렬)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEE)
ORDER BY JOB_CODE;

-- 서브쿼리는 SELECT, WHERE, HAVING, FROM절에서도 사용 가능
-- 부서 별 급여 합계중 가장 큰 부서의 부서명, 급여 합계 조회
-- 1) 부서 별 급여 합계 중 가장 큰 값
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2} 급여 합계가 17700000인 부서 명, 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = 17700000;

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))
                      FROM EMPLOYEE
                      GROUP BY DEPT_CODE);
-- 2. 다중 행 서브쿼리 : 서브쿼리의 조회 결과 값의 행이 여러 개인 서브쿼리
-- 다중행 서브쿼리 앞에는 일반 비교 연산자 사용 불가
-- IN / NOT IN : 여러개의 결과 값 중에서 한 개라도 일치하는 값이 있다 / 없다 ==> 데이터 값을 반환
-- > ANY, < ANY : 여러개의 결과 값 중에서 한 개라도 큰 / 작은 값이 존재
--                가장 작은 값보다 큰지 / 가장 큰 값보다 작은지
-- > ALL, < ALL : 모든 값보다 큰 / 작은 값이 존재
--                가장 큰 값보다 큰지 / 가장 작은 값보다 작은지
-- EXISTS / NOT EXISTS : 값이 존재하는지 / 존재하지 않는지 ==> TRUE / FALSE 반환

-- 부서 별 최고 급여를 받는 직원의 이름, 직급코드, 부서코드 , 급여 조회
-- 1) 부서 별 최고 급여
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 서브 쿼리 적용
SELECT *
FROM EMPLOYEE
WHERE SALARY IN (SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;

-- 관리자와 일반 직원에 해당하는 사원 정보 추출 조회
-- 사번, 이름, 부서 명, 직급, 구분(관리자/직원)
-- 1) 관리자에 해당하는 사원 정보 조회
SELECT DISTINCT(MANAGER_ID), EMP_NAME
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

-- 2} 직원의 사번, 이름, 부서 명, 직급 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE);

-- 3) 관리자에 해당하는 직원에 대한 정보 추출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' "구분"
FROM EMPLOYEE 
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL);
                 
-- 4) 관리자에 해당하지 않는 직원에 대한 정보 호출
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' "구분"
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE
                     WHERE MANAGER_ID IS NOT NULL);

-- 5) 관리자 + 직원 합치기
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '관리자' "구분"
FROM EMPLOYEE 
     LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
     JOIN JOB USING (JOB_CODE)
WHERE EMP_ID IN (SELECT DISTINCT(MANAGER_ID)
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL)
                 
UNION

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, '직원' "구분"
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL);

-- SELECT 절에서도 서브쿼리 사용 가능
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME,
        CASE WHEN EMP_ID IN (SELECT DISTINCT (MANAGER_ID)
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '관리자'
            ELSE '직원'
        END "구분"
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING(JOB_CODE);

-- 대리 직급의 직원들 중에서 과장 직급의 최소 급여보다 많이 받는 직원의 사번, 이름, 직급, 급여 조회
-- 1) 대리 직급 직원의 사번, 이름, 직급, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리';

-- 2) 과장 직급 직원의 급여
SELECT SALARY
FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 3) 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리' 
AND SALARY > ANY (SELECT SALARY
                  FROM EMPLOYEE 
                       JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '과장');
                  
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
      AND SALARY > (SELECT MIN(SALARY)
                    FROM EMPLOYEE 
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '과장');
                    
-- 차장 직급의 급여의 가장 큰 값보다 많이 받는 과장 직급의 직원 조회
-- 사번, 이름, 직급, 급여 조회
-- 1) 과장 직급의 사번, 이름, 직급, 급여
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장';

-- 2) 차장 직급 직원의 급여
SELECT SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '차장';

-- 3) 1) + 2)
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
      AND SALARY > ALL (SELECT SALARY
                        FROM EMPLOYEE
                             JOIN JOB USING(JOB_CODE)
                        WHERE JOB_NAME = '차장');
                        
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
     JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
      AND SALARY > (SELECT MAX(SALARY)
                    FROM EMPLOYEE
                         JOIN JOB USING(JOB_CODE)
                    WHERE JOB_NAME = '차장');                

-- 3. 다중 열 서브쿼리 : 서브쿼리의 조회 결과 컬럼의 개수가 여러 개인 서브쿼리
-- 퇴사한 여직원과 같은 부서, 같은 직급에 해당하는 사원의 이름, 직급코드, 부서코드, 입사일 조회
-- 1) 퇴사한 여직원
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'Y'
      AND SUBSTR(EMP_NO, 8, 1)=2;
      
-- 2) 퇴사한 여직원과 같은 부서, 같은 직급
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE SUBSTR(EMP_NO,8,1) =2 AND ENT_YN = 'Y')
      AND JOB_CODE = (SELECT JOB_CODE
                      FROM EMPLOYEE
                      WHERE SUBSTR(EMP_NO, 8,1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO,8,1) = 2 AND ENT_YN = 'Y');
                       
-- 3) 다중열을 적용하여 해보기
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                                FROM EMPLOYEE
                                WHERE SUBSTR(EMP_NO,8,1) = 2 AND ENT_YN = 'Y')
      AND EMP_NAME != (SELECT EMP_NAME
                       FROM EMPLOYEE
                       WHERE SUBSTR(EMP_NO,8,1) = 2 AND ENT_YN = 'Y');
-- 4. 다중 행 다중 열 서브쿼리 : 서브쿼리의 조회 결과 컬럼의 개수와 행의 개수가 여러 개인 서브쿼리
-- 자기 직급의 평균 급여를 받고 있는 직원의 사번, 이름, 직급코드, 급여 조회
-- 단, 급여와 급여 평균은 민원 단위로 계산 == TRUNC(컬럼명, -5)

-- 1) 직급 별 평균 급여
SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 2) 자기 직급의 평균 급여를 받고 있는 직원
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE, SALARY) IN (SELECT JOB_CODE, TRUNC(AVG(SALARY), -5)
                             FROM EMPLOYEE
                             GROUP BY JOB_CODE);
                             
    


-- 인라인 뷰(INLINE-VIEW)
-- FROM절에서 서브쿼리를 사용하는 것
-- 서브쿼리가 만든 결과(RESULT SET)를 테이블 대신 사용

-- 전 직원 중 급여가 높은 상위 5명의 순위, 이름, 급여 조회
-- ROWNUM : 내가 가져온 순서를 가지고 번호를 부여하는 것.
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT *
      FROM EMPLOYEE
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 급여 평균 3위 안에 드는 부서의 부서 코드와 부서 명, 평균 급여 조회
SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY)
FROM EMPLOYEE
     JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY AVG(SALARY) DESC;

SELECT DEPT_CODE, DEPT_TITLE, 평균급여
FROM (SELECT DEPT_CODE, DEPT_TITLE, AVG(SALARY) "평균급여"
      FROM EMPLOYEE
           JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
GROUP BY DEPT_CODE, DEPT_TITLE
ORDER BY AVG(SALARY) DESC)
WHERE ROWNUM <=3;

-- WITH : 서브쿼리에 이름을 붙여주고 사용 시 이름으로 사용하게 함
-- 인라인 뷰로 사용될 서브쿼리에 주로 사용
-- 같은 서브쿼리가 여러번 사용될 경우 중북 작성 줄임, 실행속도도 빨라짐

SELECT ROWNUM, EMP_NAME, SALARY
FROM (SELECT EMP_NAME, SALARY
      FROM EMPLOYEE
      ORDER BY SALARY DESC);
      
WITH TOPN_SAL AS (SELECT EMP_NAME, SALARY
                FROM EMPLOYEE
                ORDER BY SALARY DESC)
SELECT ROWNUM, EMP_NAME, SALARY
FROM TOPN_SAL;

-- RANK() : OVER / DENSE_RANK() OVER
-- RANK() OVER : 동일한 순위 이후의 등수를 동일한 인원 수만큼 건너 뛰고 순위
SELECT RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;

-- DENSE_RANK() OVER : 중복되는 순위 이후의 등수를 바로 다음 등수로 처리
SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) 순위, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 부서별 급여 합계가 전체 급여 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
SELECT DEPT_TITLE, SUM(SALARY)
FROM DEPARTMENT D, EMPLOYEE E
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.2
                      FROM EMPLOYEE);

SELECT DEPT_TITLE, S
FROM (SELECT DEPT_TITLE, SUM(SALARY) S
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
    GROUP BY DEPT_TITLE)
WHERE S > (SELECT SUM(SALARY)*0.2
           FROM EMPLOYEE);
    
WITH TEST AS (SELECT DEPT_TITLE, SUM(SALARY) S
    FROM EMPLOYEE E, DEPARTMENT D
    WHERE E.DEPT_CODE = D.DEPT_ID
    GROUP BY DEPT_TITLE)
SELECT DEPT_TITLE, S
FROM TEST
WHERE S > (SELECT SUM(SALARY)*0.2
           FROM EMPLOYEE);
                   
                   
                   
SELECT DEPT_TITLE, SUM(SALARY)
FROM DEPARTMENT D, EMPLOYEE E
WHERE E.DEPT_CODE = D.DEPT_ID;
