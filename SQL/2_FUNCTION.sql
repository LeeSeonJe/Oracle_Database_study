-- 함수(FUNCTION) : 컬럼의 값을 읽어서 계산한 결과 리턴
-- 단일 행 함수 (SINGLE ROW FUNCTION)
--      N개의 값을 넣어서 N개의 결과 리턴
--SELECT LENGTH(EMP_NAME)
--FROM EMPLOYEE;
-- 그룹 함수(GROUP FUNCTION)
--      N개의 값을 넣어서 한 개의 결과 리턴
--SELECT COUNT(EMP_NAME)
--FROM EMPLOYEE;
-- 단일 행 함수와 그룹 함수를 같이 쓸 경우 결과 행 개수가 다르기 때문에 에러가 발생!
--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM EMPLOYEE;

-- 단일 행 함수
-- 1. 문자 관련 함수

-- LENGTH / LENGTHB
-- LENGTH(컬럼명 | '문자열') : 글자 수 반환
-- LENGTHB(컬럼명 | '문자열') : 글자의 바이트 크기 반환
SELECT LENGTH('오라클'), LENGTHB('오라클') -- 오라클에서 한글은 3BYTE를 가진다.
FROM DUAL; -- 가상테이블

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 문자 첫번째 위치 (오라클은 ZERO INDEX 기반이 아니다.)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- 첫번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- 끝부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- 끝부터 읽기 시작해서 처음으로 나오는 C의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- 첫번째부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- 끝에서 읽기 시작해서 두번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;

-- EMPLOYEE테이블에서 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD : 주어진 컬럼이나 문자열에 임의의 문자열을 왼쪽/오른쪽에 덧붙여 길이 N의 문자열 반환
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE; 

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- LTRIM/RTRIM/TRIM : 주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 또는 앞/뒤/양쪽에서 지정한 문자 제거
SELECT LTRIM('   KH') FROM DUAL; -- 삭제할 문자열을 지정하지 않았을 경우 공백이 DEFAUL가 됨
SELECT LTRIM('   KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5781KH' , '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL; -- DFAULT : 공백
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;

SELECT TRIM('   KH   ') FROM DUAL; -- DFAULT : 공백
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('1' FROM '123132KH123321') FROM DUAL; -- 한 글자만 제거 가능
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- 앞
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- 뒤
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZZ') FROM DUAL; -- 양쪽

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치부터 지정 개수의 문자열을 잘라낸 반환
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- 끝지점을 지정해주지 않으면 끝까지 읽는다.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;

-- EMPLOYEE테이블에서 이름, 이메일, @이후를 제외한 아이디 조회
SELECT EMP_NAME, SUBSTR(EMAIL, 0, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-- 주민등록번호에서 성별을 나타내는 부분만 잘라보기
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) "앞자리"
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원 명, 생년, 생월, 생일 조회
-- 940520
SELECT EMP_NAME, '19'||SUBSTR(EMP_NO, 1,2)||'년' "생년", SUBSTR(EMP_NO ,3,2)||'월' "월", SUBSTR(EMP_NO,5,2)||'일' "일"
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL;

-- CONCAT
SELECT CONCAT('가나다라', 'ABCE') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

-- REPLACE
SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
SELECT REPLACE('서정호 학생의 별명은 군인일까요?', '군인', '에코') FROM DUAL;

-- EMPLOYEE테이블에서 이메일의 도메인을 gmail.com으로 변경하기
SELECT REPLACE(EMAIL, SUBSTR(EMAIL,INSTR(EMAIL, '@')+1), 'google.com') "이메일"
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사원 명, 주민번호 조회
-- 단, 주민번호는 생년월일-성별 까지만 보이게하고 나머지 값은'*'로 바꾸기
-- EX. 940520-1******
SELECT EMP_NAME "이름", CONCAT(SUBSTR(EMP_NO, 1, 8),'******') "주민번호"
FROM EMPLOYEE;

SELECT EMP_NAME "이름", RPAD(SUBSTR(EMP_NO, 1, 8),14,'*')
FROM EMPLOYEE;

SELECT EMP_NAME "이름", REPLACE(EMP_NO, SUBSTR(EMP_NO, 9),'******')
FROM EMPLOYEE;

-- 2. 숫자 관련 함수

-- ABS : 절대 값을 리턴해주는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : 나머지 
SELECT MOD(10,3) FROM DUAL; --1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- 뒤에 나누어주는 피연산자는 부호의 영향을 받지 않는다.
SELECT MOD(10.9,3) FROM DUAL; -- 1.9
SELECT MOD(-10.9,3) FROM DUAL; -- -1.9

-- ROUND : 반올림 (ROUND 함수만 ZERO기반 INDEX로 표현)
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-- 번외
SELECT ROUND(-10.61) FROM DUAL; -- -11

-- FLOOOR : 내림
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : 버림(절삭)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.678, 1) FROM DUAL;
SELECT TRUNC(123.678, -1) FROM DUAL;

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 3. 날짜 관련 함수
-- SYSDATE : 오늘 날짜 반환

-- MONTHS_ BETWEEN : 날짜와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수
-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME, HIRE_DATE, ABS(FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)))
FROM EMPLOYEE;

-- ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5)
FROM DUAL;

SELECT ADD_MONTHS(SYSDATE, 15) -- 개월 수가 넘어가면 년도가 자동으로 넘어감.
FROM DUAL;

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가까운 날짜를 리턴하는 함수
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 일 월 화  수 목 금  토 
-- 1  2  3  4  5  6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화진씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL; -- 화요일 날짜가 나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '연화씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL; -- 아무리 길어도 첫글자만 파악
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;

-- 언어 세팅에 따라서 값이 나올 수 있고 오류가 나올 수가 있다.
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : 해당 월에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : 날짜에서 년, 월, 일 추출하여 리턴
-- SELECT EXTRACT(YEAR FROM 날짜); 
-- SELECT EXTRACT(MONTH FROM 날짜); 
-- SELECT EXTRACT(DAY FROM 날짜); 

-- EMPLOYEE테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 조회
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||, EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- 4. 형 변환 함수
-- TO_CHAR(날짜[, 포맷]) : 날짜형 데이터 ==> 문자형 데이터
-- TO_CHAR(숫자[, 포맷]) : 숫자형 데이터 ==> 문자형 데이터
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5칸 자리수를 만들어주고 오른쪽 정렬, 빈칸은 공백
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 5칸 자리수를 만들어주고 오른쪽 정렬, 빈칸은 0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- L 한글, $ 달러 그냥 써주면 공백이 생김, 없애기 위해서는 FML, FM$을 사용하도록 하자.
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99,999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$00,000') FROM DUAL;

SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL; -- 지수로 표현
SELECT TO_CHAR(1234, '999') FROM DUAL; -- 크기가 작으면 '#'으로 표현 EX. 엑셀에서 칸을 줄이면 #으로 치환되는 것과 동일

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- 앞에 PM, AM은 크게 신경쓰지 않는다. 자동으로 알맞게 나옴
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- DAY와 DY의 차이 DAY 는 [수]요일, DY는 [수] // 요일이 붙냐 안붙냐 차이
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- FM이 붙으면 앞에 02월이 2월로 변경, FM이 붙은 기준점에서 뒤로 다 FM이 붙은 형식으로 나옴
SELECT TO_CHAR(SYSDATE, 'YEAR, Q')||'분기' FROM DUAL; -- 결과값 TWENTY,TWENTY, 1이 나옴, 1의 값은 분기를 말함(1~4분기)
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일" DAY') FROM DUAL; -- " " 로 감싸서 만들어준다. 기호는 그냥 들어감. 문자를 넣을려면 감싸주기


-- 오늘 날짜 대해
-- 연도 출력
SELECT TO_CHAR(SYSDATE,'YYYY'), TO_CHAR(SYSDATE,'YY'), TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

-- 월 출력
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- 일 출력
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 연 기준으로 N일째
        TO_CHAR(SYSDATE, 'DD'), -- 달 기준으로 N일째
        TO_CHAR(SYSDATE, 'D'), -- 주 기준으로 N일째
        TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- 분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- TO_DATE : 문자/숫자형 데이트 ==> 날짜형 데이터
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL; -- 오라클에서는 기본적으로 년도를 표현할때는 2개의 데이터만 표시되게 되어있어서 그렇다.!

-- 2010 01 01 ==> 2010, 1월 
SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY,MON') FROM DUAL; -- 혼합해서 사용가능!!!!

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
FROM DUAL;

-- RR과 YY의 차이 : 둘다 년도를 나타낸다
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'), 'YYYYMMDD'), -- 무조건 YY두자리에 현재 세기를 맞춰서 적용
        TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD'),
        TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'), -- YY두자리 연도가 50년 이상이면 아래 세기, 50년 미만이면 현재 세기
        TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'YYYYMMDD')
FROM DUAL;

-- TO_NUMBER : 문자형 데이터 ==> 숫자형 데이터
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL; -- 오라클에서 자동으로 문자열안에 숫자만 있으면 자동으로 숫자로 바꿔줌
SELECT '1,000,000' + '550,000' FROM DUAL;

SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999')
FROM DUAL;

-- 5. NULL 처리 함수
-- NVL(컬럼명, 컬럼 값이 NULL일 때 바꿀 값)
-- NVL2(컴럼명, 바꿀 값1, 바꿀 값2) -- 컬럼 값이 NULL이 아니면 바꿀 값1 이고, 컬럼 값이 NULL이면 바꿀 값2

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로, NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123,123) FROM DUAL;
SELECT NULLIF(123,124) FROM DUAL;


-- 6. 선택함수 : 여러 가지 경우 선택할 수 있는 기능 제공
-- DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2....)
-- 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') "성별"  
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') "성별"  
FROM EMPLOYEE;
-- 마지막 인자로 조건 값 없이 선택 값을 작성하면
-- 아무것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

-- CASE WHEN 조건식 THEN 결과값
--      WHEN 조건식 THEN 결과값
--      ELSE 결과값
-- END
-- 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건은 범위가능)

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '남'
             ELSE '여'
        END 성별
FROM EMPLOYEE;

-- 급여가 500만 초과 1등급, 350만 초과 2등급, 200만 초과 3등급, 나머지 4등급
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY>5000000 THEN '1'
             WHEN SALARY>3500000 THEN '2'
             WHEN SALARY>2000000 THEN '3'
        ELSE '4'
        END ||'등급' "VIP등급"
FROM EMPLOYEE;


-- 그룹함수 : 여러 행을 넣으면 한 개의 결과 반환
-- SUM(숫자가 기록된 컬럼) : 합계 리턴
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 남자 사원의 급여 총 조회
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- AVG(숫자가 기록된 컬럼) : 평균 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 전 사원의 BONUS 합계 조회
SELECT SUM(BONUS)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 전 사원의 BONUS 평균 조회
SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
-- NULL값을 가진 행은 평균 계산에서 제외 되어 계산

-- MIN / MAX : 최대 / 최소
-- EMPLOYEE테이블에서 가장 작은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 가장 많은 급여, 알파벳 순서가 가장 마지막인 이메일, 가장 느린 입사일
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | 컬럼명) : 행의 개수 리턴
-- COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수 리턴
-- COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;