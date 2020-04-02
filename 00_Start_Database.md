## Database 시작하기
+
  + 관리자 계정
    + 데이터베이스의 생성과 관리를 담당하는 슈퍼 유저 계정  
    오브젝트의 생성, 변경, 삭제 등의 작업이 가능하며  
    데이터베이스에 대한 모든권한과 책임을 가지는 계정
  + 사용자 계정
    + 데이터베이스에 대하여 질의(Query), 갱신, 보고서를 작성 등의 작업을 수행할 수 있는 계정  
    일반 계정은 보안을 위해 최소한의 필요한 권한만 가지는 것을 원칙으로 함
    
  ```SQL
    CREATE USER KH IDENTIFIED BY KH;
    -- 계정이름         비밀번호
       
    GRANT RESOURCE, CONNECT TO KH;
    -- 계정에 권한을 부여하는 
  ```
>
## 데이터베이스 용어
+ 행, 튜플
  + 테이블에는 기본적으로 **기본키**의 역할을 하는 컬럼이 필요하다. 
  + 각 행(튜플)을 구분할 수 있는 **구분자**이다. OR **고유값**
  + 무조건 테이블에는 한 개이상의 **기본키**가 존재해야한다.
+ 컬럼, 도메인
+ 외래키(Foreign Key)
  + 한 테이블의 기본키, 일반컬럼이 다른 테이블의 컬럼 안으로 들어가면 그 컬럼은 **외래키**가 된다.
>
## SQL
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
