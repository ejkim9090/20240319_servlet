------------------------SEMIM BOARD DML -------------------------
DROP SEQUENCE "SEQ_BOARD_ID";
CREATE SEQUENCE "SEQ_BOARD_ID";
--- & 대체입력창이 아니라 문자그대로 동작하도록 함.
set define off;
--set feedback off

--DROP TABLE "LOGIN_LOG";

--DROP TABLE "BOARD_REPLY";
--DROP TABLE "BOARD_REPORT";
--DROP TABLE "BOARD_FILE";
--    DROP TABLE "BOARD";
--        DROP TABLE "MEMBER";

--- insert 순서는 drop 반대순서

---------- TABLE MEMBER insert
--DESC MEMBER;
--MEM_ID    NOT NULL VARCHAR2(20)  
--MEM_PWD   NOT NULL VARCHAR2(20)  
--MEM_EMAIL NOT NULL VARCHAR2(100) 
INSERT INTO MEMBER VALUES ('kh1', 'pwd1', 'kh1@a.com');
INSERT INTO MEMBER VALUES ('kh2', 'pwd2', 'kh2@a.com');
INSERT INTO MEMBER VALUES ('kh3', 'pwd3', 'kh3@a.com');
INSERT INTO MEMBER VALUES ('kh4', 'pwd4', 'kh4@a.com');
INSERT INTO MEMBER VALUES ('kh5', 'pwd5', 'kh5@a.com');
---------- TABLE BOARD insert
--DESC BOARD;
--BOARD_ID     NOT NULL NUMBER         
--SUBJECT      NOT NULL VARCHAR2(120)  
--CONTENT      NOT NULL VARCHAR2(4000) 
--WRITE_TIME   NOT NULL TIMESTAMP(6)   
--LOG_IP                VARCHAR2(15)   
--BOARD_WRITER NOT NULL VARCHAR2(20)   
--READ_COUNT   NOT NULL NUMBER 
INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목1', '내용1', default, '127.0.0.1', 'kh1', default);
INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목2', '내용2', default, '127.0.0.1', 'kh2', default);
INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목3', '내용3', default, '127.0.0.1', 'kh3', default);
INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목4', '내용4', default, '127.0.0.1', 'kh1', default);
INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목5', '내용5', default, '127.0.0.1', 'kh1', default);
--select * from board ORDER BY WRITE_TIME DESC;

---------- TABLE BOARD_REPLY insert
DESC BOARD_REPLY;
--BOARD_REPLY_ID         NOT NULL NUMBER         
--BOARD_ID               NOT NULL NUMBER         
--BOARD_REPLY_WRITER     NOT NULL VARCHAR2(20)   
--BOARD_REPLY_CONTENT    NOT NULL VARCHAR2(4000) 
--BOARD_REPLY_WRITE_TIME NOT NULL TIMESTAMP(6)   
--BOARD_REPLY_LOG_IP              VARCHAR2(15)   
--BOARD_REPLY_LEVEL      NOT NULL NUMBER(2)      
--BOARD_REPLY_REF        NOT NULL NUMBER         
--BOARD_REPLY_STEP       NOT NULL NUMBER(3) 
-- BOARD_ID : 5 댓글들... 달기
-- 
(SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY);
-- 댓글 1 - 원본글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글1' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );
-- 댓글 - 원본글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글2' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );
-- 댓글 - 원본글 
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '댓글3' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );    

-- 1댓글 에 - 대댓글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대댓글1' , default , null, 
    2 , 1, 2  );
-- 1댓글 에 - 대대댓글
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대대댓글1' , default , null, 
    3 , 1, 3  );
    
-- 1댓글 에 - 대댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE BOARD_REPLY_STEP > 1;
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대댓글2' , default , null, 
    2 , 1, 2  );
--- 6 대댓글2에 대대댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE BOARD_REPLY_STEP > 2;
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '대대댓글2' , default , null, 
    3 , 1, 3  );

---- 3 에 댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE 
    BOARD_REPLY_REF = ( SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3)
    AND 
    BOARD_REPLY_STEP > ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3);
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '3번ㄷㄷ' , default , null, 
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  );

-- 댓글 - 원본글 
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '원ㄷ' , default , null, 
    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );    

---- 3 에 댓글
UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE 
    BOARD_REPLY_REF = ( SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3)
    AND 
    BOARD_REPLY_STEP > ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 ) ;
INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
    'kh1', '3번ㄷe' , default , null, 
    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  );
    
--select * from BOARD_REPLY ORDER BY BOARD_REPLY_REF DESC, BOARD_REPLY_STEP ASC;

--DELETE from BOARD_REPLY WHERE BOARD_REPLY_ID=5;
commit;

-------------------------- Procedure---------------------------------------------------
--  Procedure ------
create or replace NONEDITIONABLE PROCEDURE PRO_BOARD_INSERT 
(  P_WRITER_KEY BOARD.BOARD_WRITER%TYPE,
P_SUBJECT_STR BOARD.SUBJECT%TYPE,
P_MAXCOUNT NUMBER )
IS
    V_B BOARD%ROWTYPE;
    V_EXIST_MEMBER NUMBER := 0;
BEGIN
    -- MEMBER 여부 확인
    SELECT COUNT(*) INTO V_EXIST_MEMBER  FROM MEMBER WHERE MEM_ID=P_WRITER_KEY;
    IF (V_EXIST_MEMBER < 1 ) THEN
        DBMS_OUTPUT.PUT_LINE('멤버만 글쓰기 가능합니다.');
    ELSE
        FOR I IN 1..P_MAXCOUNT LOOP
                SELECT SEQ_BOARD_ID.NEXTVAL INTO V_B.BOARD_ID FROM DUAL;
                --INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목1', '내용1', 
                --default, '127.0.0.1', 'kh1', default);
                INSERT INTO BOARD 
                VALUES
                    (   V_B.BOARD_ID,
                        P_SUBJECT_STR||I,
                        '내용----'||I,
                        default,
                        '127.0.0.1',
                        P_WRITER_KEY,
                        default
                    );
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('글쓰기 완료');
        commit;
    END IF;
END;
/
------ procedure ----------
CREATE OR REPLACE PROCEDURE PRO_MEMBER_BOARD_INSERT 
(  P_MEMBER_ID_KEY MEMBER.MEM_ID%type
  ,P_MEMBER_EMAIL_DOMAIN MEMBER.MEM_EMAIL%type
  ,P_SUBJECT_STR BOARD.SUBJECT%type
  ,P_MAXCOUNT NUMBER )
IS
    V_M MEMBER%ROWTYPE;
    V_B BOARD%ROWTYPE;
BEGIN
    FOR I IN 1..P_MAXCOUNT LOOP
        V_M.MEM_ID := P_MEMBER_ID_KEY||I;
        
        INSERT INTO MEMBER VALUES 
        (V_M.MEM_ID, 'pwd'||I, P_MEMBER_ID_KEY||I||P_MEMBER_EMAIL_DOMAIN);
        
        SELECT SEQ_BOARD_ID.NEXTVAL INTO V_B.BOARD_ID FROM DUAL;
    
    --INSERT INTO BOARD VALUES (SEQ_BOARD_ID.nextval, '제목1', '내용1', 
    --default, '127.0.0.1', 'kh1', default);
        INSERT INTO BOARD VALUES
        ( V_B.BOARD_ID, P_SUBJECT_STR||I, '내용----'||I,
          default, '127.0.0.1', V_M.MEM_ID, default);
    END LOOP;
    commit;
END;
/
------------- procedure -----------
CREATE OR REPLACE PROCEDURE PRO_BOARD_REPLY_INSERT 
(  P_WRITER_KEY     BOARD_REPLY.BOARD_REPLY_WRITER%TYPE
  ,P_CONTENT_STR    BOARD_REPLY.BOARD_REPLY_CONTENT%TYPE
  ,P_RE_BOARD_ID    BOARD_REPLY.BOARD_ID%TYPE
  ,P_RE_BOARD_REPLY_ID  BOARD_REPLY.BOARD_REPLY_ID%TYPE)
IS
    V_M MEMBER%ROWTYPE;
    V_B BOARD%ROWTYPE;
    V_EXIST_MEMBER NUMBER := 0;
    V_EXIST_BOARD_ID NUMBER := 0;
    V_EXIST_BOARD_REPLY_ID NUMBER := 0;
    V_LEVEL NUMBER := 0;
    V_CONTENT BOARD_REPLY.BOARD_REPLY_CONTENT%TYPE;
BEGIN
    -- MEMBER 여부 확인
    SELECT COUNT(*) INTO V_EXIST_MEMBER 
    FROM MEMBER WHERE MEM_ID=P_WRITER_KEY;
    -- BOARD_ID 여부 확인
    SELECT COUNT(*) INTO V_EXIST_BOARD_ID 
    FROM BOARD WHERE BOARD_ID=P_RE_BOARD_ID;
    -- BOARD_REPLY_ID 여부 확인
    SELECT COUNT(*) INTO V_EXIST_BOARD_REPLY_ID 
    FROM BOARD_REPLY WHERE BOARD_REPLY_ID=P_RE_BOARD_REPLY_ID;
    
    IF (V_EXIST_MEMBER < 1 ) THEN
        DBMS_OUTPUT.PUT_LINE('멤버만 글쓰기 가능합니다.');
    ELSIF (V_EXIST_BOARD_ID < 1 ) THEN
        DBMS_OUTPUT.PUT_LINE('존재하지 않는 BOARD ID에 댓글을 작성할 수 없습니다.');
    ELSIF (V_EXIST_BOARD_REPLY_ID < 1 ) THEN
        DBMS_OUTPUT.PUT_LINE(P_RE_BOARD_REPLY_ID||'에 댓글을 작성합니다.');
        
        V_CONTENT := P_RE_BOARD_ID||'의 ㄷ '||P_CONTENT_STR;
        
        --INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
        --    'kh1', '원ㄷ' , default , null, 
        --    1 , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 1   );    
        INSERT INTO BOARD_REPLY VALUES
        ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY) , P_RE_BOARD_ID, 
            P_WRITER_KEY, V_CONTENT , default , null, 
            DEFAULT , (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), DEFAULT );
    ELSE
        -- 댓글내용 T내기
        SELECT BOARD_REPLY_LEVEL INTO V_LEVEL FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID;
        FOR I IN 1..V_LEVEL LOOP
            V_CONTENT := V_CONTENT||'*';
        END LOOP;
        V_CONTENT := V_CONTENT||P_RE_BOARD_REPLY_ID||'ㄷ '||P_CONTENT_STR;
        
        --UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE 
        --    BOARD_REPLY_REF = ( SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3)
        --    AND 
        --    BOARD_REPLY_STEP > ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 ) ;
        --INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), 5,
        --    'kh1', '3번ㄷe' , default , null, 
        --    (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
        --    (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  , 
        --    (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = 3 )  );
        UPDATE BOARD_REPLY SET BOARD_REPLY_STEP = BOARD_REPLY_STEP+1  WHERE 
            BOARD_REPLY_REF = ( SELECT BOARD_REPLY_REF FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID)
            AND 
            BOARD_REPLY_STEP > ( SELECT BOARD_REPLY_STEP FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID ) ;
        INSERT INTO BOARD_REPLY VALUES ( (SELECT NVL(MAX(BOARD_REPLY_ID),0)+1 FROM BOARD_REPLY), P_RE_BOARD_ID,
            P_WRITER_KEY, V_CONTENT , default , null, 
            (SELECT BOARD_REPLY_LEVEL+1 FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID )  , 
            (SELECT BOARD_REPLY_REF     FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID )  , 
            (SELECT BOARD_REPLY_STEP+1  FROM BOARD_REPLY WHERE BOARD_REPLY_ID = P_RE_BOARD_REPLY_ID )  );
    END IF;
    commit;
END;
/
----------- procedure table 만들기 - 참고용 --------------- 
create or replace procedure pro_create_table( p_user_id in varchar2, p_table_name out varchar2 )
is
    v_dbdate varchar2(10);
    v_createtablesql VARCHAR2(100);
    v_cursor INTEGER;
begin
    -- sysdate를 얻어옴
    SELECT TO_CHAR(SYSDATE,'RRRRMMDD')
    INTO v_dbdate
    FROM dual;

    -- table명 조합하기
    p_table_name := 'LOG_'||p_user_id||'_'||v_dbdate;
    
    -- CREATE TABLE명령어 생성
    v_createtablesql := 'CREATE TABLE ' || p_table_name || ' (c1 number, c2 varchar2(10))';
    
    --CREATE TABLE명령어 화면에 출력  
    DBMS_OUTPUT.PUT_LINE(v_createtablesql);
    
    -- 테이블 생성
    v_cursor := DBMS_SQL.OPEN_CURSOR;  
    DBMS_SQL.PARSE(v_cursor, v_createtablesql, dbms_sql.v7);
    DBMS_SQL.CLOSE_CURSOR(v_cursor);
end;
/
----- 참고용 ----
-----variable vtablename varchar2;
-----EXEC pro_create_table('EJ', :vtablename);
-----PRINT vtablename;
-----select * from log_ej_20240405;
-----drop table log_ej_20240405;


----------- member, board insert
EXEC PRO_MEMBER_BOARD_INSERT('K','@AAA.KH.COM', '제목--', 10);
----------- board insert
EXEC PRO_BOARD_INSERT('kh2', '제목----', 10);
----------- board_reply insert
--EXEC PRO_BOARD_INSERT('kh1', '제목----', 10);
--EXEC PRO_MEMBER_BOARD_INSERT('m','@AAA.KH.COM', '제목--', 10);
--EXEC PRO_BOARD_REPLY_INSERT('kh1','내용~', 3, 0);
--EXEC PRO_BOARD_REPLY_INSERT('kh1','내용~', 3, 1);
--EXEC PRO_BOARD_REPLY_INSERT('kh1','내용~', 3, 여기BOARD_REPLY_ID번호적기);
----------select * from BOARD_REPLY ORDER BY BOARD_REPLY_REF DESC, BOARD_REPLY_STEP ASC;

set define on;

--select * from MEMBER;
--select * from BOARD;
--select * from BOARD_REPLY;