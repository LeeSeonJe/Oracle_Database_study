# SYNONYM
+
  + 사용자가 다른 사용자의 객체를 참조할 때 [사용자ID].[테이블명]으로 표시
  + 동의어(SYNONYM) : 다른 DB가 가진 객체에 대한 별명 혹은 줄임말
  + 동의어를 사용하여 간단하게 접근할 수 있도록 함
+
  + 권한을 먼저 주어야 한다.
  >
  ```SQL
  GRANT CREATE SYNONYM TO KH;
  ```
### 공개 동의어 / 비공개 동의어
  >
+ **공개 동의어**
  + 모든 권한을 주는 사용자(DBA)가 정의 한 동의어
  + 모든 사용자가 사용할 수 있음 (PUBLIC)
  >
  ```SQL
  CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;
  DROP PUBLIC SYNONYM DEPT;
  -- DROP 시에는 공개 동의어인지 비공개 동의어인지 확인하여 삭제해줄 것.
  ```
+ **비공개 동의어**
  + 객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용 가능
  >
  ```SQL
  CREATE SYNONYM EMP FOR EMPLOYEE;
  DROP SYNONYM EMP;
  ```
