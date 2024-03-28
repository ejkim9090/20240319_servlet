SELECT
    *
FROM
    employee;

SELECT
    *
FROM
    department;

SELECT
    *
FROM
    location;

SELECT
    *
FROM
    national;

SELECT
    *
FROM
    employee
-- where 속성명 = '속성값'
WHERE
    dept_code = 'D5';

SELECT
    emp_name,
    job_code,
    emp_id,
    hire_date
FROM
    employee
-- where 속성명 = '속성값'
WHERE
    dept_code = 'D5';

SELECT
    *
FROM
    employee
-- where 속성명 = '속성값'
WHERE
    emp_id = '200';

-- 외우기

SELECT [distinct] 컬1 별칭, 컬2 as 별칭, 컬3, ... (산술식-별칭필수)
 from 테1 
    [ join 테2  on / using 조인조건 ] 
 [ where    컬1 비교연산자 비교값 ]
 [ group by 컬럼1, 컬2기준으로묶음 ] 
 [ having   groupby사용한컬럼명 비교연산자 비교값 ]
 [ order by 정렬할컬럼명1, 컬2 ];
select emp_name, salary || '원' as ex1 
    from employee;
select DISTINCT job_code, dept_code
--, emp_id
    from employee;

-- 부서코드가 ‘D9’인 직원의 이름, 부서코드 조회
select emp_name, dept_code
    from employee
    where dept_code ^= 'D9'
    ;
-- 급여가 4000000보다 많은 직원 이름과 급여 조회
select  emp_name, salary
    from employee
--    where salary > 400000a
--ORA-00933: SQL 명령어가 올바르게 종료되지 않았습니다
--00933. 00000 -  "SQL command not properly ended"
--41행, 26열에서 오류 발생
    where not (salary > 4000000)
    ;


-- 급여가 3000000 보다 많고  6000000보다 작은 직원 ----조회
select  emp_name, salary
    from employee
--    where (salary >= 3000000) and (salary <= 6000000)
    where salary between 3000000 and 6000000
    ;

-- 부서코드가 ‘D9’이거나 'D5' 인 직원의 이름, 부서코드 조회
select  emp_name,  dept_code
    from employee
--    where dept_code = 'D9' or dept_code = 'D5' or dept_code = 'D1'
    where dept_code not in ('D9', 'D5', 'D1')
    -- dept_code가 null 인 하동운, 이오리 없음
     or
     dept_code is null
    ;
-- 부서코드가 없는 직원을 조회해주세요.
select  emp_name,  dept_code
    from employee
    where 
--    dept_code = null
        dept_code is null
    ;
    
SELECT EMAIL, INSTR(EMAIL, '.', -4,2) 위치
FROM EMPLOYEE;
-- 1
SELECT INSTRB('ORACLE WELCOME','O', 1, 2) FROM dual;
-- 12
SELECT INSTRB('가 나 다 라 마바사','나',4) FROM dual; 

SELECT LPAD('ORACLE', 10, '+') FROM dual; 
SELECT RPAD('ORACLE', 10, '+') FROM dual; 
SELECT '    O R A C L    E    ',
    LTRIM('    O R A C L    E    ', ' '),	-- 왼쪽 공백 제거
    RTRIM('    O R A C L    E    ')	-- 오른쪽 공백 제거 
    FROM dual; 
SELECT TRIM('a' FROM 'aaaOracleaaa') FROM dual; 
SELECT LTRIM('aaaOracleaaa', 'a') FROM dual; 


-- 중요 꼭 기억하기
SELECT SYSDATE FROM dual; 
-- DUAL 테이블은 oracle에서 임의의 속성값을 확인하고 싶을때 사용하는 테이블
SELECT * FROM DUAL;
SELECT 23*34 FROM DUAL;
SELECT 23*34 FROM employee;
SELECT 23*34 FROM department;

SELECT SYSDATE, to_char(sysdate, 'yyyy"년 "mm"월 "dd"일" day hh:mi:ss am')
    , to_char(sysdate, 'yyyy-mm-dd day hh24:mi:ss')
    FROM dual;

select to_date('2024/05-26' , 'yyyy/mm-dd') c1
    , sysdate c2
    ,  months_between(sysdate, to_date('2024/05-26' , 'yyyy/mm-dd')) c3
    ,  months_between(to_date('2024/05-26' , 'yyyy/mm-dd') , sysdate) c4
    
    , extract ( month from sysdate) c5
    , extract ( day from to_date('2024/05-26' , 'yyyy/mm-dd')) c6
    from dual;





SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss') FROM dual; 


SELECT INSTR('123456789012345' , '34' , 13 , 1) FROM dual; 

select emp_name
        , case  when  substr(emp_no, 1, 1) = '6' then '60년대생'
                when  substr(emp_no, 1, 1) = '7' then '70년대생'
                else '잘모르겠어요' 
          end "출생년도1" 
        , case substr(emp_no, 1, 1) 
                when '6' then '60년대생'
                when  '7' then '70년대생'
                else '잘모르겠어요' 
          end "출생년도2" 
        , emp_no
    from employee
    ;
select emp_name
    , decode(substr(emp_no, 1, 1), '6' ,  '60년대생', 'a') s1
    , decode(substr(emp_no, 1, 1), '6' ,  '60년대생', '7' , '70년대생') s2
    , decode(substr(emp_no, 1, 1), '6' ,  '60년대생', '7' , '70년대생', '8', '80년대', 'b') s3
    , emp_no
    from employee
    ;

select emp_name, sum(salary)
    from employee
    ;
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select sum(salary), JOB_CODE
    from employee
    GROUP BY JOB_CODE
;
select sum(salary), dept_code
    from employee
    GROUP BY dept_code
;

select distinct dept_code, job_code
    from employee;
select sum(salary), dept_code, job_code
    from employee
    GROUP BY dept_code, job_code
;

SELECT COUNT(DEPT_CODE) a, dept_code
    FROM EMPLOYEE
--    WHERE DEPT_CODE = 'D5'
    group by dept_code
    ;

select emp_name, dept_code, job_code, salary, (SALARY + (SALARY * nvl(BONUS,0) )) * 12 a1
    from employee
    where dept_code is not null
        and (SALARY + (SALARY * nvl(BONUS,0) )) * 12 > 30000000
        -- view 생성 또는 subQuery 를 사용해서 속도 줄여야 함.
--         and a1 > 30000000
--         ORA-00904: "A1": 부적합한 식별자
--        00904. 00000 -  "%s: invalid identifier"
--    order by emp_name desc
--    order by dept_code  nulls first
--    order by dept_code asc, job_code, salary desc
    order by  a1 desc
;


SELECT DEPT_CODE, FLOOR(AVG(SALARY)) 평균
    FROM EMPLOYEE
    where dept_code is not null
    GROUP BY DEPT_CODE
    HAVING FLOOR(AVG(SALARY)) >= 2000000
--    having dept_code is not null
    ORDER BY DEPT_CODE;

-- 주석  ctrl /
-- 한줄 주석
/* 여러줄주석 alt shift c */
-- 자동정렬, 대소자변경 ctrl f7
-- 명령어 실행 ctrl enter

SELECT DEPT_CODE, JOB_CODE, floor(avg(SALARY)), count(*)
FROM EMPLOYEE
GROUP BY rollup(DEPT_CODE , JOB_CODE)
ORDER BY 1;



SELECT DEPT_CODE, JOB_CODE, sum(salary) FROM EMPLOYEE where job_code is not null and dept_code is not null
GROUP BY rollup(DEPT_CODE , JOB_CODE) 
union
SELECT DEPT_CODE, JOB_CODE, sum(salary) FROM EMPLOYEE where job_code is not null and dept_code is not null
GROUP BY rollup(JOB_CODE , DEPT_CODE) ORDER BY 1;
SELECT DEPT_CODE, JOB_CODE, sum(salary) FROM EMPLOYEE where job_code is not null and dept_code is not null
GROUP BY CUBE(JOB_CODE , DEPT_CODE) ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE
,   decode( GROUPING(JOB_CODE) , 1 , decode(GROUPING(dept_code) , 1 , '총합', '부합') , decode(GROUPING(dept_code) , 1 , '직합', 'ㅌ') )a1
, sum(salary) FROM EMPLOYEE
GROUP BY CUBE(JOB_CODE , DEPT_CODE) ORDER BY 1;

SELECT DEPT_CODE, JOB_CODE, 
SUM(SALARY),
CASE WHEN GROUPING(DEPT_CODE) = 0 AND  GROUPING(JOB_CODE) = 1    THEN '부서별 합계'
    WHEN GROUPING(dept_code) = 1 AND GROUPING(job_code) = 0 THEN  '직급별 합계'
    WHEN GROUPING(dept_code) = 1 AND GROUPING(job_code) = 1 THEN  '총 합계'
    ELSE
        '그룹별 합계'
    END AS 구분
FROM    employee
group by    cube(dept_code, job_code)
order by 1;
--ORA-30481: GROUPING 함수는 GROUP BY CUBE 또는 ROLLUP에만 제공됩니다
--30481. 00000 -  "GROUPING function only supported with GROUP BY CUBE or ROLLUP"


SELECT DEPT_CODE, JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(DEPT_CODE, JOB_CODE)
UNION
--SELECT sysdate, JOB_CODE, SUM(SALARY)
SELECT 'a', JOB_CODE, avg(SALARY)
FROM EMPLOYEE
GROUP BY ROLLUP(JOB_CODE)
ORDER BY 4
;
--ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
--01789. 00000 -  "query block has incorrect number of result columns"
--ORA-01790: 대응하는 식과 같은 데이터 유형이어야 합니다
--01790. 00000 -  "expression must have same datatype as corresponding expression"
--ORA-01785: ORDER BY 항목은 SELECT 목록 식의 수라야 합니다
--01785. 00000 -  "ORDER BY item must be the number of a SELECT-list expression

SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE
    GROUP BY GROUPING SETS((DEPT_CODE, JOB_CODE, MANAGER_ID),
                        (DEPT_CODE, MANAGER_ID), 
                        (JOB_CODE, MANAGER_ID))
    ;
SELECT DEPT_CODE, JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE    GROUP BY (DEPT_CODE, JOB_CODE, MANAGER_ID)
union
SELECT DEPT_CODE, 'J', MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE    GROUP BY (DEPT_CODE, MANAGER_ID)
union
SELECT 'D', JOB_CODE, MANAGER_ID, FLOOR(AVG(SALARY))    FROM EMPLOYEE    GROUP BY (JOB_CODE, MANAGER_ID);    
    
    
---- 2024.03.28
--- natural join  --- cross join
select emp_id, emp_name, dept_title 
    from employee 
-- natural join 시 같은 이름의 컬럼이 없다면 cross join 처럼 동작함
-- natural join 시 같은 이름의 컬럼이 있다면 (inner) join  using(컬럼명) 처럼 동작함.
--        natural join department
        cross join department
    order by 1
        ;
desc employee;
desc department;



----- DDL 
--- create table
create table t1 ( birthday date, name varchar2(30) );
comment on column t1.birthday is '생년월일';
select * from t1;







SELECT EMP_NAME, SALARY, dept_code,
    LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 100, 0), 5) || ' %' 비율,
    LPAD(TRUNC(RATIO_TO_REPORT(SALARY) OVER( partition by dept_code) * 100, 0), 5) || ' %' 부서별비율,
    TO_CHAR(TRUNC(RATIO_TO_REPORT(SALARY) OVER() * 20000000, 0), 'L00,999,999') "추가로 받게될 급여"
FROM EMPLOYEE;


--ORA-00001: 무결성 제약 조건(KH.EMPLOYEE_PK)에 위배됩니다
update employee
    set emp_name='홍길동'
--    set emp_id = 209
--    where emp_name='홍길동'
;
select * from employee;
rollback;
delete from employee;

    
    
    