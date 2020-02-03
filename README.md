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
      직원 전부의 모든 정보를 조회하는 구문
      SELECT * FROM EMPLOYEE
      
      컬럼 값에 대해 산술 연산한 결과 조회 
      SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) * 12
      FROM EMPLOYEE;
    ```
