--SELECT * FROM EMPLOYEE;
--WHERE EMP_ID = 200;

-- SELECT
-- Result Set : SELECT 구문으로 데이터를 조회한 결과물, 반환된 행들의 집합(0행 이상)

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT EMP_ID , EMP_NAME , EMP_NO , EMAIL , PHONE , DEPT_CODE , JOB_CODE , SAL_LEVEL , SALARY , BONUS , MANAGER_ID , HIRE_DATE , ENT_DATE , ENT_YN  
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE;

-- 미니 실습 문제
-- 1. JOB테이블의 모든 정보 조회
SELECT JOB_CODE, JOB_NAME  
FROM JOB;

-- 2. JOB테이블의 직급 이름 조회
SELECT JOB_NAME 
FROM JOB;

-- 3. DEPARTMENT테이블의 모든 정보 조회
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID 
FROM DEPARTMENT;

-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- 컬럼 값 산술 연산
-- SELECT 시 컬럼 명 입력 부분에 계산에 필요한 컬럼 명, 숫자, 연산자를 이용해서 결과 조회 가능

-- EMPLOYEE테이블에 직원 명, 연봉 조회 (연봉 = 급여 * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 직원의 직원 명, 연봉, 보너스를 추가한 연봉 조회
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY * 12, (SALARY * (1 + BONUS)) * 12
FROM EMPLOYEE;

--SELECT *,SALARY*12 // *(아스트로)는 혼자 사용해야 한다
--FROM EMPLOYEE;

-- 1. EMPLOYEE 테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
SELECT EMP_NAME, SALARY * 12 연봉, (SALARY * (1 + BONUS)) * 12 총수령액, ((SALARY * (1 + BONUS)) * 12 - (SALARY * 12 * 0.03)) 실수령액
FROM EMPLOYEE;

-- 2. EMPLOYEE 테이블에서 이름, 고용일, 근무일수(오늘일자 - 고용일) 조회
-- SELECT SYSDATE -- 오늘 날짜 출력
-- FROM DUAL; -- 가상 테이블
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) 근무일수
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