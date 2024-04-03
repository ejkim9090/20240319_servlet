-- 02-kh-17
--EMPLOYEE 테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--(단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
select emp_name
        , trunc(sysdate - hire_date)  "근무일수1"
        , trunc(sysdate - to_date('2023-03-21','yyyy-mm-dd'))  "근무일수2"
    from employee
;

-- 05-02(function)-03. 춘대학교 남자교수들의 만나이를 구하시오.
select professor_name, professor_ssn
            , birthday 생년월일
            , floor(months_between(sysdate , birthday)/12) 나이
            , months_between(sysdate , birthday)/12 O살아온달
            , floor(sysdate - birthday)/365 x살아온날
    from 
        --tb_professor
        (select  
                case 
                    when substr(professor_ssn,1,2) > to_char(sysdate, 'yy')  
                        then to_date(to_char(sysdate, 'yy') - mod(to_char(sysdate, 'yy'),10)-1||substr(professor_ssn,1,6))
                    else
                        to_date( substr(professor_ssn,1,6) , 'yymmdd')
                end birthday
                ,professor_name, professor_ssn
            from tb_professor
            where substr(professor_ssn, 8, 1) in ('1','3')
            ) t1
    order by 나이 asc
    ;
select -mod(2024,10)-1 from dual; 
select to_char(sysdate, 'yy') - mod(to_char(sysdate, 'yy'),10)-1 from dual;
select 19||substr(professor_ssn,1,6)  from tb_professor;
select to_char(sysdate,'yy')||substr(professor_ssn,1,6)  from tb_professor;
select  
        case 
            when substr(professor_ssn,1,2) > to_char(sysdate, 'yy')  
                then to_date(to_char(sysdate, 'yy') - mod(to_char(sysdate, 'yy'),10)-1||substr(professor_ssn,1,6))
            else
                to_date( substr(professor_ssn,1,6) , 'yymmdd')
        end birthday
        ,to_date( substr(professor_ssn,1,6) , 'rrmmdd'  ) a1
        ,to_date( substr(professor_ssn,1,6) , 'yymmdd'  ) a2
    from tb_professor;   
-- 시간날짜 나타내는 설정 변경
alter session set nls_date_format='yyyy-mm-dd hh24:mi:ss';





--05-02(function)-13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오. 
select  department_no, count( decode(absence_yn, 'Y', absence_yn, null ) ) cnt
            , count( decode(absence_yn, 'Y', 99 ) ) cnt_simple
    from tb_student
    --where absence_yn = 'Y'
    group by department_no
    order by department_no
    ;


--05-02(function)- 14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가? 
select b.student_name, b.동명이인 
    from (select b.student_name, count(*) as 동명이인 from tb_student b
                group by student_name) b
    where b.동명이인 >= 2;

--
--11. 학생이름, 학과이름, 담당교수이름으로 VIEW 구성
-- 지도교수가 없는 학생이 있을수 있음을 고려하기
-- SELECT 만 할 경우 학과별로 정렬되어 화면에 보여지게 하기
CREATE or replace VIEW VW_OFFICEHOUR AS 
SELECT S.STUDENT_NAME, D.DEPARTMENT_NAME, P.PROFESSOR_NAME
    FROM TB_STUDENT S
        left outer JOIN TB_PROFESSOR P ON P.PROFESSOR_NO = S.COACH_PROFESSOR_NO
        JOIN TB_DEPARTMENT D ON D.DEPARTMENT_NO = S.DEPARTMENT_NO
    order by DEPARTMENT_NAME
    ;

select * from VW_OFFICEHOUR;
select * FROM TB_STUDENT;
    


--05_03_SELECT(Option)_

-- 05_03_SELECT(Option)_18
-- 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하시오
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                     FROM TB_GRADE
                     WHERE STUDENT_NO IN (SELECT STUDENT_NO
                                         FROM TB_STUDENT
                                         WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                                                                FROM TB_DEPARTMENT
                                                                WHERE DEPARTMENT_NAME = '국어국문학과'))
                     GROUP BY STUDENT_NO);

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
     JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '국어국문학과'
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                     FROM TB_GRADE
                          JOIN TB_STUDENT USING(STUDENT_NO)
                          JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                     WHERE DEPARTMENT_NAME = '국어국문학과'
                     GROUP BY STUDENT_NO);

SELECT STUDENT_NO, STUDENT_NAME
FROM (SELECT STUDENT_NO, STUDENT_NAME, AVG(POINT)
      FROM TB_GRADE
           JOIN TB_STUDENT USING(STUDENT_NO)
      WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                             FROM TB_DEPARTMENT
                             WHERE DEPARTMENT_NAME = '국어국문학과')
      GROUP BY STUDENT_NO, STUDENT_NAME
      ORDER BY AVG(POINT) DESC)
WHERE ROWNUM = 1;

--05_03_SELECT(Option)
--9. 8번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
select class_name, professor_name
    from tb_class tc
        join tb_class_professor tcp using (class_no)
        join tb_professor tp using(professor_no)
    where tc.department_no in (select department_no 
                    from tb_department
                    where category='인문사회')
--    order by class_name
;
select class_name, professor_name
    from tb_class tc
        join tb_class_professor tcp using (class_no)
        join tb_professor tp using(professor_no)
        join tb_department td on (tc.department_no = td.department_no)
    where category='인문사회'
;


--02_KH_25. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--전체 직원 수, 2001년, 2002년, 2003년, 2004년
select count(*) 전체직원수 
    ,  count( decode( extract(year from hire_date), '2001', 0, null  ) ) "2001년"
    ,  count( decode( extract(year from hire_date), '2002', 0, null  ) )  "2002년"
    ,  count( decode( extract(year from hire_date), '2003', 0, null  ) )  "2003년"
    ,  count( decode( extract(year from hire_date), '2004', 0, null  ) )  "2004년"
    from employee
;
select count(*) from employee where extract(year from hire_date) = '2001'
;
select count( decode( extract(year from hire_date), '2001', 0, null  ) ) from employee
;
select extract(year from hire_date)  from employee;
select *     from employee;


--04_KH_8. 한 사원과 같은 부서에서 일하는 사원의 이름 조회
select t1.emp_name, t1.dept_code, t2.emp_name
    from employee t1
        join employee t2 on (t1.dept_code = t2.dept_code)
    where t1.emp_name <> t2.emp_name
    order by t1.emp_name, t2.emp_name
;
--04_KH_11. 부서 별 급여 합계가 전체 급여 총 합의 20%보다 많은 부서의 부서 명, 부서 별 급여 합계 조회
--11-1. JOIN과 HAVING 사용
--11-2. 인라인 뷰 사용
--11-3. WITH 사용
select dept_title , sum(salary)
    from employee e
        join department d on (e.dept_code=d.dept_id)
    group by dept_title
    having sum(salary) > any( select sum(salary)*0.2 from employee) 
;
select dept_title , sum(salary)
    from ( select dept_title, salary from employee e join department d on (e.dept_code=d.dept_id)) t1
    group by dept_title
    having sum(salary) > any( select sum(salary)*0.2 from employee) 
;
select dept_title , sum_sal
    from ( select dept_title, sum(salary) sum_sal
            from employee e join department d on (e.dept_code=d.dept_id)
            group by dept_title
        ) t1
    where sum_sal > any( select sum(salary)*0.2 from employee) 
;
with t1 as ( select dept_title, sum(salary) sum_sal
                from employee e join department d on (e.dept_code=d.dept_id)
                group by dept_title
            ) 
select dept_title, sum_sal from t1 where sum_sal > any( select sum(salary)*0.2 from employee)
;
select * from department;


--05_02(Function)-15.
--학번이 A112113 인 김고은 학생의 년도, 학기 별 평점과 년도 별 누적 평점, 
--총평점을 SQL 문을 작성하시오.(단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
select * from tb_student where student_no = 'A112113';
select * from tb_grade where student_no = 'A112113';


SELECT SUBSTR(TERM_NO, 1, 4) 년도, SUBSTR(TERM_NO, 5, 2) 학기, ROUND(AVG(POINT), 1) 평균
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP(SUBSTR(TERM_NO, 1, 4), SUBSTR(TERM_NO, 5, 2))
ORDER BY 1; 


select nvl(년도, ' ') 년도, nvl(학기, ' ') , avg_point from (
select  decode( grouping(substr(term_no, 1,4)) , 1, '',substr(term_no, 1,4)) 년도,
        decode( grouping(substr(term_no, 5,2)) , 1, '',substr(term_no, 5,2)) 학기 , 
        round(avg(point),1) avg_point
    from tb_grade 
    where student_no = 'A112113'
    group by rollup( (substr(term_no, 1,4)) , (substr(term_no, 5,2)) )
    order by 1 nulls last
    ) tb1
;

select decode(년도, '집계', '', 년도 ) 년도, decode(학기, '집계', ' ', 학기 ) 학기, avg_point from (
    select  decode( grouping(substr(term_no, 1,4)) , 1, '집계',substr(term_no, 1,4)) 년도,
            decode( grouping(substr(term_no, 5,2)) , 1, '집계',substr(term_no, 5,2)) 학기 , 
            round(avg(point),1) avg_point
        from tb_grade 
        where student_no = 'A112113'
        group by rollup( (substr(term_no, 1,4)) , (substr(term_no, 5,2)) )
        order by 1, 2
    ) tb1
;
select '' c1 from dual;
-- oracle은 Empty string 을 지원하지 않음. 
-- Oracle empty string converts to null.
--오라클에서는 ''(empty string) 과 NULL 은 동일합니다.
--하지만 PostgreSQL 에서는 '' 은 절대 NULL 이 아닙니다.

insert into tb_grade values('' ,'A112113','',5.0);



-- 05-04(DML)-15
SELECT 과목번호, 과목이름, "누적수강생수(명)"
FROM (SELECT CLASS_NO 과목번호, CLASS_NAME 과목이름, COUNT(*) "누적수강생수(명)"
      FROM TB_GRADE
           JOIN TB_CLASS USING(CLASS_NO)
      WHERE TERM_NO LIKE '2009%'
            OR TERM_NO LIKE '2008%'
            OR TERM_NO LIKE '2007%'
            OR TERM_NO LIKE '2006%'
            OR TERM_NO LIKE '2005%'
      GROUP BY CLASS_NO, CLASS_NAME
      ORDER BY 3 DESC)
WHERE ROWNUM <= 3;
--- 최근 3년간, cnt 많은 3등까지
select class_no, class_name, cnt 
    from (
        select rownum rn, class_no, cnt  from (
            select class_no, count(*) cnt from tb_grade
            --  최근3년
                where substr(term_no,1,4) in 
                (select uq_term curr_term 
                    from (select rownum rn, uq_term 
                            from (select distinct substr(term_no,1,4) uq_term 
                                    from tb_grade  order by uq_term desc)
                          ) tb1 where rn <= 3
                )
                group by class_no
                order by cnt desc 
        ) 
    ) tb1
   join tb_class using (class_no)
   -- cnt 많은 3등까지
where rn <= 3;

select count(*) from tb_grade;
select count(*) from tb_student;
select count(*) from tb_student where absence_yn='Y';







