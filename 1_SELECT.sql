--SELECT * FROM EMPLOYEE;
--WHERE EMP_ID = 200;

-- SELECT
-- Result Set : SELECT �������� �����͸� ��ȸ�� �����, ��ȯ�� ����� ����(0�� �̻�)

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT EMP_ID , EMP_NAME , EMP_NO , EMAIL , PHONE , DEPT_CODE , JOB_CODE , SAL_LEVEL , SALARY , BONUS , MANAGER_ID , HIRE_DATE , ENT_DATE , ENT_YN  
FROM EMPLOYEE;

SELECT *
FROM EMPLOYEE;

-- �̴� �ǽ� ����
-- 1. JOB���̺��� ��� ���� ��ȸ
SELECT JOB_CODE, JOB_NAME  
FROM JOB;

-- 2. JOB���̺��� ���� �̸� ��ȸ
SELECT JOB_NAME 
FROM JOB;

-- 3. DEPARTMENT���̺��� ��� ���� ��ȸ
SELECT DEPT_ID, DEPT_TITLE, LOCATION_ID 
FROM DEPARTMENT;

-- 4. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, ����� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 5. EMPLOYEE���̺��� �����, ��� �̸�, ������ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-- �÷� �� ��� ����
-- SELECT �� �÷� �� �Է� �κп� ��꿡 �ʿ��� �÷� ��, ����, �����ڸ� �̿��ؼ� ��� ��ȸ ����

-- EMPLOYEE���̺� ���� ��, ���� ��ȸ (���� = �޿� * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ������ ���� ��, ����, ���ʽ��� �߰��� ���� ��ȸ
SELECT EMP_NAME, SALARY * 12, (SALARY + (SALARY*BONUS)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, SALARY * 12, (SALARY * (1 + BONUS)) * 12
FROM EMPLOYEE;

--SELECT *,SALARY*12 // *(�ƽ�Ʈ��)�� ȥ�� ����ؾ� �Ѵ�
--FROM EMPLOYEE;

-- 1. EMPLOYEE ���̺��� �̸�, ����, �Ѽ��ɾ�(���ʽ�����), �Ǽ��ɾ�(�Ѽ��ɾ� - (����*���� 3%)) ��ȸ
SELECT EMP_NAME, SALARY * 12 ����, (SALARY * (1 + BONUS)) * 12 �Ѽ��ɾ�, ((SALARY * (1 + BONUS)) * 12 - (SALARY * 12 * 0.03)) �Ǽ��ɾ�
FROM EMPLOYEE;

-- 2. EMPLOYEE ���̺��� �̸�, �����, �ٹ��ϼ�(�������� - �����) ��ȸ
-- SELECT SYSDATE -- ���� ��¥ ���
-- FROM DUAL; -- ���� ���̺�
SELECT EMP_NAME, HIRE_DATE, FLOOR(SYSDATE - HIRE_DATE) �ٹ��ϼ�
FROM EMPLOYEE;

-- �ݿø�, �ø�, ����, ���� ����ϱ�
SELECT SYSDATE - HIRE_DATE �ٹ��ϼ�, ROUND(SYSDATE-HIRE_DATE) �ݿø�, CEIL(SYSDATE-HIRE_DATE) �ø�,
        FLOOR(SYSDATE - HIRE_DATE) ����, TRUNC(SYSDATE - HIRE_DATE) ����
FROM EMPLOYEE;

-- �÷� ��¡
-- �÷��� AS ��Ī
-- �÷��� "��Ī" // ��Ī�� ����, Ư������, ���ڰ� ���Ե� ��� ������ ""���� ���´�.
-- �÷��� AS "��Ī" 
-- �÷��� ��Ī

-- EMPLOYEE���̺��� ������ ������(��Ī : �̸�), ����(��Ī : ����(��)), ���ʽ��� �߰��� ����(��Ī : �Ѽҵ�(��)) ��ȸ
SELECT EMP_NAME �̸�, SALARY * 12 "����(��)", (SALARY * (1+BONUS))*12 AS "�Ѽҵ�(��)"
FROM EMPLOYEE;