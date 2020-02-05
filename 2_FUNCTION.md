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
+ #### INSTR
  + **INSTR** : 해당 문자열의 문자 첫번째 위치 **(오라클은 ZERO INDEX 기반이 아니다.)**
  >
  ```SQL
  SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
  SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

  SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; 
  -- 첫번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; 
  -- 끝부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; 
  -- 끝부터 읽기 시작해서 처음으로 나오는 C의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; 
  -- 첫번째부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; 
  -- 끝에서 읽기 시작해서 두번째로 나오는 B의 위치 반환
  SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;
  -- 첫번째부터 읽기 시작해서 두번째로 나오는 C의 위치 반환

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
  + **RTRIM** : 주어진 컬럼이나 문자열의 **오른쪽**에서 **지정한 문자**가 **제거**
  + **TRIM** : 주어진 컬럼이나 문자열의 **앞/뒤/양쪽**에서 **지정한 문자**가 **제거**
  
+ #### SUBSTR
  + **SUBSTR** : 컬럼이나 문자열에서 **지정한 위치**부터 **지정 개수**의 **문자열**을 잘라내 **반환**

+ #### LOWER/UPPER/INITCAP
  + **LOWER** : 컬럼의 문자 혹은 문자열을 **소문자**로 변환하여 반환
  + **UPPER** : 컬럼의 문자 혹은 문자열을 **대문자**로 변환하여 반환
  + **INITCAP** : 컬럼의 문자 혹은 문자열을 **첫 글자만 대문자**로 변환하여 반환
  
+ #### CONCAT
  + **CONCAT** : 컬럼의 문자 혹은 문자열을 **두 개** 전달 받아 **하나로 합친** 후 반환
  

### 2. 숫자 처리 함수
### 3. 날짜 관련 함수
### 4. 형 변환 함수
### 5. NULL 처리 함수
### 6. 선택 함수
  
## 그룹 함수
+ 
  + 하나 이상의 행을 그룹으로 묶어 연산하며 총합, 평균 등을 **하나의 컬럼**으로 반환하는 함수
+ #### SUM/AVG/COUNT/MAX/MIN
  + **SUM** : 해당 컬럼 **값들의 총합** 반환
  + **AVG** : 해당 컬럼 **값들의 평균** 반환
  + **COUNT** : 테이블 조건을 만족하는 **행의 개수** 반환
  + **MAX** : 그룹의 **최대값** 반환
  + **MIN** : 그룹의 **최소값** 반환
  
