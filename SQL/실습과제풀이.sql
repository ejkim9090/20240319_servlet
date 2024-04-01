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
        JOIN TB_DEPARTMENT D ON D.DEPARTMENT_NO = S.DEPARTMENT_NO
        left outer JOIN TB_PROFESSOR P ON P.PROFESSOR_NO = S.COACH_PROFESSOR_NO
    order by DEPARTMENT_NAME
    ;

select * from VW_OFFICEHOUR;
select * FROM TB_STUDENT;
    


--05_03_SELECT(Option)_

-- 05_03_SELECT(Option)_18
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




