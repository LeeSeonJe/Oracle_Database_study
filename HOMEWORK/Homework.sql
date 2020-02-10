-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �Ի� �� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME "�̸�", HIRE_DATE "�Ի���", ADD_MONTHS(HIRE_DATE,6) "�Ի� �� 6����"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� �����, �Ի���-����, ����-�Ի��� ��ȸ
-- ��, ��Ī�� �ٹ��ϼ�1, �ٹ��ϼ�2�� �ϰ�
-- ��� ����ó��(����), ����� �ǵ��� ó��
SELECT EMP_NAME "�����", 
       ABS(FLOOR(HIRE_DATE - SYSDATE)) "�Ի���-����", 
       FLOOR(SYSDATE - HIRE_DATE) "����-�Ի���"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� ����� Ȧ���� �������� ���� ��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MOD(EMP_ID,2) = 1;


-- EMPLOYEE ���̺��� �ٹ� ����� 20�� �̻��� ���� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE TO_CHAR(NVL(ENT_DATE, SYSDATE),'YYYY') - TO_CHAR(HIRE_DATE, 'YYYY') >= 20;


-- EMPLOYEE ���̺��� �����, �Ի���, �Ի��� ���� �ٹ��ϼ��� ��ȸ
SELECT EMP_NAME "�����", HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE) - HIRE_DATE "�ٹ��ϼ�"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� ����� �̸�, �Ի���, �ٹ���� ��ȸ
-- �� �ٹ������ (����⵵ - �Ի�⵵)�� ��ȸ�ϼ���
-- 1) EXTRACT
SELECT EMP_NAME "�̸�", HIRE_DATE "�Ի���", 
       EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "1) �ٹ����",
       TO_CHAR(SYSDATE,'YYYY')- EXTRACT(YEAR FROM HIRE_DATE) "2) �ٹ����"
FROM EMPLOYEE;


-- 2) MONTHS_BETWEEN
SELECT EMP_NAME "�̸�", HIRE_DATE "�Ի���", 
       FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) "�ٹ����"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� �����, �޿� ��ȸ
-- �޿��� '\9,000,000' �������� ǥ��
SELECT EMP_NAME "�̸�", TO_CHAR(SALARY, 'FML9,999,999') "�޿�"
FROM EMPLOYEE;


-- EMPLOYEE ���̺��� �̸�, �Ի��� ��ȸ
-- �Ի����� ���� ������ '2017�� 12�� 06�� (��)' �������� ���
SELECT EMP_NAME "�̸�", TO_CHAR(HIRE_DATE, 'YYYY"��"MM"��"DD"��" "("DY")"') "�Ի���"
FROM EMPLOYEE;


-- ������ �޿��� �λ��ϰ��� �Ѵ�
-- �����ڵ尡 J7�� ������ �޿��� 10%�� �λ��ϰ�
-- �����ڵ尡 J6�� ������ �޿��� 15%�� �λ��ϰ�
-- �����ڵ尡 J5�� ������ �޿��� 20%�� �λ��ϸ�
-- �� �� ������ ������ �޿��� 5%�� �λ��Ѵ�.
-- ���� ���̺��� ������, �����ڵ�, �޿�, �λ�޿�(�� ����)�� ��ȸ�ϼ���
-- 1) DECODE
SELECT EMP_NAME "������", JOB_CODE "�����ڵ�", SALARY "�޿�",
       DECODE(JOB_CODE, 'J7', SALARY*1.1, 'J6', SALARY*1.15, 'J5', SALARY*1.2, SALARY*1.05) "����޿�"
FROM EMPLOYEE;
-- 2) CASE WHEN
SELECT EMP_NAME "������", JOB_CODE "�����ڵ�", SALARY "�޿�",
       CASE WHEN JOB_CODE='J7' THEN SALARY*1.1
            WHEN JOB_CODE='J6' THEN SALARY*1.15
            WHEN JOB_CODE='J5' THEN SALARY*1.2
       ELSE SALARY*1.05
       END "�λ�޿�"
FROM EMPLOYEE;


-- ���, �����, �޿�
-- �޿��� 500���� �̻��̸� '���'
-- �޿��� 300~500�����̸� '�߱�'
-- �� ���ϴ� '�ʱ�'���� ���ó���ϰ� ��Ī�� '����'���� �Ѵ�.
SELECT EMP_ID "���", EMP_NAME "�����", SALARY,
       CASE WHEN SALARY>=5000000 THEN '��'
            WHEN SALARY>=3000000 THEN '��'
       ELSE '��'
       END || '��' "����"
FROM EMPLOYEE;


-- EMPLOYEE���̺��� �μ��ڵ尡 D5�� ������ ���ʽ� ���� ���� ��ȸ
SELECT SUM((SALARY + (SALARY*NVL(BONUS, 0)))*12) "����",
       SUM(SALARY*12*NVL2(BONUS,BONUS+1,1)) "����"
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';


-- ������, �����ڵ�, ���ʽ��� ���Ե� ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
SELECT EMP_NAME "������", DEPT_CODE "�����ڵ�", TO_CHAR(SALARY*12*NVL2(BONUS,BONUS+1,1),'FML999,999,999') "����(��)"
FROM EMPLOYEE;


-- �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ ���, �����, �μ��ڵ�, �Ի���
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_CODE "�μ��ڵ�", HIRE_DATE "�Ի���"
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D9') AND TO_NUMBER(TO_CHAR(HIRE_DATE,'YYYY'))=2004;


-- ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ(��, �ָ��� �Ի��� ���� �ٹ��ϼ��� ������)
SELECT EMP_NAME "�����", HIRE_DATE "�Ի���", LAST_DAY(HIRE_DATE) - HIRE_DATE+1 "�ٹ��ϼ�"
FROM EMPLOYEE;


-- �μ��ڵ尡 D5�� D6�� �ƴ� ������� ������, �μ��ڵ�, �������, ����(��) ��ȸ
--  ��, ��������� �ֹι�ȣ���� �����ؼ� ������ ������ �����Ϸ� ��µǰ� �ϰ�
--  ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ���� ���
SELECT EMP_NAME "�����", DEPT_CODE "�μ��ڵ�", 
       SUBSTR(EMP_NO,1,2)||'��' 
       || SUBSTR(EMP_NO,3,2)||'��' 
       || SUBSTR(EMP_NO,5,2)||'��' "�������",
       EXTRACT(YEAR FROM SYSDATE)
       - TO_CHAR(TO_DATE(SUBSTR(EMP_NO,1,2),'RR'),'YYYY')||'��' "����"
FROM EMPLOYEE;

    
-- �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------
SELECT SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2001,1,2002,1,2003,1,2004,1)) "��ü������",
       SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2001,1)) "2001��",
       NVL(SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2002,1)),0) "2002��",
       NVL(SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2003,1)),0) "2003��",
       SUM(DECODE(TO_CHAR(HIRE_DATE,'YYYY'), 2004,1)) "2004��"
FROM EMPLOYEE;

--  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
-- 1) DECODE
SELECT EMP_NAME "�����", DEPT_CODE "�μ��ڵ�",
       DECODE(DEPT_CODE,'D5','�ѹ���','D6','��ȹ��','D9','������')
FROM EMPLOYEE
WHERE DEPT_CODE='D5' OR DEPT_CODE = 'D6' OR DEPT_CODE='D9';
-- 2) CASE WHEN
SELECT EMP_NAME "�����", DEPT_CODE "�μ��ڵ�",
       CASE WHEN DEPT_CODE='D5' THEN '�ѹ���'
            WHEN DEPT_CODE='D6' THEN '��ȹ��'
            WHEN DEPT_CODE='D9' THEN '������'
       END
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9');




--------------------------------------------------------------------
-- 1. EMP���̺��� COMM �� ���� NULL�� �ƴ� ���� ��ȸ
SELECT *
FROM EMP
WHERE COMM IS NOT NULL;

-- 2. EMP���̺��� Ŀ�̼��� ���� ���ϴ� ���� ��ȸ
SELECT * 
FROM EMP
WHERE COMM IS NULL OR COMM=0;

-- 3. EMP���̺��� �����ڰ� ���� ���� ���� ��ȸ
SELECT *
FROM EMP
WHERE MGR IS NULL;

-- 4. EMP���̺��� �޿��� ���� �޴� ���� ������ ��ȸ
SELECT * 
FROM EMP
ORDER BY SAL DESC;

-- 5. EMP���̺��� �޿��� ���� ��� Ŀ�̼��� �������� ���� ��ȸ
SELECT * 
FROM EMP
ORDER BY SAL DESC, COMM ASC;

-- 6. EMP���̺��� �����ȣ, �����, ����, �Ի��� ��ȸ (��, �Ի����� �������� ���� ó��)
SELECT EMPNO "�����ȣ", ENAME "�����", JOB "����", HIREDATE "�Ի���"
FROM EMP
ORDER BY HIREDATE;

-- 7. EMP���̺��� �����ȣ, ����� ��ȸ (�����ȣ ���� �������� ����)
SELECT EMPNO "�����ȣ", ENAME "�����"
FROM EMP
ORDER BY EMPNO DESC;

-- 8. EMP���̺��� ���, �Ի���, �����, �޿� ��ȸ 
--  (�μ���ȣ�� ���� ������, ���� �μ���ȣ�� ���� �ֱ� �Ի��� ������ ó��)
SELECT EMPNO "�����ȣ", HIREDATE "�Ի���" ,ENAME "�����", SAL "�޿�"
FROM EMP
ORDER BY DEPTNO, HIREDATE DESC;

-- 9. ���� ��¥�� ���� ���� ��ȸ
SELECT SYSDATE
FROM DUAL;

-- 10. EMP���̺��� ���, �����, �޿� ��ȸ 
--  (��, �޿��� 100���������� ���� ��� ó���ϰ� �޿� ���� �������� ����)
SELECT EMPNO "�����ȣ", ENAME "�����", TRUNC(SAL,-2) "�޿�"
FROM EMP
ORDER BY SAL DESC;

-- 11. EMP���̺��� �����ȣ�� Ȧ���� ������� ��ȸ
SELECT *
FROM EMP
WHERE MOD(EMPNO,2)=1;

-- 12. EMP���̺��� �����, �Ի��� ��ȸ 
--  (��, �Ի����� �⵵�� ���� �и� �����ؼ� ���)
SELECT ENAME "�����", 
TO_CHAR(TO_DATE(SUBSTR(HIREDATE,1,2),'RR'),'YYYY') "�Ի�⵵", 
EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵",
TO_NUMBER(SUBSTR(HIREDATE,4,2)) "�Ի��"
FROM EMP;

-- 13. EMP���̺��� 9���� �Ի��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE EXTRACT(MONTH FROM HIREDATE) = 9;
-- 14. EMP���̺��� 81�⵵�� �Ի��� ���� ��ȸ
SELECT *
FROM EMP
WHERE TO_NUMBER(SUBSTR(HIREDATE,1,2)) = 81;

-- 15. EMP���̺��� �̸��� 'E'�� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE ENAME LIKE '%E';

-- 16. EMP���̺��� �̸��� �� ��° ���ڰ� 'R'�� ������ ���� ��ȸ
-- 1) LIKE
SELECT *
FROM EMP
WHERE ENAME LIKE '__R%';

-- 2) SUBSTR()
SELECT *
FROM EMP
WHERE SUBSTR(ENAME,3,1)='R';

-- 17. EMP���̺��� ���, �����, �Ի���, �Ի��Ϸκ��� 40�� �Ǵ� ��¥ ��ȸ
SELECT EMPNO "���", ENAME "�����", HIREDATE "�Ի���", ADD_MONTHS(HIREDATE,480) "�Ի��Ϸκ��� 40��"
FROM EMP;

-- 18. EMP���̺��� �Ի��Ϸκ��� 38�� �̻� �ٹ��� ������ ���� ��ȸ
SELECT *
FROM EMP
WHERE MONTHS_BETWEEN(TO_DATE(190516),HIREDATE)/12 >= 38;

-- 19. ���� ��¥���� �⵵�� ����
SELECT EXTRACT(YEAR FROM SYSDATE)
FROM DUAL;


-- BASIC -------------------------------------------------------------------
-- �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. 
--      ��, ��� ����� "�а���", "�迭"���� ǥ���ϵ��� �Ѵ�.]

SELECT DEPARTMENT_NAME "�а���", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�.
SELECT DEPARTMENT_NAME || '�� ������ '|| CAPACITY ||'�� �Դϴ�'
FROM TB_DEPARTMENT;

-- "������а�"�� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�.
-- �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����.
-- JOIN
SELECT STUDENT_NAME
FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING (DEPARTMENT_NO)
     WHERE DEPARTMENT_NAME = '������а�' 
     AND ABSENCE_YN = 'Y' 
     AND SUBSTR(STUDENT_SSN,8,1) = 2;
     
-- �Ϲ�
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001' 
      AND ABSENCE_YN = 'Y' 
      AND SUBSTR(STUDENT_SSN,8,1) = 2;     
      
      
-- ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�. �� ����ڵ���
-- �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

-- ���������� 20���̻� 30�������� �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.
-- �׷� �� ������б� ������ �̸��� �˾� �� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� 
-- ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT(CATEGORY)
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 02 �й� ���� �����ڵ��� ������ ������� �Ѵ�. ������ ������� ������ ��������
-- �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N' 
AND STUDENT_ADDRESS LIKE '����%' 
AND SUBSTR(STUDENT_NO,1,2) = 'A2';

-- FUNCTION ------------------------------------------------------------------

-- ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� ������
-- ǥ���ϴ� SQL ������ �ۼ��Ͻÿ� ( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� �Ѵ�.)
SELECT STUDENT_NO "�й�", STUDENT_NAME "�̸�", ENTRANCE_DATE "���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE;

-- �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
-- �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����.
-- (* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� ������ �� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�
-- ��, �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�.
-- ��, ���� �� 2000�� ���� ����ڴ� ������ �������� "�����̸�", "����"�� �Ѵ�. ���̴� '��'���� ����Ѵ�.
SELECT PROFESSOR_NAME "�����̸�", EXTRACT(YEAR FROM SYSDATE)-(TO_CHAR(TO_DATE(SUBSTR(PROFESSOR_SSN,1,2),'YY'),'YYYY')-100) "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1) = 1
ORDER BY ����;

-- �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��� ����� "�̸�"�� �������� �Ѵ�. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT SUBSTR(PROFESSOR_NAME,2) "�̸�"
FROM TB_PROFESSOR
WHERE LENGTH(SUBSTR(PROFESSOR_NAME,2)) >= 1;

-- �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?
-- �̶�, 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
-- 1)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(STUDENT_SSN,1,6),'RRMMDD'))>19;
-- 2)
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)- TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN,1,2),'RR'),'YYYY')  > 19;

-- 2020�� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201225,'YYMMDD'),'DAY') "ũ��������"
FROM DUAL;

-- TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
-- �� TO_DATE('99/10/11','RR/MM/DD'), TO_DATE('49/10/11','RR/MM/DD')�� ���� �� �� �� �� �� ���� �ǹ��ұ�?
SELECT TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'),'YYYY/MM/DD'), 
       -- YY�� ���� ���⸦ �ٿ��ش�
       TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'),'YYYY/MM/DD'), 
       -- YY�� ���� ���⸦ �ٿ��ش�
       TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'),'YYYY/MM/DD'),
       -- 50~99������ �� ���⸦ �ٿ��ش�.
       TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'),'YYYY/MM/DD')
       -- 00~49������ ���� ���⸦ �ٿ��ش�.
FROM DUAL;

-- �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�.
-- 2000�⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE NOT STUDENT_NO LIKE 'A%';

-- �й��� A517178�� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, �̋� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�.
SELECT ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ��� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL
GROUP BY COACH_PROFESSOR_NO;

-- �й��� A112113�� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�,
-- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO,1,4) "�⵵", ROUND(AVG(POINT),1) "�⵵ �� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

-- �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
--SELECT DEPARTMENT_NO "�а��ڵ��", COUNT(*) "���л� ��"
SELECT DEPARTMENT_NO, COUNT(*)
FROM TB_STUDENT
WHERE absence_yn IN('Y')
GROUP BY DEPARTMENT_NO
--ORDER BY DEPARTMENT_NO;
MINUS 
SELECT DEPARTMENT_NO �а���ȣ, COUNT(*) "���л� ��"
FROM TB_STUDENT
WHERE ABSENCE_YN ='N'
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- �� ���б��� �ٴϴ� �������� �л����� �̸��� ã���� �Ѵ�.
-- � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1;

-- �й��� A112113�� ���� �л��� �⵵, �б� �� ������ �⵵ �� ���� ����, �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.
SELECT SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2), ROUND(AVG(POINT),1)
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2));



-- OPTION---------------------------------------------------------------------------------
-- �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�,
-- ������ �̸����� �������� ǥ���ϵ����Ѵ�.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS "�ּ���"
FROM  TB_STUDENT
ORDER BY STUDENT_NAME;

-- �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN IN 'Y'
ORDER BY TO_NUMBER(SUBSTR(STUDENT_SSN,1,6)) DESC;

-- �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
-- ��, �������� "�л��̸�", "�й�", "������ �ּ�"�� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '����%' 
OR STUDENT_ADDRESS LIKE '���%')
AND STUDENT_NO LIKE '9%'
ORDER BY STUDENT_ADDRESS;

-- ���� ���а� ���� �� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
-- ���а��� '�а��ڵ�'�� �а����̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�Ƴ����� ����
SELECT P.PROFESSOR_NAME, P.PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.DEPARTMENT_NAME IN '���а�'
ORDER BY SUBSTR(PROFESSOR_SSN,1,6);

-- 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�.
-- ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��غ��ÿ�.
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE TERM_NO IN '200402'AND CLASS_NO IN 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY S.STUDENT_NAME;

-- �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO;

-- ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO;

-- 8���� ��� �� '�ι���ȸ' �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�.
-- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NAME, P.PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
AND CP.PROFESSOR_NO = P.PROFESSOR_NO
AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.CATEGORY IN '�ι���ȸ';

-- '�����а�' �л����� ������ ���Ϸ��� �Ѵ�. �����а� �л����� "�й�", "�л� �̸�", "��ü ����"��
-- ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.
SELECT S.STUDENT_NO "�й�", STUDENT_NAME "�л� �̸�", ROUND(AVG(G.POINT),1) "��ü ����"
FROM TB_STUDENT S, TB_GRADE G, TB_DEPARTMENT D
WHERE S.STUDENT_NO = G.STUDENT_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND D.DEPARTMENT_NAME IN '�����а�'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME
ORDER BY S.STUDENT_NO;

-- �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� 
-- �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. �̶� ����� SQL ���� �ۼ��Ͻÿ�.
-- ��, �������� "�а��̸�", "�л��̸�", "�����Լ��̸�"���� ��µǵ��� �Ѵ�.
SELECT DEPARTMENT_NAME "�а��̸�", STUDENT_NAME "�л��̸�", PROFESSOR_NAME "�����̸�" 
FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO
AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND STUDENT_NO = 'A313047';

-- 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� �л��̸��� �����б⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, G.TERM_NO
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE G.CLASS_NO = C.CLASS_NO 
AND G.STUDENT_NO = S.STUDENT_NO
AND C.CLASS_NAME IN '�ΰ������'
AND G.TERM_NO LIKE '2007%';

-- ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D, TB_CLASS_PROFESSOR CP 
WHERE C.DEPARTMENT_NO(+) = D.DEPARTMENT_NO
AND CP.CLASS_NO(+) = C.CLASS_NO
AND PROFESSOR_NO IS NULL
AND CATEGORY = '��ü��'
ORDER BY CLASS_NAME;

SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
     LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
     LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '��ü��'
      AND PROFESSOR_NO IS NULL;
      
      
-- �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ���
-- "�������� ������" ���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�.
-- ��, �������� "�л��̸�", "��������"�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME, '�������� ������') ��������
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P 
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
AND D.DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO;


-- ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� �� �л��� �й�, �̸�, �а� �̸�, ������ ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME, ROUND(AVG(POINT),5)
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND S.STUDENT_NO = G.STUDENT_NO
AND S.ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME, D.DEPARTMENT_NAME
HAVING AVG(POINT) >=4.0
ORDER BY STUDENT_NO;

-- ȯ�� �����а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT C.CLASS_NO, C.CLASS_NAME, AVG(POINT)
FROM TB_CLASS C, TB_DEPARTMENT D, TB_GRADE G
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
AND C.CLASS_NO = G.CLASS_NO
AND DEPARTMENT_NAME = 'ȯ�������а�' AND CLASS_TYPE = '��������'
GROUP BY C.CLASS_NO, C.CLASS_NAME
ORDER BY CLASS_NO;

-- ������а����� �� ������ ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT S.STUDENT_NO, S.STUDENT_NAME, AVG(POINT) "���"
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
AND G.STUDENT_NO = S.STUDENT_NO
AND D.DEPARTMENT_NAME = '������а�'
GROUP BY S.STUDENT_NO, S.STUDENT_NAME;


SELECT JOB_CODE
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT DEPT_TITLE
FROM EMPLOYEEL