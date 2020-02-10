-- SELECT�� �÷��� ���� ������ �� �� �ۼ��ϴ� �������� 
-- SELECT ������ ���� �������� �ۼ��ϸ� ���� ���� ���� ���� �������� �����


-- ���� ���� ��� ���� �����ϱ� ���� �׷� �Լ��� ����� �׷��� ������ GROUP BY���� ����Ͽ� ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- ORDER BY�� : SELECT�� �÷��� ������ ������ �� ���
-- ORDER BYW �÷��� | �÷���Ī | �÷��������� [ASC] | DESC]
SELECT EMP_ID, JOB_CODE, EMP_NAME, SALARY "�޿�", DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_NAME; -- ��������
--ORDER BY EMP_NAME ASC;
--ORDER BY EMP_NAME DESC; -- ��������
--ORDER BY DEPT_CODE NULLS FIRST; -- NULL�� ���� �̰� �������� �����ؼ� ���
--ORDER BY 2; -- ���ڷ� �� ��� ���� ���� ��ġ�� ���ĵǱ� ������ �߰��� �߰��ϸ� ����ؼ� �ٲ�����ϰ� ������ �ǵ��� ��븻��!!
ORDER BY �޿�;

/*
(SELECT FROM) > WHERE > ORDER BY | GROP BY | HAVING

����
5 : SELECT
1 : FROM
2 : WHERE
3 : GROUP BY
4 : HAVING
6: ORDER BY
*/

-- GROUP BY : ���� ���� ���� ��� �ϳ��� ó���� �������� ���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- EMPLOYEE���̺��� �μ��ڵ�� ���ʽ��� �޴� ������� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE���̺��� �μ� �ڵ� �� �׷��� �����Ͽ� �μ��ڵ�, �׷� �� �޿��� �հ�, �׷� �� �޿��� ���,
-- �ο����� ��ȸ�ϰ� �μ��ڵ� ������ ����
SELECT DEPT_CODE, SUM(NVL(SALARY,0)) "�޿� �հ�", FLOOR(AVG(NVL(SALARY,0))) "�޿� ���", COUNT(*) "�μ� �ο�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- EMPLOYEE���̺��� �����ڵ�, ���ʽ��� �޴� ������� ��ȸ�Ͽ� �����ڵ� ������ �������� ����
SELECT JOB_CODE, COUNT(BONUS)
FROM EMPLOYEE
WHERE BONUS IS NOT NULL -- COUNT(BONUS)�� 0�� ������ ���� ���� ���� ��
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

-- EMPLOYEE���̺��� ������ ���� �� �޿� ���, �޿� �հ�, �ο� �� ��ȸ�ϰ� �ο� ���� �������� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��') ����,
       FLOOR(AVG(SALARY)), SUM(SALARY), COUNT(*) "�ο���"
FROM EMPLOYEE
GROUP BY DECODE(SUBSTR(EMP_NO, 8, 1), 1, '��', '��')
ORDER BY �ο��� DESC;

-- EMPLOYEE���̺��� �μ� �ڵ庰�� ���� ������ ����� �޿� �հ� ��ȸ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE; -- ���� �÷� ���� �� ����.

-- HAVING : �׷��Լ��� ���� �� �׷쿡 ���� ������ ������ �� ���
-- �μ��ڵ�� �޿� 300���� �̻��� ������ �׷캰 ���(�ݿø�) �޿� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
WHERE SALARY >= 3000000
GROUP BY DEPT_CODE;

-- �μ��ڵ�� �޿� ���(�ݿø�)�� 300���� �̻��� �׷� ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) >= 3000000;

-- �μ� �� �׷��� �޿� �հ� �� 900������ ��ȭ�ϴ� �μ� �ڵ�� �޿� �հ�(�μ� �ڵ� ������ ����)
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 9000000
ORDER BY DEPT_CODE;

-- �����Լ�(ROLLUP, CUBE) : �׷� �� ������ ��� ���� ���� ���
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY JOB_CODE;

SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE)
ORDER BY JOB_CODE;

-- �׷캰�� �߰� ���� ó���� �ϴ� �Լ�
-- ���ڷ� ���� ���� �� �߿��� ���� ���� ������ ���ڿ� ���� �׷캰 �߰� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;

-- �׷캰�� �߰� ���� ó��
-- ���ڷ� ���� ���� �� ��ο� ���� �׷캰 �߰� ����
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY CUBE(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;



-- ROLLUP�̳� CUBE�� ���� ���⹰�� ���ڷ� ���޹��� �÷��� ���Ṱ�̸� 0 ��ȯ, �ƴϸ� 1��ȯ
SELECT DEPT_CODE, JOB_CODE, SUM(SALARY),
        GROUPING(DEPT_CODE) �μ����׷칭�λ���,
        GROUPING(JOB_CODE) ���޺��׷칭�λ���
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
ORDER BY DEPT_CODE;
        
-- ���� ������
-- UNION : ������, OR
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 200
UNION
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID = 201;


    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D5'
    UNION
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 3000000;
    
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
    FROM EMPLOYEE
    WHERE SALARY > 3000000 OR DEPT_CODE = 'D5';

-- UNION ALL : ������(OR) + ������(AND) ==> ����κ��� 2������
-- DEPT_CODE�� D5�̰ų� �޿��� 300������ �ʰ��ϴ� ������ ���, �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- INTERSECT : ������(AND)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 AND DEPT_CODE = 'D5';

-- MINUS : ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY <= 3000000 AND DEPT_CODE = 'D5';

-- GROUPPING SETS : �׷캰�� ó���� ���� ���� SELECT���� �ϳ��� ��ĥ �� ���
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE, MANAGER_ID;

SELECT JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE, MANAGER_ID;

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY GROUPING SETS(
        (DEPT_CODE,JOB_CODE, MANAGER_ID),
        (DEPT_CODE, MANAGER_ID),
        (JOB_CODE, MANAGER_ID))
ORDER BY DEPT_CODE;

