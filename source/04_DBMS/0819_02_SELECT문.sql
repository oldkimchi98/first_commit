-- [II] SELECT문 - 조회

-- 1. SELECT 문자 작성법(실행:CTRL+ENTER) 순서 반드시 지켜야함
SELECT *
FROM tab; 

-- 현재 계정이 가지고 있는 테이블 정보
SELECT *
FROM emp;  

-- EMP테이블의 모든 정보(모든 열, 모든 행)
SELECT *
FROM dept; 

-- DEPT테이블의 모든 정보
SELECT *
FROM salgrade;

-- 2. 특정 열만 출력
DESC EMP;

    -- EMP 테이블 구조
    SELECT empno, ename, sal, hiredate
    FROM emp; 
    -- EMP 테이블에서 EMPNO, ENAME, SAL열만 검색
    SELECT empno    "사번", ename    "이름", sal      "급여", hiredate "입사일"
    FROM emp;
    SELECT empno    "사 번", ename, sal      급여, hiredate 입사일
    FROM emp;

-- 3. 특정 행만 출력 : WHERE절(조건절) 비교연산자 - 같다(==), 다르다(!=, ^=, <>), >, <, >=, <=
SELECT empno no, ename name, sal
FROM emp
WHERE sal = 3000;

SELECT empno no, ename name, sal
FROM emp
WHERE sal <> 3000;

SELECT empno no, ename name, sal
FROM emp
WHERE sal > 3000;
    
-- 비교연산자는 숫자, 문자, 날짜 모두 가능
    
    -- EX1. 사원이름(ENAME)이 'A','B','C'로 시작하는 사원의 모든 필드 'A'<'AA'<'AAA'<'B'<'C'<'CA'<'CAA'..
    SELECT *
    FROM emp
    WHERE ename < 'D';
    -- EX2. 81년도 이전에 입사한 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE hiredate < '81/01/01';
    
    -- 날짜 표기법 세팅(현재:RR/MM/DD)
    ALTER SESSION SET nls_date_format = 'MM-DD-YYYY';
    SELECT *
    FROM emp
    WHERE to_char(
        hiredate, 'RR/MM/DD'
    )< '81/01/01';
    
    SELECT *
    FROM emp
    WHERE hiredate < TO_DATE( '81/01/01', 'RR/MM/DD' );
    ALTER SESSION SET nls_date_format = 'RR/MM/DD';
 
    
-- 4. 특정 행만 출력 : WHERE절 (조건절)에서 논리연산자 : OR, AND, NOT
    
    -- EX1. 급여(SAL)가 2000부터 3000인 직원의 모든 필드
    SELECT *
    FROM emp
    WHERE 2000 <= sal AND sal <= 3000;
    -- EX2. 82년도에 입사한 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE hiredate >= '82/01/01' AND hiredate <= '82/12/31';
    SELECT *
    FROM emp
    WHERE hiredate >= TO_DATE( '82/01/01', 'RR/MM/DD' )AND hiredate <= TO_DATE( '82/12/31', 'RR/MM/DD' );
    -- EX3. 10번 부서(DEPTNO)이거나 JOB이 MANAGER인 직원의 모든 필드
    SELECT *
    FROM emp
    WHERE deptno = 10 OR job = 'MANAGER';

-- 5. 산술연산자(SELECT절, WHERE절, ORDER BY절)
    -- EX. 연봉이 2400이상인 직원의 ENAME, SAL, 연봉(SAL*12) / 별칭에 띄어쓰기 있으면 "안에 작성"
    SELECT ename, sal, sal * 12 연봉    -- (3)번째
    FROM emp                      -- (1)번째
    WHERE sal * 12 >= 2400            -- (2)번째
    ORDER BY 연봉;     -- 연봉 오름차순 정렬(ASC)    (4)번째
    --  ORDER BY 연봉 DESC; -- 연봉 내림차순 정렬(DESC)
    
    -- EX. 연봉이 10000이상인 직원의 ENAME, SAL, 연봉(SAL*12+COMM)
    -- 산술연산의 결과는 null을 포함하면 결과도 null
    -- NVL(null일수도 있는 필드명, 대체값) - 필드명과 대체값의 타입이 일치
    SELECT ename, sal, comm, sal * 12 + nvl(
        comm, 0
    )"연봉"
    FROM emp
    WHERE sal * 12 + nvl(
        comm, 0
    )> 10000;
    
    -- EX. 모든 사원의 ENAME, MGR(상사사번)을 출력(MGR이 NULL이면 'CEO'로 바꿔 출력)
    SELECT ename, nvl(
        to_char( mgr ), 'CEO'
    )mgr
    FROM emp;
    DESC EMP; 

        
-- 6. 연결연산자 (||) : 필드나 문자를 연결        
SELECT ename || '은' || job
FROM emp;
    
    -- EX. 모든 사원에 대해서 SMITH의 연봉은 xxxx$입니다"라고 출력하고 TITLE에는 MESSAGE.
    SELECT ename || '의 연봉은 ' ||( sal * 12 + nvl(comm, 0))|| '$입니다' message
    FROM emp;

-- 7. 중복제거 (DISTINCT)
SELECT DISTINCT job
FROM emp;
SELECT DISTINCT deptno
FROM emp;

    
-- 연습문제 꼭 풀기

--1. emp 테이블의 구조 출력
DESC EMP;
    
--2. emp 테이블의 모든 내용을 출력
SELECT *
FROM emp;
    
--3. 현 scott 계정에서 사용가능한 테이블 출력
SELECT *
FROM tab;
    
--4. emp 테이블에서 사번, 이름, 급여, 업무, 입사일 출력
SELECT empno    "사번", ename    "이름", sal      "급여", hiredate "입사일"
FROM emp;
    
--5. emp 테이블에서 급여가 2000미만인 사람의 사번, 이름, 급여 출력
SELECT *
FROM emp
WHERE 2000 > sal;
    
--6. 입사일이 81/02이후에 입사한 사람의 사번, 이름, 업무, 입사일 출력
SELECT empno, ename, job, hiredate
FROM emp
WHERE hiredate >= TO_DATE( '81/03/01', 'RR/MM/DD' );
        
--7. 업무가 SALESMAN인 사람들 모든 자료 출력
SELECT *
FROM emp
WHERE job = 'SALESMAN';
    
--8. 급여가 1500이상이고 3000이하인 사람의 사번, 이름, 급여 출력
SELECT *
FROM emp
WHERE 1500 <= sal AND sal <= 3000;
    
--9. 부서코드가 10번이거나 30인 사람의 사번, 이름, 업무, 부서코드 출력
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 30;
    
--10. 업무가 SALESMAN이거나 급여가 3000이상인 사람의 사번, 이름, 업무, 부서코드 출력
SELECT *
FROM emp
WHERE job = 'SALESMAN' OR 3000 <= sal;
    
--11.“ename은 XXX 업무이고 연봉은 XX다” 스타일로 모두 출력(연봉은 SAL*12+COMM)
SELECT ename || '은 ' || job || ' 업무이고 연봉은 ' ||( sal * 12 + comm )|| '입니다' message
FROM emp;    
        

-- 8번 문제. SQL 연산자 (BETWEEN, IN, LIKE, IS NULL)

-- (1) 필드명     BETWEEN A AND B : 필드명이 A부터 B까지(A, B 포함)
--     필드명 NOT BETWEEN A AND B : 필드명이 A미만 B초과(A, B 미포함) A<B    
    
    -- EX. 급여가 1500이상이고 3000이하인 사람의 사번, 이름, 급여 출력
    SELECT *
    FROM emp
    WHERE sal BETWEEN 1500 AND 3000;

    SELECT *
    FROM emp
    WHERE sal BETWEEN 3000 AND 1500; -- 불가능함. 반드시 A가 B보다 작아야지 가능함.
    
    -- EX. 82년도 3월부터 5월까지 입사한 사람의 모든 필드 출력
    SELECT *
    FROM emp
    WHERE hiredate BETWEEN TO_DATE( '82/03/01', 'RR/MM/DD' )AND TO_DATE( '82/05/31', 'RR/MM/DD' );
    
    -- EX. 급여가 1500미만, 3000초과인 사람의 모든 필드 출력
    SELECT *
    FROM emp
    WHERE sal NOT BETWEEN 1500 AND 3000;
  
    
-- (2) 필드명 IN (값1, 값2, ... 값N) : 필드명이 값1이거나 값2이거나, ... 값N인 경우
    
    -- EX. 부서코드가 10번이거나 30인 사람의 사번, 이름, 부서코드 출력
    SELECT empno, ename, deptno
    FROM emp
    WHERE deptno IN( 10, 30 );
    
    -- EX. 부서코드가 10,20,40번을 제외한 직원의 모든 필드 출력
    SELECT *
    FROM emp
    WHERE NOT( deptno = 10 OR deptno = 20 OR deptno = 40 );

    SELECT *
    FROM emp
    WHERE deptno NOT IN( 10, 20, 40 );
    
    -- EX. 사번이 7902, 7788, 7566인 사원의 이름, 사번, 직책을 출력
    SELECT ename, empno, job
    FROM emp
    WHERE empno IN( 7902, 7788, 7566 );

    
-- (3) 필드명 LIKE 패턴 : &(0글자이상), _(한글자)를 포함된 패턴
    
    -- EX. 이름이 M으로 시작하는 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE ename LIKE 'M%';
    
    -- EX. 이름에 N이 들어가는 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE ename LIKE '%N%';
    
    -- EX. 이름이 SAL이 5로 끝나는 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE sal LIKE '%5';
    
    -- EX. 82년도에 입사한 사원의 이름, 입사일을 출력
    SELECT ENAME , HIREDATE FROM WHERE TO_CHAR ( HIREDATE , 'RR/MM/DD' ) LIKE '82%' ;
    
    -- EX. 1월에 입사한 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE to_char(
        hiredate, 'RR/MM/DD'
    )LIKE '__/01/__';
    
-- (4) IS NULL(NULL인지를 검색할 때)
    
    -- EX. 상여금이 NULL인 사원의 모든 필드
    SELECT *
    FROM emp
    WHERE comm IS NULL;
    
    -- EX. 상여금이 없는 사원의 모든 필드 (COMM이 NULL이거나 0)
    SELECT *
    FROM emp
    WHERE comm IN( NULL, 0 ); -- 불가
    
    SELECT *
    FROM emp
    WHERE comm = NULL OR comm = 0; -- 불가

    SELECT *
    FROM emp
    WHERE comm IS NULL OR comm = 0;
    
    -- EX. 상여금을 받는 사원의 모든 필드(COMM이 NULL이 아니고 COMM이 0이 아닌 사원)
    SELECT *
    FROM emp
    WHERE comm != NULL AND comm != 0; -- 불가

    SELECT *
    FROM emp
    WHERE comm IS NOT NULL AND comm != 0;
    
-- 9. 정렬(오름차순ASC, 내림차순DESC) : ORDER BY절
SELECT ename, sal, hiredate
FROM emp
ORDER BY sal, hiredate DESC, ename;
    
    -- 급여 오름차순, 급여가 같으면 입사일 내림차순, 급여+입사일이 같으면 이름 오름차순 정렬
    SELECT ename, sal*12+NVL(comm, 0) 연봉 FROM emp ORDER BY 연봉, hiredate DESC;

/* ※ 형변환함수
날짜형 -> 문자형 : TO_CHAR(날짜형, '패턴')
                   YYYY(년도4자리) RR(년도2자리) YY(년도2자리) MM(월2자리) DD(일2자리) DY(수) DAY(수요일)
                   HH24, HH12, AM이나 PM, MI(분), SS(초)
숫자형 -> 문자형 : TO_CHAR(숫자형, '패턴') (EX) '9,999'
문자형 -> 날짜형 : TO_DATE('2026-08-19', 'YYYY-MM-DD')
*/
SELECT TO_CHAR(SAL, '9,999') 급여, TO_CHAR(HIREDATE, 'YYYY-MM-DD DY HH12:MI:SS') 입사일 FROM EMP;

-- QUIZ

-- 1. EMP 테이블에서 sa1이 3000이상인 사원의 empno, ename, job, sal을 출력하시오.
SELECT *
FROM emp
WHERE sal >= 3000;
    
-- 2. EMP 테이블에서 empno가 7788인 사원의 ename과 deptno를 출력하시오.
SELECT empno, job
FROM emp
WHERE empno IN( 7788 );

-- 3. 연봉(SAL*12+COMM)이 24000이상인 사번, 이름, 급여 출력하시오. (급여순정렬)
SELECT ename, empno, sal, sal * 12 연봉    
FROM emp                      
WHERE sal * 12 >= 24000;

-- 4. 입사일이 1981년 2월 20일 ~ 1981년 5월 1일 사이에 입사한 사원의 사원명, 직책, 입사일을 출력하시오.
--    (단 hiredate 순으로)
SELECT *
FROM emp
WHERE hiredate BETWEEN TO_DATE( '81/02/20', 'RR/MM/DD' ) AND TO_DATE( '81/05/01', 'RR/MM/DD' );

-- 5. deptno가 10,20인 사원의 모든 정보를 출력하시오.
--    (단 ename순으로 정렬)
SELECT *
FROM emp
WHERE deptno IN( 10, 20 );

-- 6.	sal이 1500이상이고 deptno가 10,30인 사원의 ename과 sal를 출력하시오.
--      (단 출력되는 결과의 타이틀을 employee과 Monthly Salary로 출력하시오.)
SELECT ename "employee", sal   "Monthly Salary"
FROM emp
WHERE sal >= 1500 AND deptno IN( 10, 30 );

-- 7.	hiredate가 1982년인 사원의 모든 정보를 출력하시오.
SELECT *
FROM emp
WHERE TO_CHAR ( HIREDATE, 'YYYY' ) = 1982;

-- 8.	입사일이81년이고 업무가 'SALESMAN'이 아닌 
--      직원의 사번, 사원명, 입사일, 업무, 급여를 검색하시오.
SELECT EMPNO "사번", ENAME "사원명", HIREDATE "입사일", JOB "업무", SAL "급여"
FROM emp
WHERE NOT JOB = 'SALESMAN';

-- 9.	사번, 사원명, 입사일, 업무, 급여를 급여가 높은 순으로 정렬하고, 
--      급여가 같으면 입사일이 빠른 사원으로 정렬하시오.
SELECT EMPNO "사번", ENAME "사원명", HIREDATE "입사일", JOB "업무", SAL "급여"
FROM emp
ORDER BY SAL DESC, hiredate;

-- 10.	사원명의 세 번째 알파벳이 'N'인 사원의 사번, 사원명을 검색하시오.
SELECT EMPNO "사번", ENAME "사원명"
FROM emp
WHERE ENAME LIKE '__N%';

-- 11.	사원명에 'A'가 들어간 사원의 사번, 사원명을 출력하시오.
SELECT EMPNO "사번", ENAME "사원명"
FROM emp
WHERE ENAME LIKE '%A%';

--12.	연봉(SAL*12)이 35000 이상인 사번, 사원명, 연봉을 검색하시오.
SELECT EMPNO "사번", ENAME "사원명", sal*12+NVL(comm, 0) 연봉
FROM emp
WHERE SAL*12 >= 35000
ORDER BY 연봉 DESC;