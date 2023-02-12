-----------첫번째 시험 공부-------------
--보너스를 받지 않고, 부서 배치는 되어있는 사원 조회하고 싶음!
SELECT *
FROM EMPLOYEE
WHERE BONUS = NULL AND DEPT_CODE != NULL;

-- 문제점 : NULL값 비교할때는 단순한 일반비교 연산자를 통해 비교할 수 없다.
-- 해결방법 : IS NULL / IS NOT NULL 연산자를 통해 비교를 해야함.

SELECT *
FROM EMPLOYEE
WHERE BONUS IS NULL AND DEPT_CODE IS NOT NULL;