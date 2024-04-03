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
--    for i in 0..v_idx-1 loop
--        
--    end loop;
    
end;
/





