# FUNCTION
### 함수
+
  + 자바에서의 메소드를 의미 
  + 하나의 큰 프로그램에서 반복적으로 사용되는 부분들을 분리하여 작성해 놓은 작은 서브 프로그램
  + 호출하며 값을 전달하면 결과를 리턴하는 방식으로 사용

+ 단일 행 함수(SINGLE ROW FUNCTION)
  + 각 행마다 반복적으로 적용되어 입력 받은 행의 개수만큼 결과 반환
  + N개의 값을 넣어서 N개의 결과 리턴
  >
  ```SQL
  --EX)
  SELECT LENGTH(EMP_NAME)
  FROM EMPLOYEE;
  ```
+ 그룹 함수(GROUP FUNCTION)
  + 특정 행들의 집합으로 그룹이 형성되어 적용됨, 그룹 당 1개의 결과 반환
  >
  ```SQL
  --EX)
  SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
  FROM EMPLOYEE;  
  ```

## 단일 행 함수
### 1. 문자 관련 함수

+ #### LENGTH/LENGTHB
  + **LENGTH**(컬럼명 | '문자열') : 글자 수 반환**
  >
  ```SQL
  SELECT LENGTH('오라클'), LENGTHB('오라클') -- 오라클에서 한글은 3BYTE를 가진다.
  FROM DUAL; -- 가상테이블
  ```
  + **LENGTHB**(컬럼명 | '문자열') : 글자의 바이트 크기 반환
  >
  ```SQL
  SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
  FROM EMPLOYEE;
  ```
+ 
  + **INSTR** : 해당 문자열의 문자 첫번째 위치 **(오라클은 ZERO INDEX 기반이 아니다.)**
  >
  ```SQL
  SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
  -- RESULT : 3
  SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;
  -- RESULT : 0
  
  SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; 
  -- RESULT : 3 ==> 첫번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; 
  -- RESULT : 10 ==> 끝부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; 
  -- RESULT : 6 ==> 끝부터 읽기 시작해서 처음으로 나오는 C의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; 
  -- RESULT : 9 ==> 첫번째부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; 
  -- RESULT : 9 ==> 끝에서 읽기 시작해서 두번째로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;
  -- RESULT : 0 ==> 첫번째부터 읽기 시작해서 두번째로 나오는 C의 위치 반환

  -- EMPLOYEE테이블에서 이메일의 @ 위치 반환
  SELECT EMAIL, INSTR(EMAIL, '@') FROM EMPLOYEE;  
  ```

+ #### LPAD/RPAD 
  + **LPAD** : 주어진 컬럼이나 문자열에 임의의 문자열을 **왼쪽**에 덧붙여 길이 N의 문자열 반환
  >
  ```SQL
  SELECT LPAD(EMAIL, 20)
  FROM EMPLOYEE;

  SELECT LPAD(EMAIL, 20, '#')
  FROM EMPLOYEE; 
  ```
  + **RPAD** : 주어진 컬럼이나 문자열에 임의의 문자열을 **오른쪽**에 덧붙여 길이 N의 문자열 반환
  >
  ```SQL
  SELECT RPAD(EMAIL, 20)
  FROM EMPLOYEE; 

  SELECT RPAD(EMAIL, 20, '#')
  FROM EMPLOYEE;
  ```
+ #### LTRIM/RTRIM/TRIM
  + **LTRIM** : 주어진 컬럼이나 문자열의 **왼쪽**에서 **지정한 문자**가 **제거**
  >
  ```SQL
  SELECT LTRIM('   KH') FROM DUAL;
  -- RESULT : KH ==> 삭제할 문자열을 지정하지 않았을 경우 공백이 DEFAUL가 됨
  SELECT LTRIM('   KH', ' ') FROM DUAL;
  -- RESULT : KH ==> 지정한 문자가 ' '
  SELECT LTRIM('000123456', '0') FROM DUAL;
  -- RESULT : 123456
  SELECT LTRIM('123123KH', '123') FROM DUAL;
  -- RESULT : KH
  SELECT LTRIM('123123KH123', '123') FROM DUAL;
  -- RESULT : KH123 ==> 뒤에도 123이 있지만 왼쪽에서부터 비교를 하다가 다른값이 나오는 인덱스부터 끝까지 반환함.
  SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
  -- RESULT : KH ==> 'ABC' 자체를 비교하는 것이 아니고 각각 하나하나 모두 비교한다.
  SELECT LTRIM('5781KH' , '0123456789') FROM DUAL;
  -- RESULT : KH ==> 이것 또한 뒤에 비교값을 문자열로 비교하는 것이 아니라 문자 하나하나 비교하기 때문에 그렇다.
  ```
  
  + **RTRIM** : 주어진 컬럼이나 문자열의 **오른쪽**에서 **지정한 문자**가 **제거**
  > 
  ```SQL
  SELECT RTRIM('KH   ') FROM DUAL;
  -- RESULT : KH ==> DFAULT : 공백
  SELECT RTRIM('123456000', '0') FROM DUAL;
  -- RESULT : 123456
  SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;
  -- RESULT : KH ==> 위에 LTRIM 마지막 예제와 동일
  ```
  
  + **TRIM** : 주어진 컬럼이나 문자열의 **앞/뒤/양쪽**에서 **지정한 문자**가 **제거**
  >
  ```SQL
  SELECT TRIM('   KH   ') FROM DUAL;
  -- RESULT : KH ==> DFAULT : 공백
  SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
  -- RESULT : KH
  SELECT TRIM('123' FROM '123132KH123321') FROM DUAL;
  -- RESULT : ERROR ==> trim set should have only one character : TRIM은 한글자만 사용가능하다.
                        위에 LTRIM이나 RTRIM 처럼 한번에 여러문자를 넣어놓고 각각 비교하지 않는다.
  SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
  -- RESULT : 123456ZZZ ==> 앞에서부터 제거하고 값이 다른 인덱스를 만나면 끝까지 출력
  SELECT TRIM(TRAILING 'Z' FROM 'ZZZ123456ZZZ') FROM DUAL;
  -- RESULT : ZZZ123456 ==> 뒤에서부터 제거하고 값이 다른 인덱스를 만나면 끝까지 출력
  SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZZ') FROM DUAL;
  -- RESULT : 123456 ==> 양쪽제거
  ```
  
+ 
  + **SUBSTR** : 컬럼이나 문자열에서 **지정한 위치**부터 **지정 개수**의 **문자열**을 잘라내 **반환**
  >
  ```SQL
  SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
  -- RESULT : THEMONEY ==> 끝지점을 지정해주지 않으면 끝까지 읽는다.
  SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
  -- RESULT : ME ==> 5번째 인덱스부터 문자 2개를 반환
  SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;
  -- RESULT : null
  SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
  -- RESULT : SHOWME
  SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
  -- RESULT : THE ==> 뒤에서 8번째 인덱스부터 문자 3개를 반환
  SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;
  -- RESULT : ME
  
  -- EMPLOYEE테이블에서 이름, 이메일, @이후를 제외한 아이디 조회
  SELECT EMP_NAME, SUBSTR(EMAIL, 0, INSTR(EMAIL, '@')-1)
  FROM EMPLOYEE;
  -- 단일 행 함수는 중첩 사용이 되니 잘외워두자.
  
  -- 주민등록번호에서 성별을 나타내는 부분만 잘라보기
  SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) "앞자리"
  FROM EMPLOYEE;

  -- EMPLOYEE테이블에서 직원들의 주민번호를 이용하여 사원 명, 생년, 생월, 생일 조회
  SELECT EMP_NAME, 
          '19'||SUBSTR(EMP_NO, 1,2)||'년' "생년", 
          SUBSTR(EMP_NO ,3,2)||'월' "월", 
          SUBSTR(EMP_NO,5,2)||'일' "일"
  FROM EMPLOYEE;
  ```
+ #### LOWER/UPPER/INITCAP
  + **LOWER** : 컬럼의 문자 혹은 문자열을 **소문자**로 변환하여 반환
  >
  ```SQL
  SELECT LOWER('Welcome To My World') FROM DUAL;
  -- RESULT : welcome to my world
  ```
  
  + **UPPER** : 컬럼의 문자 혹은 문자열을 **대문자**로 변환하여 반환
  >
  ```SQL
  SELECT UPPER('Welcome To My World') FROM DUAL;
  -- RESULT : WELCOME TO MY WORLD
  ```
  
  + **INITCAP** : 컬럼의 문자 혹은 문자열을 **첫 글자만 대문자**로 변환하여 반환
  >
  ```SQL
  SELECT INITCAP('welcome to my world') FROM DUAL;
  -- RESULT : Welcome To My World
  ```
+ 
  + **CONCAT** : 컬럼의 문자 혹은 문자열을 **두 개** 전달 받아 **하나로 합친** 후 반환
    + || 연결연산자와 동일
  >
  ```SQL
  SELECT CONCAT('가나다라', 'ABCE') FROM DUAL;
  -- RESULT : 가나다라ABCD
  SELECT '가나다라' || 'ABCD' FROM DUAL;
  -- RESULT : 가나다라ABCD
  ```
  
+ 
  + **REPLACE** : 컬럼의 문자 혹은 문자열에서 **특정 문자**(열)을 **지정한 문자**(열)로 바꾼 후 반환
  >
  ```SQL
  SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '삼성동') FROM DUAL;
  -- RESULT : 서울시 강남구 삼성동
  SELECT REPLACE('서정호 학생의 별명은 군인일까요?', '군인', '에코') FROM DUAL;
  -- RESULT : 서정호 학생의 별명은 에코일까요?
  
  -- EMPLOYEE테이블에서 이메일의 도메인을 gmail.com으로 변경하기
  SELECT REPLACE(EMAIL, SUBSTR(EMAIL,INSTR(EMAIL, '@')+1), 'google.com') "이메일"
  FROM EMPLOYEE;

  -- EMPLOYEE테이블에서 사원 명, 주민번호 조회
  -- 단, 주민번호는 생년월일-성별 까지만 보이게하고 나머지 값은'*'로 바꾸기
  -- EX. 940520-1******
  -- 1)
  SELECT EMP_NAME "이름", CONCAT(SUBSTR(EMP_NO, 1, 8),'******') "주민번호"
  FROM EMPLOYEE;
  
  -- 2)
  SELECT EMP_NAME "이름", RPAD(SUBSTR(EMP_NO, 1, 8),14,'*')
  FROM EMPLOYEE;

  -- 3)
  SELECT EMP_NAME "이름", REPLACE(EMP_NO, SUBSTR(EMP_NO, 9),'******')
  FROM EMPLOYEE;
  ```

### 2. 숫자 처리 함수
+ #### ABS/MOD/ROUND/FLOOR/TRUNC/CEIL
  + **ABS** : **절대 값** 반환
  >
  ```SQL
  SELECT ABS(10.9) FROM DUAL;
  -- RESULT : 10.9
  SELECT ABS(-10.9) FROM DUAL;
  -- RESULT : 10.9
  SELECT ABS(10) FROM DUAL;
  -- RESULT : 10
  SELECT ABS(-10) FROM DUAL;
  -- RESULT : 10
  ```
  + **MOD** : 입력 받은 수를 나눈 **나머지 값** 반환
  >
  ```SQL
  SELECT MOD(10,3) FROM DUAL;
  -- RESULT : 1
  SELECT MOD(-10,3) FROM DUAL;
  -- RESULT : -1 ==> 앞의 피연산자의 부호를 따라감
  SELECT MOD(10,-3) FROM DUAL;
  -- RESULT : 1 ==> 뒤에 나누어주는 피연산자는 부호의 영향을 받지 않는다. 절대값으로 나눈 결과와 동일
  SELECT MOD(10.9,3) FROM DUAL;
  -- RESULT : 1.9
  SELECT MOD(-10.9,3) FROM DUAL;
  -- RESULT : 1.9
  ```
  + **ROUND** : 특정 자릿수에서 **반올림** **!!!(소수점아래만 ZERO기반 INDEX가 적용됨)**
  >
  ```SQL
  SELECT ROUND(123.456) FROM DUAL;
  -- RESULT : 123
  SELECT ROUND(123.678, 0) FROM DUAL;
  -- RESULT : 124
  SELECT ROUND(123.456, 1) FROM DUAL;
  -- RESULT : 123.5
  SELECT ROUND(123.456, 2) FROM DUAL;
  -- RESULT : 123.46
  SELECT ROUND(123.456, -2) FROM DUAL;
  -- RESULT : 100 ==> 소수점 아래는 0번째 인덱스부터 시작, 소수점 위는 1번째 인덱스부터 시작!
  
  -- 번외
  SELECT ROUND(-10.61) FROM DUAL;
  -- RESULT : -11 ==> 그림을 그려보자.. 그럼 이해쏙쏙
  ```
  + **FLOOR** : **버림**(소수점 아래를 잘라냄)
  >
  ```SQL
  SELECT FLOOR(123.456) FROM DUAL;
  -- RESULT : 123
  SELECT FLOOR(123.678) FROM DUAL;
  -- RESULT : 123
  ```
  + **TRUNC** : **특정 자릿수**에서 잘라냄
  >
  ```SQL
  SELECT TRUNC(123.456) FROM DUAL;
  -- RESULT : 123
  SELECT TRUNC(123.678) FROM DUAL;
  -- RESULT : 123
  SELECT TRUNC(123.678, 1) FROM DUAL;
  -- RESULT : 123.6
  SELECT TRUNC(123.678, -1) FROM DUAL;
  -- RESULT : 120 ==> 소수점을 기준으로 -(마이너스)가 붙으면 위의 정수값 아래로 잘라냄
  ```
  + **CEIL** : **올림**(소수점 아래에서 올림)
  >
  ```SQL
  SELECT CEIL(123.456) FROM DUAL;
  -- RESULT : 123
  SELECT CEIL(123.678) FROM DUAL;
  -- RESULT : 124
  ```
  
### 3. 날짜 관련 함수
+
  + **SYSDATE** : **오늘 날짜 반환**
  >
  ```SQL
  SELECT SYSDATE FROM DUAL;
  -- RESULT : 20/02/06
  ```
+ #### MONTHS_BETWEEN/ADD_MONTHS
  + **MONTHS_BETWEEN** : 날짜와 날짜 사이의 **개월 수 차이**를 숫자로 리턴하는 함수
  >
  ```SQL
  -- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
  SELECT EMP_NAME, HIRE_DATE, ABS(FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)))
  FROM EMPLOYEE;
  -- ABS를 붙이는 이유는 앞쪽에는 큰날짜, 뒤에는 작은날짜가 들어가 계산되는데 
  -- 거꾸로 넣었을시에 같은 값을 반환받기 위해 사용
  ```
  + **ADD_MONTHS** : 날짜에 숫자만큼의 **개월 수를 더해** 날짜 리턴
  >
  ```SQL
  SELECT ADD_MONTHS(SYSDATE, 5)
  FROM DUAL;
  -- RESULT : 20/07/06

  SELECT ADD_MONTHS(SYSDATE, 15) -- 
  FROM DUAL;
  -- RESULT : 21/05/06 ==> 개월 수가 넘어가면 년도가 자동으로 넘어감.
  ```
+ #### NEXT_DAY/LAST_DAY
  + **NEXT_DAY** : 기준 날짜에서 **구하려는 요일**에 **가장 가까운 날짜**를 리턴
  >
  ```SQL
  -- 일 월 화 수 목 금 토 
  -- 1  2  3  4  5  6  7
  
  SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/13 ==> 목요일 날짜를 가져온다. 현재가 목요일이면 다음주 목요일의 날짜를 가져옴.
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/09 ==> 주를 기준으로 찾기때문에 1은 일요일을 의미

  SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/13
  SELECT SYSDATE, NEXT_DAY(SYSDATE, '화진씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/11 ==> 안에서 아무리 길게 써도 앞에 글자만 가져와서 비교한다. 화요일 날짜가 나온다.
  SELECT SYSDATE, NEXT_DAY(SYSDATE, '연화씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL;
  -- RESULT : ERRER ==> not a valid day of the week : 유효하지 않는 요일
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
  -- RESULT : ERRER ==> not a valid day of the week : 유효하지 않는 요일
                        언어 세팅이 한글로 되어있어 에러발생
  
  -- 언어 세팅에 따라서 값이 나올 수 있고 오류가 나올 수가 있다.
  ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
  -- 영어로 바꿈
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/13
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/13
  SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/13 ==> 영어 또한 한글과 같다. 아무리 길어도 앞부분만 가져와 리턴한다.

  ALTER SESSION SET NLS_LANGUAGE = KOREAN;
  ```
  
  + **LAST_DAY** : 해당 월에 마지막 날짜 리턴
  >
  ```SQL
  SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
  -- RESULT : 20/02/06 | 20/02/29 ==> 윤달
  ```
+
  + **EXTRACT** : 날짜에서 년, 월, 일 추출하여 리턴
  >
  ```SQL
  -- SELECT EXTRACT(YEAR FROM 날짜); 
  -- SELECT EXTRACT(MONTH FROM 날짜); 
  -- SELECT EXTRACT(DAY FROM 날짜); 

  -- EMPLOYEE테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 조회
  SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE), EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE)
  FROM EMPLOYEE;
  ```
### 4. 형 변환 함수
+ #### TO_CHAR/TO_DATE/TO_NUMBER
  + **TO_CHAR(숫자[, 포맷])** : **숫자형** 데이터 ==> **문자형** 데이터
  >
  ```SQL
  SELECT TO_CHAR(1234) FROM DUAL;
  -- RESULT : 1234
  SELECT TO_CHAR(1234, '99999') FROM DUAL;
  -- RESULT :  1234 ==> 앞에 빈칸있어요. / 5칸 자리수를 만들어주고 오른쪽 정렬, 빈칸은 공백
  SELECT TO_CHAR(1234, '00000') FROM DUAL;
  -- RESULT : 01234 ==> 5칸 자리수를 만들어주고 오른쪽 정렬, 빈칸은 0
  SELECT TO_CHAR(1234, 'L99999') FROM DUAL; 
  -- RESULT :          ￦1234 ==> L 한글, $ 달러 그냥 써주면 공백이 생김, 없애기 위해서는 FML, FM$을 사용하도록 하자.
  SELECT TO_CHAR(1234, '$99999') FROM DUAL;
  -- RESULT :   $1234 
  SELECT TO_CHAR(1234, 'FML99999') FROM DUAL;
  -- RESULT : ￦1234
  SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL;
  -- RESULT : $1234
  SELECT TO_CHAR(1234, 'FM$99,999') FROM DUAL;
  -- RESULT : $1,234 ==> 구분자 사용가능
  SELECT TO_CHAR(1234, 'FM$00,000') FROM DUAL;
  -- RESULT : $01,234

  SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL;
  -- RESULT :   1.2E+03 ==> 지수로 표현
  SELECT TO_CHAR(1234, '999') FROM DUAL;
  -- RESULT : #### ==> 크기가 작으면 '#'으로 표현 EX. 엑셀에서 칸을 줄이면 #으로 치환되는 것과 동일
  ```
  + **TO_CHAR(날짜[, 포맷])** : **날짜형** 데이터 ==> **문자형** 데이터
  >
  ```SQL
  SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
  -- RESULT : 오전 02:22:59 ==> 앞에 PM, AM은 크게 신경쓰지 않는다. 자동으로 알맞게 나옴
  SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
  -- RESULT : 오전 02:23:52
  SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
  -- RESULT : 2월  목, 2020
  SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;
  -- RESULT : 2020-02-06 목요일 ==> DAY와 DY의 차이 DAY 는 [수]요일, DY는 [수] // 요일이 붙냐 안붙냐 차이
  SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL;
  -- RESULT : 2020-2-6 목요일 ==> FM이 붙으면 앞에 02월이 2월로 변경, FM이 붙은 기준점에서 뒤로 다 FM이 붙은 형식으로 나옴
  SELECT TO_CHAR(SYSDATE, 'YEAR, Q')||'분기' FROM DUAL;
  -- RESULT : TWENTY TWENTY, 1분기 ==> 결과값 TWENTY,TWENTY, 1이 나옴, 1의 값은 분기를 말함(1~4분기)
  SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일" DAY') FROM DUAL;
  -- RESULT : 2020년02월06일 목요일 ==> " " 로 감싸서 만들어준다. 기호는 그냥 들어감. 문자를 넣을려면 감싸주기
  
  
  -- 오늘 날짜 대해
  -- 연도 출력
  SELECT TO_CHAR(SYSDATE,'YYYY'), TO_CHAR(SYSDATE,'YY'), TO_CHAR(SYSDATE,'YEAR') FROM DUAL;
  -- RESULT : 2020 | 20 | TWENTY TWENTY
  
  -- 월 출력
  SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM') FROM DUAL;
  -- RESULT : 02 | 2월 | 2월 | II  ==> 마지막은 로마숫자로나옴
  
  -- 일 출력
  SELECT TO_CHAR(SYSDATE, 'DDD'), -- 연 기준으로 N일째
          TO_CHAR(SYSDATE, 'DD'), -- 달 기준으로 N일째
          TO_CHAR(SYSDATE, 'D'), -- 주 기준으로 N일째
  FROM DUAL;
  -- RESULT : 037 | 06 | 5
  
  -- 분기 출력
  SELECT TO_CHAR(SYSDATE, 'Q'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
  FROM DUAL;
  -- RESULT : 1 | 목요일 | 목
  ```
  
  + **TO_DATE** : **문자/숫자형** 데이트 ==> **날짜형 데이터**
  >
  ```SQL
  SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
  -- RESULT : 10/01/01
  SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL;
  -- RESULT : 10/01/01 ==> 오라클에서는 기본적으로 년도를 표현할때는 2개의 데이터만 표시되게 되어있어서 그렇다.!
  
  -- 2010 01 01 ==> 2010, 1월 
  SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY,MON') FROM DUAL;
  -- RESULT : 2010,1월 ==> 혼합해서 사용가능!!!!
  SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
  FROM DUAL;
  -- RESULT : 04-10월-30 02:30:00 오후 ==> 앞에는 04년 10월 30일이고 뒤에는 14시 30분 00초이며 이것을 포맷한 형식

  -- RR과 YY의 차이 : 둘다 년도를 나타낸다
  SELECT TO_CHAR(TO_DATE('980630','YYMMDD'), 'YYYYMMDD'), -- 무조건 YY두자리에 현재 세기를 맞춰서 적용
          TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD'),
          TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'), -- YY두자리 연도가 50년 이상이면 아래 세기, 50년 미만이면 현재 세기
          TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'YYYYMMDD')
  FROM DUAL;
  -- RESULT : 20980630 | 20140918 | 19980630 | 20140918
  ```
  
  + **TO_NUMBER** : **문자형** 데이터 ==> **숫자형** 데이터
  >
  ```SQL
  SELECT TO_NUMBER('123456789') FROM DUAL;
  -- RESULT : 123456789
  SELECT '123' + '456' FROM DUAL;
  -- RESULT : 123456
  SELECT '123' + '456A' FROM DUAL; -- 
  -- RESULT : ERROR ==> invalid number : 잘못된 번호이다. 안에 문자가 포함 되어있기 때문이다.
                                         오라클에서 자동으로 문자열안에 숫자만 있으면 자동으로 숫자로 바꿔줌
  SELECT '1,000,000' + '550,000' FROM DUAL;
  -- RESULT : ERROR ==> invalid number : 구분자도 문자이다.
  
  -- 위의 문제를 해결해보도록 하자.!!
  SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
  -- RESULT : 1000000 ==> 앞에 숫자가 뒤의 형식과 같으므로 형식에 따라서 구분자가 빠지고 숫자형이 반환된다.
  SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999')
  -- RESULT : 1550000 ==> 구분자가 빠지고 숫자와 숫자가 더해지므로 계산가능
  FROM DUAL;
  ```
### 5. NULL 처리 함수
+ #### NVL/NVL2/NULLIF
  + **NVL(컬럼명, 컬럼 값이 NULL일 때 바꿀 값)** : NULL값을 지정한 값으로 바꿔준다.
  >
  ```SQL
  SELECT EMP_NAME, NVL(BONUS, 0)
  FROM EMPLOYEE;
  -- RESULT : 보너스가 NULL이면 0으로 바뀜
  SELECT EMP_NAME, NVL(DEPT_CODE, '없습니다')
  FROM EMPLOYEE;
  -- RESULT : 부서코드가 NULL이면 '없습니다'로 바뀜
  ```
  + **NVL2(컴럼명, 바꿀 값1, 바꿀 값2)** : 컬럼 값이 NULL이 아니면 바꿀 값1 이고, 컬럼 값이 NULL이면 바꿀 값2'
  >
  ```SQL
  -- EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로, NULL이 아닌 직원은 0.7로 변경하여 조회
  SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
  FROM EMPLOYEE;  
  ```
  + **NULLIF(비교대상1, 비교대상2)** : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
  >
  ```SQL
  SELECT NULLIF(123,123) FROM DUAL;
  -- RESULT : NULL ==> 헷갈리지 않게 조심!!
  SELECT NULLIF(123,124) FROM DUAL;
  `` RESULT : 1 ==> 헷갈리지 않게 조심!!
  ```
  
### 6. 선택 함수
+ #### DECODE/CASE
  + **DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2....)** : 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
  >
  ```SQL
  SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') "성별"  
  FROM EMPLOYEE;

  SELECT EMP_ID, EMP_NAME, EMP_NO,
          DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', '여') "성별"  
  FROM EMPLOYEE;
  -- 마지막 인자로 조건 값 없이 선택 값을 작성하면
  -- 아무것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함
  ```
  
  + **CASE** : 비교하고자 하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환(조건 범위 값 가능)
    + CASE WHEN 조건식 THEN 결과값  
    WHEN 조건식 THEN 결과값  
    ELSE 결과값  
    END
  >
  ```SQL
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
  ```
## 그룹 함수
+ 
  + 하나 이상의 행을 그룹으로 묶어 연산하며 총합, 평균 등을 **하나의 컬럼**으로 반환하는 함수
+ #### SUM/AVG/COUNT/MAX/MIN
  + **SUM** : 해당 컬럼 **값들의 총합** 반환
  >
  ```SQL
    SELECT SUM(SALARY)
  FROM EMPLOYEE;

  -- EMPLOYEE테이블에서 남자 사원의 급여 총 조회
  SELECT SUM(SALARY)
  FROM EMPLOYEE
  WHERE SUBSTR(EMP_NO,8,1) = 1;
  ```
  + **AVG** : 해당 컬럼 **값들의 평균** 반환
  >
  ```SQL
  -- EMPLOYEE테이블에서 전 사원의 급여 평균 조회
  SELECT AVG(SALARY)
  FROM EMPLOYEE;

  -- EMPLOYEE테이블에서 전 사원의 BONUS 합계 조회
  SELECT SUM(BONUS)
  FROM EMPLOYEE;

  -- EMPLOYEE테이블에서 전 사원의 BONUS 평균 조회
  SELECT AVG(BONUS), AVG(NVL(BONUS,0))
  FROM EMPLOYEE;
  -- NULL값을 가진 행은 평균 계산에서 제외 되어 계산, 그러므로 NVL로 치환해서 계산해주자!!
  ```
  + **COUNT** : 테이블 조건을 만족하는 **행의 개수** 반환
    + COUNT(* | 컬럼명) : 행의 개수 리턴
    + COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 개수 리턴
    + COUNT(*) : NULL을 포함한 전체 행 개수 리턴
    + COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
    >
  ```SQL
  SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
  FROM EMPLOYEE;
  ```
  + **MAX** : 그룹의 **최대값** 반환
  >
  ```SQL
  -- EMPLOYEE테이블에서 가장 많은 급여, 알파벳 순서가 가장 마지막인 이메일, 가장 느린 입사일
  SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
  FROM EMPLOYEE;
  ```
  + **MIN** : 그룹의 **최소값** 반환
  >
  ```SQL
  -- EMPLOYEE테이블에서 가장 작은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일
  SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
  FROM EMPLOYEE;
  ```
  
