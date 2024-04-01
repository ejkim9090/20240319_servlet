-- 2024.03.27
-- join 

select * from emp;
select * from dept;
-- smith 로그인 - 마이페이지를 들어감
select empno, ename, job, mgr, hiredate, sal, emp.deptno, dept.deptno, dname, loc 
    from emp , dept
    where 
-- ename = 'SMITH' 
--   and 
   emp.deptno = dept.deptno
;
select empno, ename, job, mgr, hiredate, sal, emp.deptno, dept.deptno, dname, loc 
--    from emp cross join dept -- join 조건 필요없음. 카테시안곱Cartesian Product (경우의수모두)
    from emp join dept on emp.deptno = dept.deptno
    where ename = 'SMITH' 
;
select empno, ename, job, mgr, hiredate, sal, deptno, deptno, dname, loc 
    from emp join dept using (deptno)
    where ename = 'SMITH' 
;
--ORA-25154: USING 절의 열 부분은 식별자를 가질 수 없음
--25154. 00000 -  "column part of USING clause cannot have qualifier"
--*Cause:    Columns that are used for a named-join (either a NATURAL join
--           or a join with a USING clause) cannot have an explicit qualifier.
--*Action:   Remove the qualifier.


select * from emp join dept using (deptno);
select * from emp join dept on emp.deptno = dept.deptno;


select emp.*, dname, loc from emp join dept on emp.deptno = dept.deptno;
select emp.*, dept.*, ename re_ename, sal re_sal, loc re_loc from emp join dept on emp.deptno = dept.deptno;

select * from emp join salgrade on emp.sal >= salgrade.losal and emp.sal <= salgrade.hisal;
select * from emp join salgrade on emp.sal between salgrade.losal and salgrade.hisal;
select * from emp e join salgrade s on e.sal between s.losal and s.hisal;
select * from emp e join salgrade s on e.sal between s.losal and s.hisal order by s.grade;
select * 
    from emp 
        join salgrade on sal between losal and hisal 
    order by grade;
    
select * from emp e join salgrade s on sal between s.losal and s.hisal order by s.grade;

select * from emp left outer join dept using (deptno);
select * from dept left outer join emp using (deptno);
select * from emp right outer join dept using (deptno);

select * from emp , dept where emp.deptno = dept.deptno(+);
select * from emp , dept where emp.deptno(+) = dept.deptno;

select * from dept full outer join emp using (deptno);

select * from emp join dept on emp.deptno = dept.deptno;


select * from dept join emp on emp.deptno = dept.deptno;

select e.*, d.dname, d.loc, s.grade 
    from emp e
        join dept d  on e.deptno = d.deptno
        join salgrade s  on e.sal between s.losal and s.hisal
;
select e1.*, e2.ename mgr_name, e2.deptno mgr_deptno
    from emp e1
        join emp e2 on e1.mgr = e2.empno
    ;
    
-- 평균급여보다 많은 급여를 받는 직원을 조회
select avg(sal) from emp;
select * from emp;
select deptno, max(sal) from emp group by deptno;
select * 
    from emp
    where sal >= (select avg(sal) from emp)
;
select * 
    from emp
--    where (deptno, sal) in (select deptno, max(sal) from emp group by deptno)
--    where (deptno, sal) in ( (20,3000), (30,2850), (10, 5000))
    where (deptno, sal) in (select deptno, max(sal) from emp where ename<>'KING' group by deptno)
;

select *
    from emp e 
        join (select deptno, avg(sal) avg_sal from emp group by deptno) sq
            on e.deptno = sq.deptno
    where e.sal > sq.avg_sal
;
select e.*, (select dname from dept sq where sq.deptno = e.deptno) dname
    from emp e 
    ;
----- 2024.03.28
--- natural join
select * 
--, empno, ename, dname
    from emp
-- natural join 시 같은 이름의 컬럼이 없다면 cross join 처럼 동작함
-- natural join 시 같은 이름의 컬럼이 있다면 (inner) join  using(컬럼명) 처럼 동작함.
--        natural join dept
        join dept using(deptno)
;

--- subquery
-- 단일행 -1 group by 없이 그룹함수 사용
select count(distinct comm) from emp ;
-- 단일행 -2  where PK컬럼명 = 값
select * from emp where empno = 7499;


-- 연산자 
SELECT empno, ename, sal FROM emp
--SALESMAN’ 들의 급여 중 최소값보다 많은 급여를 받는 사원들이 출력된다
--WHERE sal > ANY (SELECT sal FROM emp WHERE JOB='SALESMAN');
--WHERE sal > (SELECT min(sal) FROM emp WHERE JOB='SALESMAN');

--SALESMAN’들의 급여와 같은 급여를 받는 사원을 조회
--WHERE sal = ANY (SELECT sal FROM emp WHERE JOB='SALESMAN');

-- ‘MANAGER’ 사원들 중 최고 급여보다 많은 급여를 받는 사원들이 조회된다
WHERE sal > ALL (SELECT sal FROM emp WHERE JOB='MANAGER');
--WHERE sal > (SELECT max(sal) FROM emp WHERE JOB='MANAGER');



SELECT empno, ename, sal FROM emp e
--관리자로 등록되어 있는 사원들을 조회
WHERE exists (SELECT s.empno FROM emp s WHERE s.mgr = e.empno );

--- sysdate, rownum
select sysdate, a from (select sysdate a from dual) 
    where sysdate > to_date('2024-03-28 10:36:24' , 'yyyy-mm-dd hh24:mi:ss')
;
-- 시간날짜 나타내는 설정 변경
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';

select t1.*, rownum r2
    from (
        select ename, sal, hiredate, rownum r1
            from emp
            order by hiredate desc
    ) t1
    ;
-- 1-5
select * 
    from (select t1.*, rownum r2
        from (
            select ename, sal, hiredate, rownum r1
                from emp
                order by hiredate desc
        ) t1
    )t2
--    where r2 between 1 and 5
    where r2 between 6 and 10
    ;
with t1 as (select ename, sal, hiredate, rownum r1 from emp order by hiredate desc)
select *
    from t1
;

---  분석함수
--ORA-30484: 이 함수에 대한 윈도우 지정이 없습니다
--30484. 00000 -  "missing window specification for this function"
-- 조치방법 over()
--ORA-30485: 윈도우 지정에 ORDER BY 표현식이 없습니다
--30485. 00000 -  "missing ORDER BY expression in the window specification"
-- rank() 
with t1 as (select ename, sal, hiredate
            , dense_rank() over(order by sal desc) r1
            from emp)
select * from t1 
--    where r1 between 6 and 10
;



--현재 조회한(select에 나열된) 컬럼이 아닌 다른 컬럼값으로 정렬하고자 한다면,
-- ORDER BY 에 서브커리를 사용
-- 부서이름으로 정렬하여 emp테이블의 정보를 조회
SELECT EMPNO, ENAME, DEPTNO, HIREDATE
--    , (SELECT LOC
--            FROM DEPT
--            WHERE DEPTNO = E.DEPTNO) loc
FROM EMP E
ORDER BY (SELECT LOC
            FROM DEPT
            WHERE DEPTNO = E.DEPTNO) DESC;
select * from dept order by dname;





--분석함수 : AVG, SUM, MAX, MIN, COUNT 
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
--00937. 00000 -  "not a single-group group function"
select ename, deptno, sal, sum(sal) over() a, sum(sal) over(partition by deptno) b
    from emp
;
select sum(sal) from emp;
--- 순위함수 : RANK, DENSE_RANK, ROW_NUMBER, NTILE
--- 집계함수 : SUM, MIN, MAX, AVG, COUNT
--- 기타함수 : LEAD, LAG, FIRST_VALUE, LAST_VALUE, RATIO_TO_REPORT
--- 분석함수(?) : KEEP, LISTAGG

select ename, deptno, sal, sum(sal) over(partition by deptno) a
        , rank() over( ORDER by sal desc) b
        , rank() over(partition by deptno ORDER by sal desc) b
    from emp
    order by deptno
;






SELECT EMPNO, DEPTNO, SAL
    , SUM(SAL) OVER () "win1과동일"
    , SUM(SAL) OVER (ORDER BY EMPNO) "win0"
    , SUM(SAL) OVER (ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND current row) "win0-1"
    , SUM(SAL) OVER (ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) "win1"
        -- rows : 부분그룹인 윈도우의 크기를 물리적인 단위로 행집합을 지정
        -- unbounded preceding : 윈도우의 첫행
        -- unbounded following : 윈도우의 마지막행
        -- current row : 현재 행
        -- 1 PRECEDING : 현재 행을 중심으로 n번째 이전행
        -- 1 FOLLOWING : 현재 행을 중심으로 n번째 다음행
    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO) "win2-0"
    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "win2"
        -- 윈도우의 시작행에서 현재 위치(current row) 까지의 합계를 구해서 win2에
    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) "win3"
        -- 현재 위치에서 윈도우의 마지막행까지의 합계를 구해서 win3에
        
    , SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY EMPNO ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) "win4" 
        -- 1 preceding and 1 following 
        -- 현재 행을 중심으로 이전행과 다음행의 급여합계
    FROM EMP
--    WHERE DEPTNO = 30
    ; 





--Lag(조회할 범위, 이전위치, 기준 현재위치) 
SELECT ENAME, DEPTNO, SAL
    , LAG(SAL, 2, 0) OVER (ORDER BY SAL) 이전값
        -- 1 : 위의 행값, 0 : 이전행이 없으면 0 처리함
--    , LAG(SAL, 1, SAL) OVER (ORDER BY SAL) "조회2"
--        -- 이전행이 없으면 현재 행의 값을 출력
--    , LAG(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "조회3"
--        -- 부서 그룹안에서의 이전 행값 출력
FROM EMP; 

SELECT ENAME, DEPTNO, SAL
    ,LEAD(SAL, 2, 0) OVER (ORDER BY SAL) 다음값
        -- 1 : 다음 행값, 0 : 다음행이 없으면 0 처리함
--    ,LEAD(SAL, 1, SAL) OVER (ORDER BY SAL) "조회2",
--        -- 다음행이 없으면 현재 행의 값을 출력
--    ,LEAD(SAL, 1, SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL) "조회3"
        -- 부서 그룹안에서의 다음 행값 출력
FROM EMP; 


SELECT DEPTNO, ENAME, SAL
 , FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) as DEPT_RICH 
FROM EMP;
SELECT DEPTNO, ENAME, SAL
 , FIRST_VALUE(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) as DEPT_RICH 
FROM EMP;

SELECT DEPTNO, ENAME, SAL
 , LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as DEPT_RICH 
FROM EMP;

-----

----- DDL 
--- create table
create table t1 ( birthday date, name varchar2(30) );
comment on column t1.birthday is '생년월일';
insert into t1 values ( sysdate, null );
insert into t1 values ( null, null );
drop table t1;
create table t1 ( birthday date, name varchar2(30) not null );
insert into t1 values ( sysdate, null );
--ORA-01400: NULL을 ("SCOTT"."T1"."NAME") 안에 삽입할 수 없습니다
insert into t1 values ( null, '홍길동');
insert into t1 values ( null, '홍길동');
drop table t1;
create table t1 ( birthday date, name varchar2(30) unique );
--ORA-00001: 무결성 제약 조건(SCOTT.SYS_C008440)에 위배됩니다
insert into t1 values ( null, '홍길동');
select * from user_constraints where constraint_name='SYS_C008440'; 
insert into t1 values ( null, '홍길동2');
select * from t1;
drop table t1;
create table t1 ( birthday date, name varchar2(30) unique
            , gender char(1) check(gender in ('f','m')) );
insert into t1 values ( null, '홍길동', 'a');
--ORA-02290: 체크 제약조건(SCOTT.SYS_C008442)이 위배되었습니다
-- 딕셔너리 확인
select * from user_constraints where constraint_name='SYS_C008442'; 
insert into t1 values ( null, '홍길동', 'f');

drop table t1;
create table t1 ( birthday date, name varchar2(30) primary key);
insert into t1 values ( null, '홍길동');
-- 딕셔너리 확인
select * from user_constraints where constraint_name='SYS_C008474'; 
select * from user_cons_columns where constraint_name='SYS_C008474';

drop table t2;
drop table t1;

create table t1 ( birthday date, name varchar2(30) primary key);
insert into t1 values ( null, '홍길동');
insert into t1 values ( null, '홍길동2');
create table t2 ( gender char(1) check(gender in ('m','f')) 
                    , name varchar2(30) references t1(name) on delete set null );
insert into t2 values (null, '홍홍홍'); --ORA-02291: 무결성 제약조건(SCOTT.SYS_C008476)이 위배되었습니다- 부모 키가 없습니다
insert into t2 values (null, '홍길동');
insert into t2 values (null, '홍길동2');
insert into t2 values (null, '홍길동3');
commit;

--ORA-02292: 무결성 제약조건(SCOTT.SYS_C008476)이 위배되었습니다- 자식 레코드가 발견되었습니다
--update t1 set name='홍길동3' where name='홍길동2';
delete from t1 where name='홍길동2';


create table t3 ( c1 number,
            c2 number,
            c3 number,
            primary key(c2, c3)
            );
create table t4 ( c4 number,
            c5 number,
            c2 number,
            c3 number,
            foreign key (c2, c3) references t3(c2, c3)
            );


create table t5 ( c1 number primary key,
               c2 number);
insert into t5 values(10,1);

create table t6 ( c1 number,
               c2 number references t5(c1) );
insert into t6 values(1,10);
insert into t6 values(3,10);


                    
select * from t1;
select * from t2;

drop table t7;
create table t7 (
    c1 number constraint t7_pk_c1 primary key,
    c2 number constraint t7_nn_c2 not null,
    c3 number constraint t7_uk_c3 unique,
    c4 number constraint t7_fk_c4 references dept
);


create table emp_copy
    as select * from emp;
select * from emp_copy;
create table emp_copy2
    as select * from emp where 1<>1;
select * from emp_copy2;
-- 검색 기능에 많이 쓰임
select * from emp where 1<>0;
select * from emp where 1<>1;


delete from emp_copy;
rollback;
truncate TABLE emp_copy;

select * from emp_copy where 1<>0 and comm>3000 and deptno>20;

desc dept;




-------  oracle 의 성능이 우수한 이유 - 개인적 의견
----- dictionary 딕셔너리 
select * from user_constraints; 
select * from user_cons_columns;
select * from user_tables;
select * from user_indexes;
select * from user_views;
select * from user_sequences;


select * --grade, e.ename
from emp e
join salgrade s on e.sal between s.losal and s.hisal
where 
    e.sal between (select avg(e2.sal)*0.9 from emp e2 join salgrade s1 on e2.sal between s1.losal and s1.hisal where grade = s.grade)
    and (select avg(e3.sal)*1.1 from emp e3 join salgrade s2 on e3.sal between s2.losal and s2.hisal  where grade = s.grade)
;


select * from user_tables;
select * from user_views;
select * from user_constraints;
select * from user_cons_columns;
create table t8 (
    c1 varchar2(10),
    c2 nvarchar2(10),
    c3 char(10),
    c4 nchar(10)
);
insert into t8 values ('1234567890','1234567890','1234567890','1234567890');
insert into t8 values ('123456789가','123456789가','123456789가','123456789가');
--ORA-12899: "SCOTT"."T8"."C1" 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
insert into t8 values ('1234567가','123456789가','123456789가','123456789가');
--ORA-12899: "SCOTT"."T8"."C3" 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
insert into t8 values ('1234567가','123456789가','1234567가','123456789가');
-- OK
insert into t8 values ('1234567가','가나다라마바사아자차','1234567가','가나다라마바사아자차');
-- OK
insert into t8 values ('1234567가','가나다라마바사아자ab','1234567가','가나다라마바사아자차');
insert into t8 values ('1234567가','가나다라마','1234567가','가나다라마');
insert into t8 values ('1234567가','가나다라마','1234567','가나다라마');
select * from t8
    where  1=1
--    and c2 = '가나다라마'
--    and c4 = '가나다라마     '
--    and c3='1234567'
    and c3='1234567   '
;
create table t13 (
    c1 varchar2(4000),
    c2 nvarchar2(2000),
    c3 char(2000),
    c4 nchar(1000)
);
--*Cause:    for datatypes CHAR and RAW, the length specified was > 2000;
--           otherwise, the length specified was > 4000.















