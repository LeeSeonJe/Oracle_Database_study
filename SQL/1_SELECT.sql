-- 2020/02/03

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

-- EMPLOYEE���̺��� �̸�, �����, �ٹ��ϼ�(���ó�¥ - �����) ��ȸ
SELECT EMP_NAME AS "�̸�", HIRE_DATE AS "�����", SYSDATE-HIRE_DATE "�ٹ��ϼ�"
FROM EMPLOYEE;

-- 2020/02/04
-- ���ͷ� : ���Ƿ� ���� ���ڿ��� SELECT���� ����ϸ� ���̺� �����ϴ� ������ó�� ��� ����
-- ���ڳ� ��¥ ���ͷ��� ' ' ��ȣ ���Ǹ� ��� �࿡ �ݺ� ǥ�� ��

-- EMPLOYEE���̺��� ������ ���� ��ȣ, ��� ��, �޿�, ����(������ �� : ��) ��ȸ
SELECT EMP_ID "������ȣ", EMP_NAME "�����", SALARY "�޿�",'��' "����"
FROM EMPLOYEE;

-- DISTINCT : �÷��� ���Ե� �ߺ� ���� �� ������ ǥ���ϰ��� �� �� ���, SELECT���� �� �� ���� �� �� �ְ� �� �տ� ����Ѵ�.
-- EMPLOYEE���̺��� ������ ���� �ڵ� ��ȸ
SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ������ �����ڵ带 �ߺ����� �Ͽ� ��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �μ��ڵ�� �����ڵ带 �ߺ����� �Ͽ� ��ȸ
-- SELECT DISTINCT DEPT_CODE, DISTINCT JOB_CODE
-- FROM EMPLOYEE;

 SELECT DISTINCT DEPT_CODE, JOB_CODE
 FROM EMPLOYEE;
 
-- WHERE�� : SELECT�� �ɸ��� ���ǹ��� ���� ��
-- ��ȸ�� �޺��� ������ �´� ���� ���� ���� ���
-- �� ������
-- = ����, >ũ��, < �۳�, >= ũ�ų� ����, <= �۰ų� ����
-- !=, ^=, <> �� ����

--EMPLOYEE���̺��� �μ��ڵ尡 'D9'�� ������ �̸�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE���̺��� �޿��� 4000000 �̻��� ������ �̸�, �޿� ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE���̺��� �μ��ڵ尡 D9�� �ƴ� ����� ���, �̸�, �μ��ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';
--WHERE DEPT_CODE ^= 'D9';
--WHERE DEPT_CODE <> 'D9';

-- EMPLOYEE���̺��� ��� ���ΰ� N�� ������ ��ȸ�ϰ�
-- �ٹ� ���θ� ���������� ǥ���Ͽ� ���, �̸�, �����, �ٹ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, '������' "�ٹ�����"
FROM EMPLOYEE
WHERE ENT_YN = 'N';

-- �̴� �ǽ� ����
-- 1. EMPLOYEE ���̺��� ������ 3000000�̻��� ����� �̸�, ����, ����� ��ȸ
SELECT EMP_NAME "�̸�", SALARY "����", HIRE_DATE "�����"
FROM EMPLOYEE
WHERE SALARY >= 3000000;


-- 2. EMPLOYEE ���̺��� SAL_LEVEL�� S1�� ����� �̸�, ����, �����, ����ó ��ȸ
SELECT EMP_NAME "�̸�", SALARY "����", HIRE_DATE "�����", PHONE "����ó"
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S1';

-- 3. EMPLOYEE ���̺��� �Ǽ��ɾ�(�Ѽ��ɾ� - (���� * ����3%))�� 5õ���� �̻��� ����� �̸�, ����, �Ǽ��ɾ�, ����� ��ȸ
SELECT EMP_NAME "�̸�", SALARY "����", (SALARY * (1 + BONUS)) * 12 - (SALARY * 12 * 0.03) "�Ǽ��ɾ�" ,HIRE_DATE "�����"
FROM EMPLOYEE
WHERE (SALARY * (1 + BONUS)) * 12 - (SALARY * 12 * 0.03) >=50000000;

-- �� ������ : AND / OR / NOT
-- EMPLOYEE���̺��� �μ��ڵ尡 'D6'�̰� �޿��� �̹鸸���� ���� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY >2000000;

-- EMPLOYEE���̺��� �μ��ڵ尡 'D6' �̰ų� �޿��� �̹鸸���� ���� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >2000000;

-- EMPLOYEE���̺��� �޿��� 350���� �̻� 600���� ���ϸ� �޴� ������ ���, �̸�, �޿�, �μ��ڵ�, ���� �ڵ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- EMPLOYEE���̺��� �μ��ڵ尡 'D6' �� �ƴ� ������ �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE NOT DEPT_CODE = 'D6';

-- �̴� �ǽ� ����
-- EMPLOYEE���̺� ���� 4000000�̻��̰� JOB_CODE�� J2�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 4000000 AND JOB_CODE = 'J2';

-- EMPLOYEE���̺� DEPT_CODE�� D9�̰ų� D5�� ��� �� ������� 02�� 1�� 1�� ���� ���� ����� �̸�, �μ��ڵ�, ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D9' OR DEPT_CODE = 'D5') AND HIRE_DATE < '02/01/01'; -- ��ȣ�� �߿伺! AND�� OR���� �켱�����̱� ������ ������ �� �����ϰ� ��ȣ�� ���ֵ�������!

-- BETWEEN AND : ���� �� �̻� ���� �� ����
-- �÷��� BETWEEN ���� �� AND ���� ��
-- ���� �� <= �÷� �� <= ���� ��

-- �޿��� 3500000�� ���� ���� �ް� 6000000���� ���� �޴� ����� �̸�, �޿� ��ȸ
-- 1) BETWEEN AND �� ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY <= 6000000;

-- 2) BETWEEN AND ����
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

-- �ݴ�� �޿��� 350���� �̸�, �Ǵ� 600������ �ʰ��ϴ� ������ ���, �̸�, �޿�, �μ��ڵ�, �����ڵ� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3500000 AND 6000000;

SELECT EMP_NAME, SALARY, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE NOT SALARY BETWEEN 3500000 AND 6000000;

-- �̴� �ǽ� ����
-- EMPLOYEE���̺� ������� '90/01/01' ~ '01/01/01'�� ����� ��ü ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/01/01';

-- LIKE
-- ���Ϸ��� ���� ������ Ư�� ������ ���� ��Ű���� ��ȸ
-- % : 0���� �̻�
-- _ : 1����
-- '����%' : ���ڷ� �����ϴ� ��
-- '%����%' : ���ڰ� ���Ե� ��
-- '%����' : ���ڷ� ������ �� 
-- '_' : �� ����
-- '__' : �� ����
-- '��__' : ������ �����ϴ� ������

-- EMPLOYEE���̺��� ���� ������ ����� ���, �̸�, ����� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';
--WHERE EMP_NAME LIKE '��__'; // �̸��� 2���� 3���ڰ� �Ѿ�� ������� ����

-- EMPLOYEE���̺��� �̸��� '��'�� ���Ե� ������ �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

-- EMPLOYEE���̺��� ��ȭ��ȣ 4��° �ڸ��� 9�� �����ϴ� ����� ���, �̸�, ��ȭ��ȣ ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

-- �̸��� �� _ �ձ��ڰ� 3�ڸ��� �̸��� �ּҸ� ���� ����� ���, �̸�, �̸��� �ּ� ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- ���ϵ�ī���� _�� �˻��ϰ��� �ϴ� ���� �ȿ� ���� ���ڿ� ���� ������
-- ���� ��ü�� �ƴ� ���ϵ� ī��� �ν�

-- ESCAFE OPTION
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___\_%' ESCAPE '\';

-- NOT NULL : Ư�� ������ ������Ű�� �ʴ� �� ��ȸ
-- EMPLOYEE���̺���


-- �̴� �ǽ� ����
-- 1. EMPLOYEE���̺��� �̸� ���� '��' ���� ������ ����� �̸� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��';
-- 2. EMPLOYEE���̺��� ��ȭ��ȣ ó�� 3�ڸ��� 010�� �ƴ� ����� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
-- 3. EMPLOYEE���̺��� �����ּ� '_'�� ���� 4�� �̸鼭 DEPT_CODE�� D9 �Ǵ� D6�̰�
--      ������� 90/01/01 ~ 00/12/01�̰�, �޿��� 270�� �̻��� ����� ��ü�� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE EMAIL LIKE '____\_%' ESCAPE '\'
AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '90/01/01' AND '00/12/01'
AND SALARY >= 2700000;

-- IS NULL / IS NOT NULL
-- IS NULL : �÷� ���� NULL�� ���
-- IS NOT NULL : �÷� ���� NULL�� �ƴ� ���

-- EMPLOYEE���̺��� ���ʽ��� ���� �ʴ� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

-- EMPLOYEE���̺��� ���ʽ��� �޴� ����� ���, �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE NOT BONUS IS NULL;

-- EMPLOYEE���̺��� �����ڵ� ���� �μ���ġ�� ���� ���� ������ �̸�, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

-- EMPLOYEE���̺��� �μ� ��ġ�� ���� �ʾ����� ���ʽ��� �޴� ������ �̸�, ���ʽ�, �μ��ڵ� ��ȸ
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-- IN 
-- ���Ϸ��� �� ��Ͽ� �����ϴ� ���� ������ TRUE�� ��ȯ�ϴ� ������
-- EMPLOYEE���̺��� �μ�Ŀ���� D6�̰ų� D9�� ����� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' OR DEPT_CODE = 'D6';

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6', 'D9');

-- ���� �ڵ尡 J1, J2, J3, J4�� ������� �̸�, ���� �ڵ�, �޿�
-- 1) IN �̻��
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE = 'J1'
OR JOB_CODE = 'J2'
OR JOB_CODE = 'J3'
OR JOB_CODE = 'J4';

-- 2) IN ���
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE IN ('J1', 'J2', 'J3', 'J4');

-- ���� ������ || (JAVA���� OR�� �Ȱ��� ����) : ���� �÷��� �����ϰų� �÷��� ���ͷ��� ����
-- EMPLOYEEE���̺��� ���, �̸�, �޿��� �����Ͽ� ��ȸ
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

-- EMPLOYEE���̺��� '��� ���� ������ �޿����Դϴ�.' �������� ��ȸ
SELECT EMP_NAME || '�� ������ ' || SALARY || '���Դϴ�'
FROM EMPLOYEE;

