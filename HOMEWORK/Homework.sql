-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 입사 후 6개월이 된 날짜 조회
SELECT EMP_NAME "이름", HIRE_DATE "입사일", ADD_MONTHS(HIRE_DATE,6) "입사 후 6개월"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
-- 단, 별칭은 근무일수1, 근무일수2로 하고
-- 모두 정수처리(내림), 양수가 되도록 처리
SELECT EMP_NAME "사원명", 
       ABS(FLOOR(HIRE_DATE - SYSDATE)) "입사일-오늘", 
       FLOOR(SYSDATE - HIRE_DATE) "오늘-입사일"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사번이 홀수인 직원들의 정보 모두 조회
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;


-- EMPLOYEE 테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM EMPLOYEE
WHERE TO_CHAR(NVL(ENT_DATE, SYSDATE),'YYYY') - TO_CHAR(HIRE_DATE, 'YYYY') >= 20;


-- EMPLOYEE 테이블에서 사원명, 입사일, 입사한 월의 근무일수를 조회
SELECT EMP_NAME "사원명", HIRE_DATE "입사일", LAST_DAY(HIRE_DATE) - HIRE_DATE "근무일수"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사원의 이름, 입사일, 근무년수 조회
-- 단 근무년수는 (현재년도 - 입사년도)로 조회하세요
-- 1) EXTRACT
SELECT EMP_NAME "이름", HIRE_DATE "입사일", 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "1) 근무년수",
       TO_CHAR(SYSDATE,'YYYY')- EXTRACT(YEAR FROM HIRE_DATE) "2) 근무년수"
FROM EMPLOYEE;


-- 2) MONTHS_BETWEEN
SELECT EMP_NAME "이름", HIRE_DATE "입사일", 
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) "근무년수"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 사원명, 급여 조회
-- 급여는 '\9,000,000' 형식으로 표시
SELECT EMP_NAME "이름", TO_CHAR(SALARY, 'FML9,999,999') "급여"
FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 이름, 입사일 조회
-- 입사일은 포맷 적용함 '2017년 12월 06일 (수)' 형식으로 출력
SELECT EMP_NAME "이름", TO_CHAR(HIRE_DATE, 'YYYY"년"MM"월"DD"일" "("DY")"') "입사일"
FROM EMPLOYEE;


-- 직원의 급여를 인상하고자 한다
-- 직급코드가 J7인 직원은 급여의 10%를 인상하고
-- 직급코드가 J6인 직원은 급여의 15%를 인상하고
-- 직급코드가 J5인 직원은 급여의 20%를 인상하며
-- 그 외 직급의 직원은 급여의 5%만 인상한다.
-- 직원 테이블에서 직원명, 직급코드, 급여, 인상급여(위 조건)을 조회하세요
-- 1) DECODE
SELECT EMP_NAME "직원명", JOB_CODE "직급코드", SALARY "급여",
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) "연상급여"
FROM EMPLOYEE;
-- 2) CASE WHEN
SELECT EMP_NAME "직원명", JOB_CODE "직급코드", SALARY "급여",
       CASE WHEN JOB_CODE='J7' THEN SALARY*1.1
            WHEN JOB_CODE='J6' THEN SALARY*1.15
            WHEN JOB_CODE='J5' THEN SALARY*1.2
       ELSE SALARY*1.05
       END "인상급여"
FROM EMPLOYEE;


-- 사번, 사원명, 급여
-- 급여가 500만원 이상이면 '고급'
-- 급여가 300~500만원이면 '중급'
-- 그 이하는 '초급'으로 출력처리하고 별칭은 '구분'으로 한다.
SELECT EMP_ID "사번", EMP_NAME "사원명", SALARY,
       CASE WHEN SALARY>=5000000 THEN '고'
            WHEN SALARY>=3000000 THEN '중'
       ELSE '초'
       END || '급' "구분"
FROM EMPLOYEE;


-- EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 조회
SELECT SUM((SALARY + (SALARY*NVL(BONUS, 0)))*12) "연봉",
       SUM(SALARY*12*NVL2(BONUS,BONUS+1,1)) "연봉"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- 직원명, 직급코드, 보너스가 포함된 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
SELECT EMP_NAME "직원명", DEPT_CODE "직급코드", TO_CHAR(SALARY*12*NVL2(BONUS,BONUS+1,1),'FML999,999,999') "연봉(원)"
FROM EMPLOYEE;


-- 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 사번, 사원명, 부서코드, 입사일
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_CODE "부서코드", HIRE_DATE "입사일"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9') AND TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY'))=2004;


-- 직원명, 입사일, 입사한 달의 근무일수 조회(단, 주말과 입사한 날도 근무일수에 포함함)
SELECT EMP_NAME "사원명", HIRE_DATE "입사일", LAST_DAY(HIRE_DATE) - HIRE_DATE+1 "근무일수"
FROM EMPLOYEE;


-- 부서코드가 D5와 D6이 아닌 사원들의 직원명, 부서코드, 생년월일, 나이(만) 조회
--  단, 생년월일은 주민번호에서 추출해서 ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 하고
--  나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음 계산
SELECT EMP_NAME "사원명", DEPT_CODE "부서코드", 
       SUBSTR(EMP_NO,1,2)||'년' 
       || SUBSTR(EMP_NO,3,2)||'월' 
       || SUBSTR(EMP_NO,5,2)||'일' "생년월일",
       EXTRACT(YEAR FROM SYSDATE)
       - TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'YYYY')||'세' "나이"
FROM EMPLOYEE;

    
-- 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2001,1,2002,1,2003,1,2004,1)) "전체직원수",
       SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2001,1)) "2001년",
       NVL(SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2002,1)),0) "2002년",
       NVL(SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2003,1)),0) "2003년",
       SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2004,1)) "2004년"
FROM EMPLOYEE;

--  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
-- 1) DECODE
SELECT EMP_NAME "사원명", DEPT_CODE "부서코드",
       DECODE(DEPT_CODE,'D5','총무부','D6','기획부','D9','영업부')
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR DEPT_CODE = 'D6' OR DEPT_CODE='D9';
-- 2) CASE WHEN
SELECT EMP_NAME "사원명", DEPT_CODE "부서코드",
       CASE WHEN DEPT_CODE='D5' THEN '총무부'
            WHEN DEPT_CODE='D6' THEN '기획부'
            WHEN DEPT_CODE='D9' THEN '영업부'
       END
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');




--------------------------------------------------------------------
-- 1. EMP테이블에서 COMM 의 값이 NULL이 아닌 정보 조회
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

-- 2. EMP테이블에서 커미션을 받지 못하는 직원 조회
SELECT * 
FROM EMP
WHERE COMM IS NULL OR COMM=0;

-- 3. EMP테이블에서 관리자가 없는 직원 정보 조회
SELECT *
FROM EMP
WHERE MGR IS NULL;

-- 4. EMP테이블에서 급여를 많이 받는 직원 순으로 조회
SELECT * 
FROM EMP
ORDER BY SAL DESC;

-- 5. EMP테이블에서 급여가 같을 경우 커미션을 내림차순 정렬 조회
SELECT * 
FROM EMP
ORDER BY SAL DESC, COMM ASC;

-- 6. EMP테이블에서 사원번호, 사원명, 직급, 입사일 조회 (단, 입사일을 오름차순 정렬 처리)
SELECT EMPNO "사원번호", ENAME "사원명", JOB "직급", HIREDATE "입사일"
FROM EMP
ORDER BY HIREDATE;

-- 7. EMP테이블에서 사원번호, 사원명 조회 (사원번호 기준 내림차순 정렬)
SELECT EMPNO "사원번호", ENAME "사원명"
FROM EMP
ORDER BY EMPNO DESC;

-- 8. EMP테이블에서 사번, 입사일, 사원명, 급여 조회 
--  (부서번호가 빠른 순으로, 같은 부서번호일 때는 최근 입사일 순으로 처리)
SELECT EMPNO "사원번호", HIREDATE "입사일" ,ENAME "사원명", SAL "급여"
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9. 오늘 날짜에 대한 정보 조회
SELECT SYSDATE
FROM DUAL;

-- 10. EMP테이블에서 사번, 사원명, 급여 조회 
--  (단, 급여는 100단위까지의 값만 출력 처리하고 급여 기준 내림차순 정렬)
SELECT EMPNO "사원번호", ENAME "사원명", TRUNC(SAL,-2) "급여"
FROM EMP
ORDER BY SAL DESC;

-- 11. EMP테이블에서 사원번호가 홀수인 사원들을 조회
SELECT *
FROM EMP
WHERE MOD(EMPNO,2)=1;

-- 12. EMP테이블에서 사원명, 입사일 조회 
--  (단, 입사일은 년도와 월을 분리 추출해서 출력)
SELECT ENAME "사원명", 
TO_CHAR(TO_DATE(SUBSTR(HIREDATE,1,2),'RR'),'YYYY') "입사년도", 
EXTRACT(YEAR FROM HIREDATE) "입사년도",
TO_NUMBER(SUBSTR(HIREDATE,4,2)) "입사월"
FROM EMP;

-- 13. EMP테이블에서 9월에 입사한 직원의 정보 조회
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- 14. EMP테이블에서 81년도에 입사한 직원 조회
SELECT *
FROM EMP
WHERE TO_NUMBER(SUBSTR(HIREDATE,1,2)) = 81;

-- 15. EMP테이블에서 이름이 'E'로 끝나는 직원 조회
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

-- 16. EMP테이블에서 이름의 세 번째 글자가 'R'인 직원의 정보 조회
-- 1) LIKE
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- 2) SUBSTR()
SELECT *
FROM EMP
WHERE SUBSTR(ENAME,3,1)='R';

-- 17. EMP테이블에서 사번, 사원명, 입사일, 입사일로부터 40년 되는 날짜 조회
SELECT EMPNO "사번", ENAME "사원명", HIREDATE "입사일", ADD_MONTHS(HIREDATE,480) "입사일로부터 40년"
FROM EMP;

-- 18. EMP테이블에서 입사일로부터 38년 이상 근무한 직원의 정보 조회
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(TO_DATE(190516),HIREDATE)/12 >= 38;

-- 19. 오늘 날짜에서 년도만 추출
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;


-- BASIC -------------------------------------------------------------------
-- 춘 기술대학교의 학과 이름과 계열을 표시하시오. 
--      단, 출력 헤더는 "학과명", "계열"으로 표시하도록 한다.]

SELECT DEPARTMENT_NAME "학과명", CATEGORY "계열"
FROM TB_DEPARTMENT;

-- 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
SELECT DEPARTMENT_NAME || '의 정원은 '|| CAPACITY ||'명 입니다'
FROM TB_DEPARTMENT;

-- "국어국문학과"에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 들어왔다.
-- 누구인가? (국어학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자.
-- JOIN
SELECT STUDENT_NAME
FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '국어국문학과' 
     AND ABSENCE_YN = 'Y' 
     AND SUBSTR(STUDENT_SSN,8,1) = 2;
     
-- 일반
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' 
      AND ABSENCE_YN = 'Y' 
      AND SUBSTR(STUDENT_SSN,8,1) = 2;     
      
      
-- 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그 대상자들의
-- 학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성하시오.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

-- 입학정원이 20명이상 30명이하인 학과들의 학과 이름과 계열을 출력하시오.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
-- 그럼 춘 기숙대학교 총장의 이름을 알아 낼 수 있는 SQL 문장을 작성하시오.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
-- 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 
-- 과목들은 어떤 과목인지 과목번호를 조회해보시오.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오.
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 02 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외한 재학중인
-- 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N' 
AND STUDENT_ADDRESS LIKE '전주%' 
AND SUBSTR(STUDENT_NO,1,2) = 'A2';

-- FUNCTION ------------------------------------------------------------------

-- 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 순으로
-- 표시하는 SQL 문장을 작성하시오 ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
SELECT STUDENT_NO "학번", STUDENT_NAME "이름", ENTRANCE_DATE "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 
-- 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자.
-- (* 이때 올바르게 작성한 SQL 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해 볼 것)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오
-- 단, 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.
-- 단, 교수 중 2000년 이후 출생자는 없으며 출력헤더는 "교수이름", "나이"로 한다. 나이는 '만'으로 계산한다.
SELECT PROFESSOR_NAME "교수이름", EXTRACT(YEAR FROM SYSDATE)-(TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN,1,2),'YY'),'YYYY')-100) "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY 나이;

-- 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오.
-- 출력 헤더는 "이름"이 찍히도록 한다. (성이 2자인 경우는 교수는 없다고 가정하시오)
SELECT SUBSTR(PROFESSOR_NAME,2) "이름"
FROM TB_PROFESSOR
WHERE LENGTH(SUBSTR(PROFESSOR_NAME,2)) >= 1;

-- 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?
-- 이때, 19살에 입학하면 재수를 하지 않은 것으로 간주한다.
-- 1)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'))>19;
-- 2)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)- TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'),'YYYY')  > 19;

-- 2020년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR(TO_DATE(20201225,'YYMMDD'),'DAY') "크리스마스"
FROM DUAL;

-- TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
-- 또 TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD')은 각각 몇 년 몇 월 몇 일을 의미할까?
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY/MM/DD'), 
       -- YY는 현재 세기를 붙여준다
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY/MM/DD'), 
       -- YY는 현재 세기를 붙여준다
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'),'YYYY/MM/DD'),
       -- 50~99까지는 전 세기를 붙여준다.
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'),'YYYY/MM/DD')
       -- 00~49까지는 현재 세기를 붙여준다.
FROM DUAL;

-- 춘 기술대학교의 2000년도 이후 힙학자들은 학번이 A로 시작하게 되어있다.
-- 2000년도 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%';

-- 학번이 A517178인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오.
-- 단, 이떄 출력 화면의 헤더는 "평정" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
SELECT ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는지 알아내는 SQL 문을 작성하시오.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL
GROUP BY COACH_PROFESSOR_NO;

-- 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고,
-- 점수는 반올림하여 소수점 이하 한 자리까지만 표시한다.
SELECT SUBSTR(TERM_NO,1,4) "년도", ROUND(AVG(POINT),1) "년도 별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
--SELECT DEPARTMENT_NO "학과코드명", COUNT(*) "휴학생 수"
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
WHERE absence_yn IN('Y')
GROUP BY DEPARTMENT_NO
--ORDER BY DEPARTMENT_NO;
MINUS 
SELECT DEPARTMENT_NO 학과번호, COUNT(*) "휴학생 수"
FROM TB_STUDENT
WHERE ABSENCE_YN ='N'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다.
-- 어떤 SQL 문장을 사용하면 가능하겠는가?
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

-- 학번이 A112113인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 총 평점을 구하는 SQL 문을 작성하시오.
-- 단, 평점은 소수점 1자리까지만 반올림하여 표시한다.
SELECT SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2), ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));



-- OPTION---------------------------------------------------------------------------------
-- 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고,
-- 정렬은 이름으로 오름차순 표시하도록한다.
SELECT STUDENT_NAME "학생 이름", STUDENT_ADDRESS "주소지"
FROM  TB_STUDENT
ORDER BY STUDENT_NAME;

-- 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN IN 'Y'
ORDER BY TO_NUMBER(SUBSTR(STUDENT_SSN,1,6)) DESC;

-- 주소지가 강원도나 경기도인 학생들 중 1900년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더는 "학생이름", "학번", "거주지 주서"가 출력되도록 한다.
SELECT STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '강원%' 
OR STUDENT_ADDRESS LIKE '경기%')
AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_ADDRESS;

-- 현재 법학과 교수 중 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- 법학과의 '학과코드'는 학과테이블(TB_DEPARTMENT)을 조회해서 찾아내도록 하자
SELECT P.PROFESSOR_NAME, P.PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.DEPARTMENT_NAME IN '법학과'
ORDER BY SUBSTR(PROFESSOR_SSN,1,6);

-- 2004년 2학기에 'C3118100' 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE TERM_NO IN '200402'AND CLASS_NO IN 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY S.STUDENT_NAME;

-- 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;

-- 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO;

-- 8번의 결과 중 '인문사회' 계열에 속한 과목의 교수 이름을 찾으려고 한다.
-- 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.CATEGORY IN '인문사회';

-- '음악학과' 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을
-- 출력하는 SQL 문장을 작성하시오.
-- 단, 평점은 소수점 1자리까지만 반올림하여 표시한다.
SELECT S.STUDENT_NO "학번", STUDENT_NAME "학생 이름", ROUND(AVG(G.POINT),1) "전체 평점"
FROM TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
WHERE S.STUDENT_NO = G.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.DEPARTMENT_NAME IN '음악학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY S.STUDENT_NO;

-- 학번이 A313047 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 
-- 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학과이름", "학생이름", "지도규수이름"으로 출력되도록 한다.
SELECT DEPARTMENT_NAME "학과이름", STUDENT_NAME "학생이름", PROFESSOR_NAME "교수이름" 
FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND STUDENT_NO = 'A313047';

-- 2007년도에 '인간관계론' 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
SELECT STUDENT_NAME, G.TERM_NO
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE G.CLASS_NO = C.CLASS_NO 
AND G.STUDENT_NO = S.STUDENT_NO
AND C.CLASS_NAME IN '인간관계론'
AND G.TERM_NO LIKE '2007%';

-- 예체능 계열 과목 중 과목 담당교수를 한 명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D, TB_CLASS_PROFESSOR CP 
WHERE C.DEPARTMENT_NO(+) = D.DEPARTMENT_NO
AND CP.CLASS_NO(+) = C.CLASS_NO
AND PROFESSOR_NO IS NULL
AND CATEGORY = '예체능'
ORDER BY CLASS_NAME;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
     LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
     LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '예체능'
      AND PROFESSOR_NO IS NULL;
      
      
-- 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 만일 지도 교수가 없는 학생일 경우
-- "지도교수 미지정" 으로 표시하도록 하는 SQL 문을 작성하시오.
-- 단, 출력헤더는 "학생이름", "지도교수"로 표시하며 고학번 학생이 먼저 표시되도록 한다.
SELECT STUDENT_NAME 학생이름, NVL(PROFESSOR_NAME, '지도교수 미지정') 지도교수
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P 
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
AND D.DEPARTMENT_NAME = '서반아어학과'
ORDER BY STUDENT_NO;


-- 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(POINT),5)
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.STUDENT_NO = G.STUDENT_NO
AND S.ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(POINT) >=4.0
ORDER BY STUDENT_NO;

-- 환경 조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
SELECT C.CLASS_NO, C.CLASS_NAME, AVG(POINT)
FROM TB_CLASS C, TB_DEPARTMENT D, TB_GRADE G
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND C.CLASS_NO = G.CLASS_NO
AND DEPARTMENT_NAME = '환경조경학과' AND CLASS_TYPE = '전공선택'
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY CLASS_NO;

-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
SELECT S.STUDENT_NO, S.STUDENT_NAME, AVG(POINT) "평균"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND G.STUDENT_NO = S.STUDENT_NO
AND D.DEPARTMENT_NAME = '국어국문학과'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME;


SELECT JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT DEPT_TITLE
FROM EMPLOYEEL