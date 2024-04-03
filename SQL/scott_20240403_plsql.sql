--- 2024.04.03
------------------PL/SQL--------------

-- conn session 연결 후 1번만 실행 - session 끊어지고 다시 접속하면 off 상태임.
-- console 창 처럼 디버깅 창에 결과를 볼 수 있게 해줌.
set serveroutput off;

-- sql developer 프로그램 메뉴 보기 > DBMS 출력 창 + 계정접속 한 후 확인가능함.

---- pl/sql 의 기본 모양
begin 
    dbms_output.put_line('hello world');
end;
/
declare 
    v_empno emp.empno%type;
    v_ename emp.ename%type;
begin
--ORA-06550: 줄 5, 열5:PLS-00428: 해당 SELECT 문에 INTO 절이 필요합니다.
-- declare 부터 줄5의미함
dbms_output.put_line('----1');
    select empno, ename
    into v_empno, v_ename
    from emp
--    where empno='&abc'
    ;
--    01403. 00000 -  "no data found"
    dbms_output.put_line('----2');
    dbms_output.put_line(v_empno || ':' || v_ename);
    dbms_output.put_line('----3');
end;
/
--desc emp;
--    select empno, ename
--    from emp
--    where empno=7788;
declare 
-- table == java 배열, arraylist
        type empno_table_type is table of emp.empno%type index by BINARY_INTEGER;
    v_arr_no      empno_table_type ;
        type ename_table_type is table of emp.ename%type index by BINARY_INTEGER;
    v_arr_name    ename_table_type;
    
    v_idx BINARY_INTEGER := 0;
begin
    dbms_output.put_line(v_idx);
    
    for vo in (select * from emp) loop
        -- 여기를 여러번 반복
--        dbms_output.put_line(v_idx);
--        dbms_output.put_line(vo.empno ||':'||vo.sal);

        v_idx := v_idx+1;

        v_arr_no(v_idx) := vo.empno;
        v_arr_name(v_idx) := vo.ename;
        dbms_output.put_line(v_idx || ':' || v_arr_no(v_idx)  ||':'||v_arr_name(v_idx));    
--        v_idx := v_idx+1;
    end loop;
    
    
--    for i in 2..9 loop
--        for j in 1..9 loop
--            dbms_output.put_line(i||'*'||j||'='||i*j);
--        end loop;
--    end loop;

    dbms_output.put_line(v_idx);
--    for i in 0..v_idx-1 `loop
    for i in 1..v_idx loop
        dbms_output.put_line(v_arr_no(i) );
    end loop;
    
end;
/
DECLARE
    AAA_UK EXCEPTION;
    PRAGMA EXCEPTION_INIT(AAA_UK, -00001);
    BBB_OVERFLOW EXCEPTION;
    PRAGMA EXCEPTION_INIT(BBB_OVERFLOW, -01438 );
BEGIN
    UPDATE emp 
    SET empno = 7369
    WHERE empno = 7788;
EXCEPTION
    WHEN AAA_UK
    THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
    WHEN BBB_OVERFLOW
    THEN DBMS_OUTPUT.PUT_LINE('4자리 숫자입력해주세요. 자릿수보다 큰 값은 허용되지 않습니다.');
END;
/
--    UPDATE emp 
--    SET empno = 73691111
--    WHERE empno = 7788;
----    ORA-00001: 무결성 제약 조건(SCOTT.PK_EMP)에 위배됩니다
----ORA-01438: 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.
----ORA-12899: "SCOTT"."T8"."C1" 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
--select * from emp;

create or replace procedure proc_test2
is
    AAA_UK EXCEPTION;
    PRAGMA EXCEPTION_INIT(AAA_UK, -00001);
    BBB_OVERFLOW EXCEPTION;
    PRAGMA EXCEPTION_INIT(BBB_OVERFLOW, -01438);
BEGIN
    UPDATE emp 
    SET empno = 7369
    WHERE empno = 7788;
EXCEPTION
    WHEN AAA_UK
    THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다.');
    WHEN BBB_OVERFLOW
    THEN DBMS_OUTPUT.PUT_LINE('자릿수보다 큰 값은 허용되지 않습니다. 4자리 숫자입력해주세요.');
END;
/

exec proc_test1;

--select * from user_sequences;
--select * from user_tables;
--select * from user_source;

--SELECT_EMPID(200, :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);
create or replace procedure pro_select_empno ( 
      v_empno   in    emp.empno%type, 
      v_ename   out   emp.ename%type, 
      v_sal     out   emp.sal%type, 
      v_comm    out   emp.comm%type  
)
is
begin
    select  ename, sal, comm
    into v_ename, v_sal, v_comm
    from emp
    where empno = v_empno;
end;
/

variable a_name varchar2(100);
variable a_sal number;
variable a_comm number;
exec pro_select_empno(7788, :a_name, :a_sal, :a_comm);
print a_name;
print a_sal;


































