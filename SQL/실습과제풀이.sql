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
select  department_no
    from tb_student
    where absence_yn = 'Y'
    
    ;















