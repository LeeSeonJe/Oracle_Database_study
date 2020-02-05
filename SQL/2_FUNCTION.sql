-- �Լ�(FUNCTION) : �÷��� ���� �о ����� ��� ����
-- ���� �� �Լ� (SINGLE ROW FUNCTION)
--      N���� ���� �־ N���� ��� ����
--SELECT LENGTH(EMP_NAME)
--FROM EMPLOYEE;
-- �׷� �Լ�(GROUP FUNCTION)
--      N���� ���� �־ �� ���� ��� ����
--SELECT COUNT(EMP_NAME)
--FROM EMPLOYEE;
-- ���� �� �Լ��� �׷� �Լ��� ���� �� ��� ��� �� ������ �ٸ��� ������ ������ �߻�!
--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM EMPLOYEE;

-- ���� �� �Լ�
-- 1. ���� ���� �Լ�

-- LENGTH / LENGTHB
-- LENGTH(�÷��� | '���ڿ�') : ���� �� ��ȯ
-- LENGTHB(�÷��� | '���ڿ�') : ������ ����Ʈ ũ�� ��ȯ
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ') -- ����Ŭ���� �ѱ��� 3BYTE�� ������.
FROM DUAL; -- �������̺�

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ���� ù��° ��ġ (����Ŭ�� ZERO INDEX ����� �ƴϴ�.)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; -- ù��°���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; -- ������ �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'C', -1) FROM DUAL; -- ������ �б� �����ؼ� ó������ ������ C�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', 1, 2) FROM DUAL; -- ù��°���� �б� �����ؼ� �ι�°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; -- ������ �б� �����ؼ� �ι�°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'C', 1, 2) FROM DUAL;

-- EMPLOYEE���̺��� �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@') FROM EMPLOYEE;

-- LPAD / RPAD : �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ����/�����ʿ� ���ٿ� ���� N�� ���ڿ� ��ȯ
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT LPAD(EMAIL, 20, '#')
FROM EMPLOYEE; 

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- LTRIM/RTRIM/TRIM : �־��� �÷��̳� ���ڿ��� ���� �Ǵ� ������ �Ǵ� ��/��/���ʿ��� ������ ���� ����
SELECT LTRIM('   KH') FROM DUAL; -- ������ ���ڿ��� �������� �ʾ��� ��� ������ DEFAUL�� ��
SELECT LTRIM('   KH', ' ') FROM DUAL;
SELECT LTRIM('000123456', '0') FROM DUAL;
SELECT LTRIM('123123KH', '123') FROM DUAL;
SELECT LTRIM('123123KH123', '123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5781KH' , '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL; -- DFAULT : ����
SELECT RTRIM('123456000', '0') FROM DUAL;
SELECT RTRIM('KHACABACC', 'ABC') FROM DUAL;

SELECT TRIM('   KH   ') FROM DUAL; -- DFAULT : ����
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
SELECT TRIM('1' FROM '123132KH123321') FROM DUAL; -- �� ���ڸ� ���� ����
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- ��
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZZ') FROM DUAL; -- ����

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ���� ���� ������ ���ڿ��� �߶� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL; -- �������� ���������� ������ ������ �д´�.
SELECT SUBSTR('SHOWMETHEMONEY', 5, 2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5, 0) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1, 6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8, 3) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -10, 2) FROM DUAL;

-- EMPLOYEE���̺��� �̸�, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME, SUBSTR(EMAIL, 0, INSTR(EMAIL, '@')-1)
FROM EMPLOYEE;

-- �ֹε�Ϲ�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1) "���ڸ�"
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� ��� ��, ����, ����, ���� ��ȸ
-- 940520
SELECT EMP_NAME, '19'||SUBSTR(EMP_NO, 1,2)||'��' "����", SUBSTR(EMP_NO ,3,2)||'��' "��", SUBSTR(EMP_NO,5,2)||'��' "��"
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL;
SELECT UPPER('Welcome To My World') FROM DUAL;
SELECT INITCAP('welcome to my world') FROM DUAL;

-- CONCAT
SELECT CONCAT('�����ٶ�', 'ABCE') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- REPLACE
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;
SELECT REPLACE('����ȣ �л��� ������ �����ϱ��?', '����', '����') FROM DUAL;

-- EMPLOYEE���̺��� �̸����� �������� gmail.com���� �����ϱ�
SELECT REPLACE(EMAIL, SUBSTR(EMAIL,INSTR(EMAIL, '@')+1), 'google.com') "�̸���"
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ��� ��, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� �������-���� ������ ���̰��ϰ� ������ ����'*'�� �ٲٱ�
-- EX. 940520-1******
SELECT EMP_NAME "�̸�", CONCAT(SUBSTR(EMP_NO, 1, 8),'******') "�ֹι�ȣ"
FROM EMPLOYEE;

SELECT EMP_NAME "�̸�", RPAD(SUBSTR(EMP_NO, 1, 8),14,'*')
FROM EMPLOYEE;

SELECT EMP_NAME "�̸�", REPLACE(EMP_NO, SUBSTR(EMP_NO, 9),'******')
FROM EMPLOYEE;

-- 2. ���� ���� �Լ�

-- ABS : ���� ���� �������ִ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : ������ 
SELECT MOD(10,3) FROM DUAL; --1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- �ڿ� �������ִ� �ǿ����ڴ� ��ȣ�� ������ ���� �ʴ´�.
SELECT MOD(10.9,3) FROM DUAL; -- 1.9
SELECT MOD(-10.9,3) FROM DUAL; -- -1.9

-- ROUND : �ݿø� (ROUND �Լ��� ZERO��� INDEX�� ǥ��)
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.678, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;
SELECT ROUND(123.456, 2) FROM DUAL;
SELECT ROUND(123.456, -2) FROM DUAL;

-- ����
SELECT ROUND(-10.61) FROM DUAL; -- -11

-- FLOOOR : ����
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.678) FROM DUAL;

-- TRUNC : ����(����)
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.678) FROM DUAL;
SELECT TRUNC(123.678, 1) FROM DUAL;
SELECT TRUNC(123.678, -1) FROM DUAL;

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL;
SELECT CEIL(123.678) FROM DUAL;

-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥ ��ȯ

-- MONTHS_ BETWEEN : ��¥�� ��¥ ������ ���� �� ���̸� ���ڷ� �����ϴ� �Լ�
-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME, HIRE_DATE, ABS(FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)))
FROM EMPLOYEE;

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ�� ���� ���� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5)
FROM DUAL;

SELECT ADD_MONTHS(SYSDATE, 15) -- ���� ���� �Ѿ�� �⵵�� �ڵ����� �Ѿ.
FROM DUAL;

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ����� ��¥�� �����ϴ� �Լ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- �� �� ȭ  �� �� ��  �� 
-- 1  2  3  4  5  6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ������ ���� ���� ������ �ϰ� ������?') FROM DUAL; -- ȭ���� ��¥�� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��ȭ���� ���� ���� ������ �ϰ� ������?') FROM DUAL; -- �ƹ��� �� ù���ڸ� �ľ�
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;

-- ��� ���ÿ� ���� ���� ���� �� �ְ� ������ ���� ���� �ִ�.
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- LAST_DAY : �ش� ���� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;

-- EXTRACT : ��¥���� ��, ��, �� �����Ͽ� ����
-- SELECT EXTRACT(YEAR FROM ��¥); 
-- SELECT EXTRACT(MONTH FROM ��¥); 
-- SELECT EXTRACT(DAY FROM ��¥); 

-- EMPLOYEE���̺��� ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE)||, EXTRACT(MONTH FROM HIRE_DATE), EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- 4. �� ��ȯ �Լ�
-- TO_CHAR(��¥[, ����]) : ��¥�� ������ ==> ������ ������
-- TO_CHAR(����[, ����]) : ������ ������ ==> ������ ������
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ �ڸ����� ������ְ� ������ ����, ��ĭ�� ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 5ĭ �ڸ����� ������ְ� ������ ����, ��ĭ�� 0
SELECT TO_CHAR(1234, 'L99999') FROM DUAL; -- L �ѱ�, $ �޷� �׳� ���ָ� ������ ����, ���ֱ� ���ؼ��� FML, FM$�� ����ϵ��� ����.
SELECT TO_CHAR(1234, '$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FML99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$99,999') FROM DUAL;
SELECT TO_CHAR(1234, 'FM$00,000') FROM DUAL;

SELECT TO_CHAR(1234, '9.9EEEE') FROM DUAL; -- ������ ǥ��
SELECT TO_CHAR(1234, '999') FROM DUAL; -- ũ�Ⱑ ������ '#'���� ǥ�� EX. �������� ĭ�� ���̸� #���� ġȯ�Ǵ� �Ͱ� ����

SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- �տ� PM, AM�� ũ�� �Ű澲�� �ʴ´�. �ڵ����� �˸°� ����
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- DAY�� DY�� ���� DAY �� [��]����, DY�� [��] // ������ �ٳ� �Ⱥٳ� ����
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- FM�� ������ �տ� 02���� 2���� ����, FM�� ���� ���������� �ڷ� �� FM�� ���� �������� ����
SELECT TO_CHAR(SYSDATE, 'YEAR, Q')||'�б�' FROM DUAL; -- ����� TWENTY,TWENTY, 1�� ����, 1�� ���� �б⸦ ����(1~4�б�)
SELECT TO_CHAR(SYSDATE, 'YYYY"��"MM"��"DD"��" DAY') FROM DUAL; -- " " �� ���μ� ������ش�. ��ȣ�� �׳� ��. ���ڸ� �������� �����ֱ�


-- ���� ��¥ ����
-- ���� ���
SELECT TO_CHAR(SYSDATE,'YYYY'), TO_CHAR(SYSDATE,'YY'), TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'DDD'), -- �� �������� N��°
        TO_CHAR(SYSDATE, 'DD'), -- �� �������� N��°
        TO_CHAR(SYSDATE, 'D'), -- �� �������� N��°
        TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- �б�, ���� ���
SELECT TO_CHAR(SYSDATE, 'Q'),
        TO_CHAR(SYSDATE, 'DAY'),
        TO_CHAR(SYSDATE, 'DY')
FROM DUAL;

-- TO_DATE : ����/������ ����Ʈ ==> ��¥�� ������
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101, 'YYYYMMDD') FROM DUAL; -- ����Ŭ������ �⺻������ �⵵�� ǥ���Ҷ��� 2���� �����͸� ǥ�õǰ� �Ǿ��־ �׷���.!

-- 2010 01 01 ==> 2010, 1�� 
SELECT TO_CHAR(TO_DATE(20100101, 'YYYYMMDD'), 'YYYY,MON') FROM DUAL; -- ȥ���ؼ� ��밡��!!!!

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM')
FROM DUAL;

-- RR�� YY�� ���� : �Ѵ� �⵵�� ��Ÿ����
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'), 'YYYYMMDD'), -- ������ YY���ڸ��� ���� ���⸦ ���缭 ����
        TO_CHAR(TO_DATE('140918', 'YYMMDD'), 'YYYYMMDD'),
        TO_CHAR(TO_DATE('980630', 'RRMMDD'), 'YYYYMMDD'), -- YY���ڸ� ������ 50�� �̻��̸� �Ʒ� ����, 50�� �̸��̸� ���� ����
        TO_CHAR(TO_DATE('140918', 'RRMMDD'), 'YYYYMMDD')
FROM DUAL;

-- TO_NUMBER : ������ ������ ==> ������ ������
SELECT TO_NUMBER('123456789') FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL; -- ����Ŭ���� �ڵ����� ���ڿ��ȿ� ���ڸ� ������ �ڵ����� ���ڷ� �ٲ���
SELECT '1,000,000' + '550,000' FROM DUAL;

SELECT TO_NUMBER('1,000,000', '99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000', '99,999,999') + TO_NUMBER('550,000', '999,999')
FROM DUAL;

-- 5. NULL ó�� �Լ�
-- NVL(�÷���, �÷� ���� NULL�� �� �ٲ� ��)
-- NVL2(�ķ���, �ٲ� ��1, �ٲ� ��2) -- �÷� ���� NULL�� �ƴϸ� �ٲ� ��1 �̰�, �÷� ���� NULL�̸� �ٲ� ��2

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, '�����ϴ�')
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���ʽ��� NULL�� ������ 0.5��, NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT EMP_NAME, NVL2(BONUS, 0.7, 0.5)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� �����ϸ� NULL, �������� ������ �񱳴��1 ����
SELECT NULLIF(123,123) FROM DUAL;
SELECT NULLIF(123,124) FROM DUAL;


-- 6. �����Լ� : ���� ���� ��� ������ �� �ִ� ��� ����
-- DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2....)
-- ���ϰ����ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', 2, '��') "����"  
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, EMP_NO,
        DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') "����"  
FROM EMPLOYEE;
-- ������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ�
-- �ƹ��͵� �ش���� ���� �� �������� �ۼ��� ���ð��� ������ ������

-- CASE WHEN ���ǽ� THEN �����
--      WHEN ���ǽ� THEN �����
--      ELSE �����
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ(������ ��������)

SELECT EMP_ID, EMP_NAME, EMP_NO,
        CASE WHEN SUBSTR(EMP_NO, 8, 1) = 1 THEN '��'
             ELSE '��'
        END ����
FROM EMPLOYEE;

-- �޿��� 500�� �ʰ� 1���, 350�� �ʰ� 2���, 200�� �ʰ� 3���, ������ 4���
SELECT EMP_ID, EMP_NAME, SALARY,
        CASE WHEN SALARY>5000000 THEN '1'
             WHEN SALARY>3500000 THEN '2'
             WHEN SALARY>2000000 THEN '3'
        ELSE '4'
        END ||'���' "VIP���"
FROM EMPLOYEE;


-- �׷��Լ� : ���� ���� ������ �� ���� ��� ��ȯ
-- SUM(���ڰ� ��ϵ� �÷�) : �հ� ����
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ����� �޿� �� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- AVG(���ڰ� ��ϵ� �÷�) : ��� ����
-- EMPLOYEE���̺��� �� ����� �޿� ��� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �� ����� BONUS �հ� ��ȸ
SELECT SUM(BONUS)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� �� ����� BONUS ��� ��ȸ
SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
-- NULL���� ���� ���� ��� ��꿡�� ���� �Ǿ� ���

-- MIN / MAX : �ִ� / �ּ�
-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի���
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� �������� �̸���, ���� ���� �Ի���
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | �÷���) : ���� ���� ����
-- COUNT(DISTINCT �÷���) : �ߺ��� ������ �� ���� ����
-- COUNT(*) : NULL�� ������ ��ü �� ���� ����
-- COUNT(�÷���) : NULL�� ������ ��ü �� ���� ����
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;